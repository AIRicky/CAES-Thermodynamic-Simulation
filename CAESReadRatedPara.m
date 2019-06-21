% this code need to be adjust to read the rated parameters automaticly 
beta.c1_rated = Compressor(1,2);
beta.c2_rated = Compressor(2,2);
beta.c3_rated = Compressor(3,2);
beta.c4_rated = Compressor(4,2);
beta.c5_rated = Compressor(5,2);
beta.e1_rated = Turbine(1,2);
beta.e2_rated = Turbine(2,2);
beta.e3_rated = Turbine(3,2);

eta.c1_rated = Compressor(1,3)/100;
eta.c2_rated = Compressor(2,3)/100;
eta.c3_rated = Compressor(3,3)/100;
eta.c4_rated = Compressor(4,3)/100;
eta.c5_rated = Compressor(5,3)/100;
eta.e1_rated = Turbine(1,3)/100;
eta.e2_rated = Turbine(2,3)/100;
eta.e3_rated = Turbine(3,3)/100;

m_c_rated = 1250; % [Nm^3/h]
m_c_rated = m_c_rated*From_Nm_to_kg; % [kg/h]
m_c_rated = m_c_rated/3600; % [kg/s]
m_e_rated = 6800; % [Nm^3/h]
m_e_rated = m_e_rated*From_Nm_to_kg; % [kg/h]
m_e_rated = m_e_rated/3600; % [kg/s]
m_air.comp_rated = m_c_rated;
m_air.turb_rated = m_e_rated;

T_a_in.HXC1_rated = CoolHE(1,2) + From_C_to_K; % [K]
T_a_in.HXC2_rated = CoolHE(2,2) + From_C_to_K; % [K]
T_a_in.HXC3_rated = CoolHE(3,2) + From_C_to_K; % [K]
T_a_in.HXC4_rated = CoolHE(4,2) + From_C_to_K; % [K]
T_a_in.HXC5_rated = CoolHE(5,2) + From_C_to_K; % [K]
T_a_in.HXH1_rated = HeatHE(1,2) + From_C_to_K; % [K]
T_a_in.HXH2_rated = HeatHE(2,2) + From_C_to_K; % [K]
T_a_in.HXH3_rated = HeatHE(3,2) + From_C_to_K; % [K]

T_a_out.HXC1_rated = CoolHE(1,3) + From_C_to_K; % [K]
T_a_out.HXC2_rated = CoolHE(2,3) + From_C_to_K; % [K]
T_a_out.HXC3_rated = CoolHE(3,3) + From_C_to_K;
T_a_out.HXC4_rated = CoolHE(4,3) + From_C_to_K;
T_a_out.HXC5_rated = CoolHE(5,3) + From_C_to_K;
T_a_out.HXH1_rated = HeatHE(1,3) + From_C_to_K;
T_a_out.HXH2_rated = HeatHE(2,3) + From_C_to_K;
T_a_out.HXH3_rated = HeatHE(3,3) + From_C_to_K;

T_HTF_in.HXC1_rated = CoolHE(1,4) + From_C_to_K;
T_HTF_in.HXC2_rated = CoolHE(2,4) + From_C_to_K;
T_HTF_in.HXC3_rated = CoolHE(3,4) + From_C_to_K;
T_HTF_in.HXC4_rated = CoolHE(4,4) + From_C_to_K;
T_HTF_in.HXC5_rated = CoolHE(5,4) + From_C_to_K;
T_HTF_in.HXH1_rated = HeatHE(1,4) + From_C_to_K;
T_HTF_in.HXH2_rated = HeatHE(2,4) + From_C_to_K;
T_HTF_in.HXH3_rated = HeatHE(3,4) + From_C_to_K;

T_HTF_out.HXC1_rated = CoolHE(1,5) + From_C_to_K;
T_HTF_out.HXC2_rated = CoolHE(2,5) + From_C_to_K;
T_HTF_out.HXC3_rated = CoolHE(3,5) + From_C_to_K;
T_HTF_out.HXC4_rated = CoolHE(4,5) + From_C_to_K;
T_HTF_out.HXC5_rated = CoolHE(5,5) + From_C_to_K;
T_HTF_out.HXH1_rated = HeatHE(1,5) + From_C_to_K;
T_HTF_out.HXH2_rated = HeatHE(2,5) + From_C_to_K;
T_HTF_out.HXH1_rated = HeatHE(3,5) + From_C_to_K;

m_HTF.HXC1_rated = CoolHE(1,8)/3600; % [kg/s]
m_HTF.HXC2_rated = CoolHE(2,8)/3600; % [kg/s]
m_HTF.HXC3_rated = CoolHE(3,8)/3600; % [kg/s]
m_HTF.HXC4_rated = CoolHE(4,8)/3600; % [kg/s]
m_HTF.HXC5_rated = CoolHE(5,8)/3600; % [kg/s]
m_HTF.HXH1_rated = HeatHE(1,8)/3600; % [kg/s]
m_HTF.HXH2_rated = HeatHE(2,8)/3600; % [kg/s]
m_HTF.HXH3_rated = HeatHE(3,8)/3600; % [kg/s]

Sigma.HXC1_rated = Sigma_Rated(T_a_in.HXC1_rated, T_a_out.HXC1_rated, T_HTF_in.HXC1_rated,...
                                  Cpa*m_air.comp_rated, min(Cpa*m_air.comp_rated, Cp.HTF*m_HTF.HXC1_rated)); 
Sigma.HXC2_rated = Sigma_Rated(T_a_in.HXC2_rated, T_a_out.HXC2_rated, T_HTF_in.HXC2_rated,...
                                  Cpa*m_air.comp_rated, min(Cpa*m_air.comp_rated, Cp.HTF*m_HTF.HXC2_rated)); 
Sigma.HXC3_rated = Sigma_Rated(T_a_in.HXC3_rated, T_a_out.HXC3_rated, T_HTF_in.HXC3_rated,...
                                  Cpa*m_air.comp_rated, min(Cpa*m_air.comp_rated, Cp.HTF*m_HTF.HXC3_rated)); 
Sigma.HXC4_rated = Sigma_Rated(T_a_in.HXC4_rated, T_a_out.HXC4_rated, T_HTF_in.HXC4_rated,...
                                  Cpa*m_air.comp_rated, min(Cpa*m_air.comp_rated, Cp.HTF*m_HTF.HXC4_rated)); 
Sigma.HXC5_rated = Sigma_Rated(T_a_in.HXC5_rated, T_a_out.HXC5_rated, T_HTF_in.HXC5_rated,...
                                  Cpa*m_air.comp_rated, min(Cpa*m_air.comp_rated, Cp.HTF*m_HTF.HXC5_rated)); 
Sigma.HXH1_rated = Sigma_Rated(T_a_in.HXH1_rated, T_a_out.HXH1_rated, T_HTF_in.HXH1_rated,...
                                  Cpa*m_air.turb_rated, min(Cpa*m_air.turb_rated, Cp.HTF*m_HTF.HXH1_rated)); 
Sigma.HXH2_rated = Sigma_Rated(T_a_in.HXH2_rated, T_a_out.HXH2_rated, T_HTF_in.HXH2_rated,...
                                  Cpa*m_air.turb_rated, min(Cpa*m_air.turb_rated, Cp.HTF*m_HTF.HXH2_rated)); 
Sigma.HXH3_rated = Sigma_Rated(T_a_in.HXH3_rated, T_a_out.HXH3_rated, T_HTF_in.HXH3_rated,...
                                  Cpa*m_air.turb_rated, min(Cpa*m_air.turb_rated, Cp.HTF*m_HTF.HXH3_rated)); 
         
CMin_Rated.HXC1 = min(Cpa*m_air.comp_rated,Cp.HTF*m_HTF.HXC1_rated);
CMin_Rated.HXC2 = min(Cpa*m_air.comp_rated,Cp.HTF*m_HTF.HXC2_rated);
CMin_Rated.HXC3 = min(Cpa*m_air.comp_rated,Cp.HTF*m_HTF.HXC3_rated);
CMin_Rated.HXC4 = min(Cpa*m_air.comp_rated,Cp.HTF*m_HTF.HXC4_rated);
CMin_Rated.HXC5 = min(Cpa*m_air.comp_rated,Cp.HTF*m_HTF.HXC5_rated);
CMin_Rated.HXH1 = min(Cpa*m_air.turb_rated,Cp.HTF*m_HTF.HXH1_rated);
CMin_Rated.HXH2 = min(Cpa*m_air.turb_rated,Cp.HTF*m_HTF.HXH2_rated);
CMin_Rated.HXH3 = min(Cpa*m_air.turb_rated,Cp.HTF*m_HTF.HXH3_rated);

CMax_Rated.HXC1 = max(Cpa*m_air.comp_rated,Cp.HTF*m_HTF.HXC1_rated);
CMax_Rated.HXC2 = max(Cpa*m_air.comp_rated,Cp.HTF*m_HTF.HXC2_rated);
CMax_Rated.HXC3 = max(Cpa*m_air.comp_rated,Cp.HTF*m_HTF.HXC3_rated);
CMax_Rated.HXC4 = max(Cpa*m_air.comp_rated,Cp.HTF*m_HTF.HXC4_rated);
CMax_Rated.HXC5 = max(Cpa*m_air.comp_rated,Cp.HTF*m_HTF.HXC5_rated);
CMax_Rated.HXH1 = max(Cpa*m_air.turb_rated,Cp.HTF*m_HTF.HXH1_rated);
CMax_Rated.HXH2 = max(Cpa*m_air.turb_rated,Cp.HTF*m_HTF.HXH2_rated);
CMax_Rated.HXH3 = max(Cpa*m_air.turb_rated,Cp.HTF*m_HTF.HXH3_rated);

C_HX_Rated.HXC1 = CMin_Rated.HXC1/CMax_Rated.HXC1; 
C_HX_Rated.HXC2 = CMin_Rated.HXC2/CMax_Rated.HXC2; 
C_HX_Rated.HXC3 = CMin_Rated.HXC3/CMax_Rated.HXC3; 
C_HX_Rated.HXC4 = CMin_Rated.HXC4/CMax_Rated.HXC4; 
C_HX_Rated.HXC5 = CMin_Rated.HXC5/CMax_Rated.HXC5; 
C_HX_Rated.HXH1 = CMin_Rated.HXH1/CMax_Rated.HXH1;
C_HX_Rated.HXH2 = CMin_Rated.HXH2/CMax_Rated.HXH2; 
C_HX_Rated.HXH3 = CMin_Rated.HXH3/CMax_Rated.HXH3; 

x_temp_Rated.HXC1 = -log((1-Sigma.HXC1_rated)/(1-Sigma.HXC1_rated*C_HX_Rated.HXC1));
x_temp_Rated.HXC2 = -log((1-Sigma.HXC2_rated)/(1-Sigma.HXC2_rated*C_HX_Rated.HXC2));
x_temp_Rated.HXC3 = -log((1-Sigma.HXC3_rated)/(1-Sigma.HXC3_rated*C_HX_Rated.HXC3));
x_temp_Rated.HXC4 = -log((1-Sigma.HXC4_rated)/(1-Sigma.HXC4_rated*C_HX_Rated.HXC4));
x_temp_Rated.HXC5 = -log((1-Sigma.HXC5_rated)/(1-Sigma.HXC5_rated*C_HX_Rated.HXC5));
x_temp_Rated.HXH1 = -log((1-Sigma.HXH1_rated)/(1-Sigma.HXH1_rated*C_HX_Rated.HXH1));
x_temp_Rated.HXH2 = -log((1-Sigma.HXH2_rated)/(1-Sigma.HXH2_rated*C_HX_Rated.HXH2));
x_temp_Rated.HXH3 = -log((1-Sigma.HXH3_rated)/(1-Sigma.HXH3_rated*C_HX_Rated.HXH3));

UA_Rated.HXC1 = CMin_Rated.HXC1*x_temp_Rated.HXC1/(1-C_HX_Rated.HXC1);
UA_Rated.HXC2 = CMin_Rated.HXC2*x_temp_Rated.HXC2/(1-C_HX_Rated.HXC2);
UA_Rated.HXC3 = CMin_Rated.HXC3*x_temp_Rated.HXC3/(1-C_HX_Rated.HXC3);
UA_Rated.HXC4 = CMin_Rated.HXC4*x_temp_Rated.HXC4/(1-C_HX_Rated.HXC4);
UA_Rated.HXC5 = CMin_Rated.HXC5*x_temp_Rated.HXC5/(1-C_HX_Rated.HXC5);
UA_Rated.HXH1 = CMin_Rated.HXH1*x_temp_Rated.HXH1/(1-C_HX_Rated.HXH1);
UA_Rated.HXH2 = CMin_Rated.HXH2*x_temp_Rated.HXH2/(1-C_HX_Rated.HXH2);
UA_Rated.HXH3 = CMin_Rated.HXH3*x_temp_Rated.HXH3/(1-C_HX_Rated.HXH3);
