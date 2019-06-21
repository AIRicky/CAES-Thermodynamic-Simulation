%% ASU CP discharging
%%% Air-storage G Model 
if strcmp(ASU_Model,'G') 
    Radius_as = (5/3.14)^(0.5); % assuming 5[m^2]*20[m]
    A_as_W = (2*3.14*Radius_as)*20 + 2*3.14*(Radius_as)^2; % [m^2]
    alpha_w(tt_disc) = 0.02356 + 0.0149*(m_air.turb(tt_disc)).^(0.8);
    T_as_W = T_as.disc0; % can be updated 
    if  tt_disc == 1
        T_as_out(1) = T_as.disc0;
        M_as.Disc(1) = M_as.disc0 - m_air.comp(1)*tstep; % [kg]   % first step
        T_as.Disc(1) = T_as.disc0 - 1/M_as.Disc(1)*((1-1/1.4)*(m_air.turb(1)*T_as_out(1)))*tstep;% [K]
        P_as.Disc(1) = P_as.disc0 - (1.4*Rg*(m_air.comp(1)*T_as_out(1))/V_as*tstep)*From_Pa_to_KPa; % [KPa]
    else
        T_as_out(tt_disc) = T_as.Disc(tt_disc-1);
        M_as.Disc(tt_disc) = M_as.Disc(tt_disc-1) + m_air.turb(tt_disc)*tstep; % [kg]
        T_as.Delta_Disc(tt_disc) = alpha_w(tt_disc)*A_as_W*(T_as_W-T_as.Disc(tt_disc-1))/(m_air.turb(tt_disc)*Cp.Air); % [K]
        P_as.Delta_Disc(tt_disc) = Rg*(m_air.turb(tt_disc)*Cp.Air)/(Cva*V_as)*T_as_Delta.Disc(tt_disc); % [KPa]
        P_as.Disc(tt_disc) = P_as.Disc(tt_disc-1) - (1.4*Rg*(m_air.turb(tt_disc)*T_as_out(tt_disc))/V_as*tstep)*From_Pa_to_KPa; %[KPa]
        T_as.Disc(tt_disc) = T_as.Disc(tt_disc-1) - 1/M_as.Disc(tt_disc)*((1-1/1.4)*(m_air.turb(tt_disc)*T_as_out(tt_disc)))*tstep;%[K]
        P_as.Disc(tt_disc) = P_as.Disc(tt_disc) + P_as.Delta_Disc(tt_disc);
        T_as.Disc(tt_disc) = T_as.Disc(tt_disc) + T_as.Delta_Disc(tt_disc);
    end
end
%%% VT Model
if strcmp(ASU_Model, 'VT')
    T_as.Disc(tt_disc) = Ta0;
    T_as_out(tt_disc) = Ta0;
    if  tt_disc == 1
        M_as.Disc(1) = M_as.disc0 - m_air.turb(1)*tstep; % [kg]   % first step
        P_as.Disc(1) = P_as.disc0 - (1.4*Rg*(m_air.turb(1)*T_as_out(1))/V_as*tstep)*From_Pa_to_KPa; % [KPa]
    else
        M_as.Disc(tt_disc) = M_as.Disc(tt_disc-1) - m_air.turb(tt_disc)*tstep; % [kg]
        P_as.Disc(tt_disc) = P_as.Disc(tt_disc-1) - (1.4*Rg*(m_air.turb(tt_disc)*T_as_out(tt_disc))/V_as*tstep)*From_Pa_to_KPa; %[KPa]
    end  
end
%%%% VA Model 
if strcmp(ASU_Model, 'VA')
    if tt_disc == 1
        T_as_out(1) = T_as.disc0;
        M_as.Disc(1) = M_as.disc0 - m_air.turb(1)*tstep; % [kg]   % first step
        T_as.Disc(1) = T_as.disc0 - 1/M_as.Disc(1)*((1-1/1.4)*(m_air.turb(1)*T_as_out(1)))*tstep;% [K]
        P_as.Disc(1) = P_as.disc0 - (1.4*Rg*(m_air.turb(1)*T_as_out(1))/V_as*tstep)*From_Pa_to_KPa; % [KPa]
    else
        T_as_out(tt_disc) = T_as.Disc(tt_disc-1);
        M_as.Disc(tt_disc) = M_as.Disc(tt_disc-1) - m_air.turb(tt_disc)*tstep; % [kg]
        P_as.Disc(tt_disc) = P_as.Disc(tt_disc-1) - (1.4*Rg*(m_air.turb(tt_disc)*T_as_out(tt_disc))/V_as*tstep)*From_Pa_to_KPa; %[KPa]
        T_as.Disc(tt_disc) = T_as.Disc(tt_disc-1) - 1/M_as.Disc(tt_disc)*((1-1/1.4)*(m_air.turb(tt_disc)*T_as_out(tt_disc)))*tstep;%[K]
    end
end
