%============================================================================
% Function: Thermodynamic Simulation of Adiabatic Compressed Air Energy Storage
% Author: Ricky (Rui Li) at Tsinghua University
% E-mail: eeairicky@gmail.com
% Version: 2.1 2019/03/17
%%% =============History===================================================
    % 2018/08/20 Energy Balance of Each Component
    % 2019/01/11 Initial Part-load Curve
    % 2019/02/01 Define the Data Format with TICC-500
    % 2019/02/11 Update Off-desgin Curve
    % 2019/02/15 Update Air Three ASU Module
    % 2019/02/15 Unify the variable with structure data format
    % 2019/02/16 Update the CP & SP operation in charging process
    % 2019/02/18 Provide visualization interface (V1.0)
    % 2019/02/20 Update the CP & SP operation in discharging process
    % 2019/03/05 Provide the exergy model interface with the  
    %            - "HOT: Thermodynamic Tools for Matlab"
    %            - http://hot-tdb.sourceforge.net/
    % 2019/03/17 Reduce the time step to save memory 
    
%%% ===========To=do=List=================================================
    % 通过储热罐质量平衡检查充放气终止条件
    % 系统参数自检功能(储气室压力运行范围与压缩机压缩比以及膨胀机膨胀比之间的匹配程度)
    % T_w 求解接口函数 (在m文件中Run已编好的Simulink模块)
    % 储热热功率的计算 (考虑利用进入储热罐的HTF温度与储热罐当前HTF温度计算)
%===========================================================================
clc
close all
clear all

%% Plot Option
DrawOption.lang = 'ch'; % 'en'
DrawOption.Charging = 1; 
DrawOption.Discharging = 1; 

%% load on-design dataset 
eval('StandardCAESData');

%% Component off-design curve 
% Compressor off-design curve 
Beta_Comp = [1.995 -1.895 0.8967];
Scale.Beta_Comp = @(m_ratio) Beta_Comp(1)*m_ratio.^2 + Beta_Comp(2)*m_ratio + Beta_Comp(3);
Eta_Comp = [3.45  -8.979  7.842 -1.309];
Scale.Eta_Comp = @(m_ratio) Eta_Comp(1)*m_ratio.^3 + Eta_Comp(2)*m_ratio.^2 + Eta_Comp(3)*m_ratio + Eta_Comp(4);

% Turbine off-design curve
Beta_Turb = [1.139 -0.32 0.1757];
Scale.Beta_Turb = @(m_ratio) Beta_Turb(1)*m_ratio.^2 + Beta_Turb(2)*m_ratio + Beta_Turb(3);
Eta_Turb = [4.111  -10.44  8.859 -1.534];
Scale.Eta_Turb = @(m_ratio) Eta_Turb(1)*m_ratio.^3 + Eta_Turb(2)*m_ratio.^2 + Eta_Turb(3)*m_ratio + Eta_Turb(4);

% Heat exchanger off-design curve
U_Both = [1.059 -0.05768];
Scale.U_HE =  @(m_ratio) U_Both(1)*m_ratio + U_Both(2);

% Get rated sigma of heat exchanger
Sigma_Rated = @(T1_in_air, T1_out_air, T2_in_water, CpQm1_air, CpQm_min) CpQm1_air*(T1_in_air-T1_out_air)/(CpQm_min*(T1_in_air-T2_in_water));
 
%% Operation Model Selection 
OperationMode = 2; 
switch OperationMode
    case 1 % CP-CP
        TV_Mode.Comp = 'CP';  
        TV_Mode.Turb = 'CP'; 
    case 2 % SP-CP 
        TV_Mode.Comp = 'SP';  
        TV_Mode.Turb = 'CP'; 
    case 3 % CP-SP
        TV_Mode.Comp = 'CP';  
        TV_Mode.Turb = 'SP'; 
    case 4 % SP-SP
        TV_Mode.Comp = 'SP';  
        TV_Mode.Turb = 'SP'; 
end

MassFlowMode = 'Fixed'; % Simulation setting 
% MassFlowMode = 'Part-load';
% MassFlowMode = 'Random'; 

%% Mathematic Model  
% on-desgin [0]/ off-desgin [1]
OFFDesign.Comp = 0; 
OFFDesign.Turb = 0; 

OFFDesign.HEC = 0; 
OFFDesign.HEH = 0; 

PressureDrop.HXC = 0;  
PressureDrop.HXH = 0; 

ASU_Model = 'VA'; % G/VT/VA 

%% Thermodynamic Constant
From_C_to_K = 273.15; 
From_Nm_to_kg = 1.2936; % this is specific to water?
From_Pa_to_KPa = 1e-3;
T_env = 293; % [K] Ambient temp
T_cs = 293; % [K] Temp of cold storage
T0 = 293; % used for exergy calculation
P_atm = 1.013*10^5; % [Pa] Atmospheric pressure
P_atm = P_atm*1e-3; % [KPa]
Ra = 286.7; % Gas constant [J/(Kg*K)]
Rg = Ra;  % check
Cva = Ra*(5/2); % Cv of the air
Cpa = Cva + Ra; 
k = Cpa/Cva; % Cp/Ca for air as an ideal diatomic gas 
lambda=(k-1)/k;
Cp.HTF = 4181.3; % [J/(kg*K)]
Cp.Air = Cpa; % [J/(kg*K)]
HTF.Name = 'H2O'; 

%% Rated Thermodynamic Parameters
eval('CAESReadRatedPara');

% Air Tank Model
P_as_max.SP = 10.0; % MPa
P_as_max.CP = 10.0; % MPa
P_as_min.SP = 4.0; % MPa
P_as_min.CP = 4.0; % MPa

P_as_max.SP = P_as_max.SP*1e3; % KPa
P_as_max.CP = P_as_max.CP*1e3;
P_as_min.SP = P_as_min.SP*1e3;
P_as_min.CP = P_as_min.CP*1e3; 

V_as = 100; % [m^3] (TICC-500 Size) can adjust
Pa0 = P_as_min.SP;  % [KPa] Initial pressure of the air
Ta0 = T_env; %[K]
M_Init = 10^3*Pa0*V_as/(Ra*Ta0); % [kg]

%% Simulation of one-cycle with rated mass flow rates
% 
tstep = 60; % [60s /step]
t_char = 8.0*3600/tstep; % [s] % this value should be larger to allocate space
t_disc = 2.0*3600/tstep; % [s] % this value should be larger to allocate space

TT_Char = 1:t_char;
TT_Disc = 1:t_disc;

eval('CAESThermoVariableDef');
eval('CAESThermoVariableExe'); % exergy definition 
eval('CAESPerformanceCurveDef'); 

if strcmp(MassFlowMode, 'Fixed')
    m_air.comp = m_c_rated*ones(1,length(TT_Char)); % [kg/s]
    m_air.turb = m_e_rated*ones(1,length(TT_Disc)); % [kg/s]
elseif strcmp(MassFlowMode, 'Part-load') %  'Part-load'
    base.comp = [0.8*ones(1,length(TT_Char)/3) 0.5*ones(1,length(TT_Char)/3) 0.75*ones(1,length(TT_Char)/3)];
    base.turb = [0.8*ones(1,length(TT_Disc)/3) 0.5*ones(1,length(TT_Disc)/3) 0.75*ones(1,length(TT_Disc)/3)];
    m_air.comp = m_c_rated*base.comp;
    m_air.turb = m_e_rated*base.turb;
elseif strcmp(MassFlowMode, 'Random')
    base.comp = rand(1,length(TT_Char));
    base.turb = rand(1,length(TT_Disc));
    m_air.comp = m_c_rated*base.comp;
    m_air.turb = m_e_rated*base.turb;
end

tt_char = 0;  % cycle index
tt_disc = 0;  

Stop_Char = 0;  % Flag
Stop_Disc = 0;

%% Charging 

T_a_in.c1 = (Compressor(1,6) + From_C_to_K)*ones(1,length(TT_Char)); % [K]
p_a_in.c1 = P_atm*ones(1,length(TT_Char)); % [KPa]

if strcmp(TV_Mode.Comp, 'CP') % CP mode 
    while ~Stop_Char 
       tt_char = tt_char + 1;
       % Compressor-train
       eval('CAESCompressorTrainCP'); 
       %% TV-Comp 
        if p_a_out.HXC5(tt_char) < P_as_max.CP
            warning('Air pressure is less than the default inlet pressure of TV under the CP mode!!!');
        else
            T_as_in(tt_char) = T_a_out.HXC5(tt_char);
            P_as_in(tt_char) = P_as_max.CP; % adjust
        end
        
       %% Air-Storage
        eval('ChargingASUCP');
        
       %% Stop Charging Condition
        if  P_as.Char(tt_char) >= P_as_max.CP % stop charging process
            Stop_Char = 1;  
            T_Char_End = tt_char;
            disp(['Charging ended at ' num2str(T_Char_End*tstep/3600) ' h!'])
        end
            
       %% TES-storage
        eval('ChargingTESCP');
    end
end

if strcmp(TV_Mode.Comp, 'SP')   % Compressor SP  
    while ~Stop_Char 
         tt_char = tt_char + 1;
         eval('CAESCompressorTrainSP');
         if tt_char == 1
             P_as_in_SP_Req(tt_char) = Pa0;
             T_as_in(tt_char) = Ta0; 
             P_as_in(tt_char) = Pa0;
             if  P_as_in_SP_Req(tt_char)/p_a_in.c1(tt_char)>(beta.c1_rated*beta.c2_rated*beta.c3_rated*beta.c4_rated)
                CompOn.c5(tt_char) = 1;
                CompOn.c4(tt_char) = 1;
                CompOn.c3(tt_char) = 1;
                CompOn.c2(tt_char) = 1;
                CompOn.c1(tt_char) = 1;
             elseif P_as_in_SP_Req(tt_char)/p_a_in.c1(tt_char)>(beta.c1_rated*beta.c2_rated*beta.c3_rated)
                CompOn.c4(tt_char) = 1;
                CompOn.c3(tt_char) = 1;
                CompOn.c2(tt_char) = 1;
                CompOn.c1(tt_char) = 1;
             elseif P_as_in_SP_Req(tt_char)/p_a_in.c1(tt_char)>(beta.c1_rated*beta.c2_rated)
                CompOn.c3(tt_char) = 1;
                CompOn.c2(tt_char) = 1;
                CompOn.c1(tt_char) = 1;
             elseif P_as_in_SP_Req(tt_char)/p_a_in.c1(tt_char)>(beta.c1_rated) 
                CompOn.c2(tt_char) = 1;
                CompOn.c1(tt_char) = 1;
             else
                CompOn.c1(tt_char) = 1;
             end
         else
             P_as_in_SP_Req(tt_char) = P_as.Char(tt_char-1);
             % determine the on/off state of each compressor
            if P_as_in_SP_Req(tt_char)/p_a_in.c1(tt_char)>(beta.c1_rated*beta.c2_rated*beta.c3_rated*beta.c4_rated)
                T_as_in(tt_char) = T_a_out.HXC5(tt_char);
                P_as_in(tt_char) = p_a_out.HXC5(tt_char);
                CompOn.c5(tt_char) = 1;
                CompOn.c4(tt_char) = 1;
                CompOn.c3(tt_char) = 1;
                CompOn.c2(tt_char) = 1;
                CompOn.c1(tt_char) = 1;
            elseif P_as_in_SP_Req(tt_char)/p_a_in.c1(tt_char)>(beta.c1_rated*beta.c2_rated*beta.c3_rated)
                T_as_in(tt_char) = T_a_out.HXC4(tt_char);
                P_as_in(tt_char) = p_a_out.HXC4(tt_char);
                CompOn.c4(tt_char) = 1;
                CompOn.c3(tt_char) = 1;
                CompOn.c2(tt_char) = 1;
                CompOn.c1(tt_char) = 1;
            elseif P_as_in_SP_Req(tt_char)/p_a_in.c1(tt_char)>(beta.c1_rated*beta.c2_rated)
                T_as_in(tt_char) = T_a_out.HXC3(tt_char);
                P_as_in(tt_char) = p_a_out.HXC3(tt_char);
                CompOn.c3(tt_char) = 1;
                CompOn.c2(tt_char) = 1;
                CompOn.c1(tt_char) = 1;
            elseif P_as_in_SP_Req(tt_char)/p_a_in.c1(tt_char)>(beta.c1_rated) 
                T_as_in(tt_char) = T_a_out.HXC2(tt_char);
                P_as_in(tt_char) = p_a_out.HXC2(tt_char);
                CompOn.c2(tt_char) = 1;
                CompOn.c1(tt_char) = 1;
            else
                CompOn.c1(tt_char) = 1;
                T_as_in(tt_char) = T_a_out.HXC1(tt_char);
                P_as_in(tt_char) = p_a_out.HXC1(tt_char);
            end
         end
         eval('ChargingASUSP');
         m_HTF.TES_in(tt_char) = [CompOn.c1(tt_char) CompOn.c2(tt_char) CompOn.c3(tt_char) CompOn.c4(tt_char) CompOn.c5(tt_char)]* ...
                                 [m_HTF.HXC1(tt_char) m_HTF.HXC2(tt_char) m_HTF.HXC3(tt_char) m_HTF.HXC4(tt_char) m_HTF.HXC5(tt_char)]';
         T_HTF.TES_in(tt_char) = [CompOn.c1(tt_char)*m_HTF.HXC1(tt_char) CompOn.c2(tt_char)*m_HTF.HXC2(tt_char) ...
                                  CompOn.c3(tt_char)*m_HTF.HXC3(tt_char) CompOn.c4(tt_char)*m_HTF.HXC4(tt_char) ...
                                  CompOn.c5(tt_char)*m_HTF.HXC5(tt_char)]*[T_HTF_out.HXC1(tt_char) T_HTF_out.HXC2(tt_char) ...
                                  T_HTF_out.HXC3(tt_char) T_HTF_out.HXC4(tt_char) T_HTF_out.HXC5(tt_char)]'/m_HTF.TES_in(tt_char);
         eval('ChargingTESSP'); 
        if  P_as.Char(tt_char) >= P_as_max.SP % stop charging process
            Stop_Char = 1;  
            T_Char_End = tt_char;
            disp(['Charging ended at ' num2str(T_Char_End*tstep/3600) ' h!'])
        end
    end
end

time_period_char = 1:T_Char_End;

%% DisCharging
P_as.disc0 = P_as.Char(T_Char_End);
M_as.disc0 = M_as.Char(T_Char_End);
T_as.disc0 = T_as.Char(T_Char_End);
M_TES.disc0 = M_TES.Char(T_Char_End);
T_TES.disc0 = T_TES.Char(T_Char_End);

while ~Stop_Disc
    tt_disc = tt_disc + 1;
     if strcmp(TV_Mode.Turb, 'SP')
         eval('DischargingASUSP');  % ASU storage
         p_as_out(tt_disc) = P_as.Disc(tt_disc); % attention
         if  P_as.Disc(tt_disc) <= P_as_min.SP % stop discharging process
            Stop_Disc = 1;  
            T_Disc_End = tt_disc;
            disp(['Discharging ended at ' num2str(T_Disc_End*tstep/3600) ' h!'])
         end
         eval('DischargingTESSP');  % TES storage
         eval('CAESExpansionTrainSP'); % Expansion train
     else
        eval('DischargingASUCP');
        p_as_out(tt_disc) = P_as_min.CP; % attention
        if  P_as.Disc(tt_disc) <= P_as_min.SP % stop discharging process
            Stop_Disc = 1;  
            T_Disc_End = tt_disc;
            disp(['Discharging ended at ' num2str(T_Disc_End*tstep/3600) ' h!'])
        end
        eval('DischargingTESCP'); % TES storage
        eval('CAESExpansionTrainCP'); % Expansion train
     end
end
time_period_disc = 1:T_Disc_End;

%% Performance Analysis
% Draw dynamic process
if DrawOption.Charging  
    eval('DrawCAESCharging');
end

if DrawOption.Discharging
    eval('DrawCAESDischarging');
end

% Calculate the round-trip efficiency

eta_elec2elec = sum(tstep/60*W_disc.all(time_period_disc))/sum(tstep/60*W_char.all(time_period_char))

% Exergy
% data = janload('nasa.fit');
load mydata.mat mydata
HTF_Pressure = 0.13; % [MPa] can be updated

% compressir
exergy_in.c1 = W_char.c1; % [J]
exergy_in.c2 = W_char.c2; % [J]
exergy_in.c3 = W_char.c3; % [J]
exergy_in.c4 = W_char.c4; % [J]
exergy_in.c5 = W_char.c5; % [J]

exergy_out.c1 = m_air.comp.*(Cp.Air*(T_a_out.c1-T_a_in.c1)- ...
                T0*(Cp.Air*log(T_a_out.c1./T_a_in.c1)-Rg*log(p_a_out.c1./p_a_in.c1))); % [J]
exergy_out.c2 = m_air.comp.*(Cp.Air*(T_a_out.c2-T_a_in.c2)- ...
                T0*(Cp.Air*log(T_a_out.c2./T_a_in.c2)-Rg*log(p_a_out.c2./p_a_in.c2)));
exergy_out.c3 = m_air.comp.*(Cp.Air*(T_a_out.c3-T_a_in.c3)- ...
                T0*(Cp.Air*log(T_a_out.c3./T_a_in.c3)-Rg*log(p_a_out.c3./p_a_in.c3)));
exergy_out.c4 = m_air.comp.*(Cp.Air*(T_a_out.c4-T_a_in.c4)- ...
                T0*(Cp.Air*log(T_a_out.c4./T_a_in.c4)-Rg*log(p_a_out.c4./p_a_in.c4)));
exergy_out.c5 = m_air.comp.*(Cp.Air*(T_a_out.c5-T_a_in.c5)- ...
                T0*(Cp.Air*log(T_a_out.c5./T_a_in.c5)-Rg*log(p_a_out.c5./p_a_in.c5)));

exergy_loss.c1 = exergy_in.c1 - exergy_loss.c1; % [J]
exergy_loss.c2 = exergy_in.c2 - exergy_loss.c2;
exergy_loss.c3 = exergy_in.c3 - exergy_loss.c3;
exergy_loss.c4 = exergy_in.c4 - exergy_loss.c4;
exergy_loss.c5 = exergy_in.c5 - exergy_loss.c5;

% turbine
exergy_in.e1 = m_air.turb.*(Cp.Air*(T_a_in.e1-T_a_out.e1)- ...
               T0*(Cp.Air*log(T_a_in.e1./T_a_out.e1)-Rg*log(p_a_in.e1./p_a_out.e1))); % [J]
exergy_in.e2 = m_air.turb.*(Cp.Air*(T_a_in.e2-T_a_out.e2)- ...
               T0*(Cp.Air*log(T_a_in.e2./T_a_out.e2)-Rg*log(p_a_in.e2./p_a_out.e2))); % [J]
exergy_in.e3 = m_air.turb.*(Cp.Air*(T_a_in.e3-T_a_out.e3)- ...
               T0*(Cp.Air*log(T_a_in.e3./T_a_out.e3)-Rg*log(p_a_in.e3./p_a_out.e3))); % [J]

exergy_out.e1 = W_disc.e1; % [J]
exergy_out.e2 = W_disc.e2; 
exergy_out.e3 = W_disc.e3;

exergy_loss.e1 = exergy_in.e1 - exergy_out.e1; % [J]
exergy_loss.e2 = exergy_in.e2 - exergy_out.e2;
exergy_loss.e3 = exergy_in.e3 - exergy_out.e3;

% heat exchanger at compressor side
exergy_in.HXC1 = m_air.comp.*(Cp.Air*(T_a_in.HXC1-T_a_out.HXC1) - T0*Cp.Air*log(T_a_in.HXC1./T_a_out.HXC1));
exergy_in.HXC2 = m_air.comp.*(Cp.Air*(T_a_in.HXC2-T_a_out.HXC2) - T0*Cp.Air*log(T_a_in.HXC2./T_a_out.HXC2));
exergy_in.HXC3 = m_air.comp.*(Cp.Air*(T_a_in.HXC3-T_a_out.HXC3) - T0*Cp.Air*log(T_a_in.HXC3./T_a_out.HXC3));
exergy_in.HXC4 = m_air.comp.*(Cp.Air*(T_a_in.HXC4-T_a_out.HXC4) - T0*Cp.Air*log(T_a_in.HXC4./T_a_out.HXC4));
exergy_in.HXC5 = m_air.comp.*(Cp.Air*(T_a_in.HXC5-T_a_out.HXC5) - T0*Cp.Air*log(T_a_in.HXC5./T_a_out.HXC5));

exergy_out.HXC1 = m_HTF.HXC1.*(enthalpy(mydata,'H2O', 1, T_HTF_out.HXC1, HTF_Pressure*1e6)- ...
                               enthalpy(mydata,'H2O', 1, T_HTF_in.HXC1, HTF_Pressure*1e6))- ...
                  T0*m_HTF.HXC1.*(entropy(mydata, 'H2O', 1, T_HTF_out.HXC1, HTF_Pressure*1e6) - ...
                                  entropy(mydata, 'H2O', 1, T_HTF_in.HXC1, HTF_Pressure*1e6));
exergy_out.HXC2 = m_HTF.HXC2.*(enthalpy(mydata,'H2O', 1, T_HTF_out.HXC2, HTF_Pressure*1e6)- ...
                               enthalpy(mydata,'H2O', 1, T_HTF_in.HXC2, HTF_Pressure*1e6))- ...
                  T0*m_HTF.HXC2.*(entropy(mydata, 'H2O', 1, T_HTF_out.HXC2, HTF_Pressure*1e6) - ...
                                  entropy(mydata, 'H2O', 1, T_HTF_in.HXC2, HTF_Pressure*1e6));   
exergy_out.HXC3 = m_HTF.HXC3.*(enthalpy(mydata,'H2O', 1, T_HTF_out.HXC3, HTF_Pressure*1e6)- ...
                               enthalpy(mydata,'H2O', 1, T_HTF_in.HXC3, HTF_Pressure*1e6))- ...
                  T0*m_HTF.HXC3.*(entropy(mydata, 'H2O', 1, T_HTF_out.HXC3, HTF_Pressure*1e6) - ...
                                  entropy(mydata, 'H2O', 1, T_HTF_in.HXC3, HTF_Pressure*1e6));
exergy_out.HXC4 = m_HTF.HXC4.*(enthalpy(mydata,'H2O', 1, T_HTF_out.HXC4, HTF_Pressure*1e6)- ...
                               enthalpy(mydata,'H2O', 1, T_HTF_in.HXC4, HTF_Pressure*1e6))- ...
                  T0*m_HTF.HXC4.*(entropy(mydata, 'H2O', 1, T_HTF_out.HXC4, HTF_Pressure*1e6) - ...
                                  entropy(mydata, 'H2O', 1, T_HTF_in.HXC4, HTF_Pressure*1e6)); 
exergy_out.HXC5 = m_HTF.HXC5.*(enthalpy(mydata,'H2O', 1, T_HTF_out.HXC5, HTF_Pressure*1e6)- ...
                               enthalpy(mydata,'H2O', 1, T_HTF_in.HXC5, HTF_Pressure*1e6))- ...
                  T0*m_HTF.HXC5.*(entropy(mydata, 'H2O', 1, T_HTF_out.HXC5, HTF_Pressure*1e6) - ...
                                  entropy(mydata, 'H2O', 1, T_HTF_in.HXC5, HTF_Pressure*1e6));

exergy_loss.HXC1 = exergy_in.HXC1 - exergy_out.HXC1; % [J]
exergy_loss.HXC2 = exergy_in.HXC2 - exergy_out.HXC2;
exergy_loss.HXC3 = exergy_in.HXC3 - exergy_out.HXC3;
exergy_loss.HXC4 = exergy_in.HXC4 - exergy_out.HXC4; % here is the memory error
exergy_loss.HXC5 = exergy_in.HXC5 - exergy_out.HXC5;

% heat exchanger at turb side
exergy_in.HXH1 = m_HTF.HXH1.*(enthalpy(mydata,'H2O', 1, T_HTF_in.HXH1, HTF_Pressure*1e6)- ...
                               enthalpy(mydata,'H2O', 1, T_HTF_out.HXH1, HTF_Pressure*1e6))- ...
                 T0*m_HTF.HXH1.*(entropy(mydata,'H2O', 1, T_HTF_in.HXH1, HTF_Pressure*1e6) - ...
                                 entropy(mydata,'H2O', 1, T_HTF_out.HXH1, HTF_Pressure*1e6));
exergy_in.HXH2 = m_HTF.HXH2.*(enthalpy(mydata,'H2O', 1, T_HTF_in.HXH2, HTF_Pressure*1e6)- ...
                              enthalpy(mydata,'H2O', 1, T_HTF_out.HXH2, HTF_Pressure*1e6))- ...
                 T0*m_HTF.HXH2.*(entropy(mydata,'H2O', 1, T_HTF_in.HXH2, HTF_Pressure*1e6) - ...
                                 entropy(mydata,'H2O', 1, T_HTF_out.HXH2, HTF_Pressure*1e6));   
exergy_in.HXH3 = m_HTF.HXH3.*(enthalpy(mydata,'H2O', 1, T_HTF_out.HXH3, HTF_Pressure*1e6)- ...
                               enthalpy(mydata,'H2O', 1, T_HTF_in.HXH3, HTF_Pressure*1e6))- ...
                 T0*m_HTF.HXH3.*(entropy(mydata,'H2O', 1, T_HTF_out.HXH3, HTF_Pressure*1e6) - ...
                                 entropy(mydata,'H2O', 1, T_HTF_in.HXH3, HTF_Pressure*1e6));                          
exergy_out.HXH1 = m_air.turb.*(Cp.Air*(T_a_out.HXH1-T_a_in.HXH1)-T0*Cp.Air*log(T_a_out.HXH1./T_a_in.HXH1));
exergy_out.HXH2 = m_air.turb.*(Cp.Air*(T_a_out.HXH2-T_a_in.HXH2)-T0*Cp.Air*log(T_a_out.HXH2./T_a_in.HXH2));
exergy_out.HXH3 = m_air.turb.*(Cp.Air*(T_a_out.HXH3-T_a_in.HXH3)-T0*Cp.Air*log(T_a_out.HXH3./T_a_in.HXH3));

exergy_loss.HXH1 = exergy_in.HXH1 - exergy_out.HXH1;
exergy_loss.HXH2 = exergy_in.HXH2 - exergy_out.HXH2;
exergy_loss.HXH3 = exergy_in.HXH3 - exergy_out.HXH3;

% exergy loss at TV
% if strcmp(TV_Mode.Comp, '')
%     exergy_in.TVC = Cp.Air*m_air.comp.*(T_a_out.HXC5 - T0*log(T_a_out.HXC5))
% else
%     
% end

% sum exergy-in 
% exergy_in.allcomp = exergy_in.c1 + exergy_in.c2 + exergy_in.c3 + exergy_in.c4 + exergy_in.c5;
% exergy_in.allturb = exergy_in.e1 + exergy_in.e2 + exergy_in.e3;
% exergy_in.allHXC = exergy_in.HXC1 + exergy_in.HXC2 + exergy_in.HXC3 + exergy_in.HXC4 + exergy_in.HXC5;
% exergy_in.allHXH = exergy_in.HXH1 + exergy_in.HXH2 + exergy_in.HXH3;
% exergy_in.all = exergy_in.allcomp + exergy_in.allturb + exergy_in.allHXC + exergy_in.allHXH;
% 
% % sum exergy-out
% exergy_out.allcomp = exergy_out.c1 + exergy_out.c2 + exergy_out.c3 + exergy_out.c4 + exergy_out.c5;
% exergy_out.allturb = exergy_out.e1 + exergy_out.e2 + exergy_out.e3;
% exergy_out.allHXC = exergy_out.HXC1 + exergy_out.HXC2 + exergy_out.HXC3 + exergy_out.HXC4 + exergy_out.HXC5;
% exergy_out.allHXH = exergy_out.HXH1 + exergy_out.HXH2 + exergy_out.HXH3;
% exergy_out.all = exergy_out.allcomp + exergy_out.allturb + exergy_out.allHXC + exergy_out.allHXH;

% eta_exergy_elec =
% sum(exergy_out.all(time_period_disc))/sum(exergy_in.all()) wrong, totally
% wrong