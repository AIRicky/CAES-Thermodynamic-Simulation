% fixed the error 2019/03/31
%%% 1-stage-HE-Heat
CMin.HXH1(tt_disc) = CMin_Rated.HXH1*m_air.turb(tt_disc)/m_air.turb_rated;
NTU.HXH1(tt_disc) = UA_Rated.HXH1*Scale.U_HE(m_air.turb(tt_disc)/m_air.turb_rated)/CMin.HXH1(tt_disc);        
C_HX.HXH1(tt_disc) = C_HX_Rated.HXH1;  % assuming that C_e_HX keeps as the rated value;
Sigma.HXH1(tt_disc) = (1-exp(-NTU.HXH1(tt_disc)*(1-C_HX.HXH1(tt_disc))))/ ...
                      (1-C_HX.HXH1(tt_disc)*exp(-NTU.HXH1(tt_disc)*(1-C_HX.HXH1(tt_disc))));
if OFFDesign.HEH
    Coeff_Phi(tt_disc) = Sigma.HXH1_rated*CMin_Rated.HXH1; 
else
    Coeff_Phi(tt_disc) = Sigma.HXH1(tt_disc)*CMin.HXH1(tt_disc); 
end
T_a_in.HXH1(tt_disc) = T_as_out(tt_disc);
T_HTF_in.HXH1(tt_disc) = T_HTF.TES_out(tt_disc); 
Phi.HXH1(tt_disc) = Coeff_Phi(tt_disc)*(T_HTF_in.HXH1(tt_disc)-T_a_in.HXH1(tt_disc)); % [W] % HEH_1.T_in_water_rated should be replaced with T_TES
T_a_out.HXH1(tt_disc) = T_a_in.HXH1(tt_disc) + Phi.HXH1(tt_disc)/(Cp.Air*m_air.turb(tt_disc)); % [K]
T_HTF_out.HXH1(tt_disc) = T_HTF_in.HXH1(tt_disc) - Phi.HXH1(tt_disc)/(Cp.Air*m_air.turb(tt_disc))/C_HX_Rated.HXH1; % [K]   
eta_P.HXH1(tt_disc) = 1-PressureDrop.HXH*0.0083*Sigma.HXH1(tt_disc)/(1-Sigma.HXH1(tt_disc)); % [-]
p_a_in.HXH1(tt_disc) =  p_as_out(tt_disc); % [kPa]
p_a_out.HXH1(tt_disc) = eta_P.HXH1(tt_disc)*p_a_in.HXH1(tt_disc); % [kPa]

%% 1-stage-Turb
T_a_in.e1(tt_disc) = T_a_out.HXH1(tt_disc); % [K]
p_a_in.e1(tt_disc) = p_a_out.HXH1(tt_disc); % [KPa]

if OFFDesign.Turb
    eta.e1(tt_disc) = eta.e1_rated*Scale.Eta_Turb(m_air.turb(tt_disc)/m_air.turb_rated); % [-]
    beta.e1(tt_disc) = beta.e1_rated*Scale.Beta_Turb(m_air.turb(tt_disc)/m_air.turb_rated); % [-]
else
    eta.e1(tt_disc) = eta.e1_rated;  % [-]
    beta.e1(tt_disc) = beta.e1_rated; % [-]
end
T_a_out.e1(tt_disc) = T_a_in.e1(tt_disc)*(1-eta.e1(tt_disc)+eta.e1(tt_disc)*(beta.e1(tt_disc)^(-lambda))); % [K]
p_a_out.e1(tt_disc) = p_a_in.e1(tt_disc)/beta.e1(tt_disc); % [KPa]
W_disc.e1(tt_disc) = m_air.turb(tt_disc)*Cp.Air*(T_a_in.e1(tt_disc)-T_a_out.e1(tt_disc)); % [W]

%% 2-stage-HE-Heat
CMin.HXH2(tt_disc) = CMin_Rated.HXH2*m_air.turb(tt_disc)/m_air.turb_rated;
NTU.HXH2(tt_disc) = UA_Rated.HXH2*Scale.U_HE(m_air.turb(tt_disc)/m_air.turb_rated)/CMin.HXH2(tt_disc);        
C_HX.HXH2(tt_disc) = C_HX_Rated.HXH2;  % assuming that C_e_HX keeps as the rated value;
Sigma.HXH2(tt_disc) = (1-exp(-NTU.HXH2(tt_disc)*(1-C_HX.HXH2(tt_disc))))/ ...
                      (1-C_HX.HXH2(tt_disc)*exp(-NTU.HXH2(tt_disc)*(1-C_HX.HXH2(tt_disc))));
if OFFDesign.HEH
    Coeff_Phi(tt_disc) = Sigma.HXH2_rated*CMin_Rated.HXH2; 
else
    Coeff_Phi(tt_disc) = Sigma.HXH2(tt_disc)*CMin.HXH2(tt_disc); 
end
T_a_in.HXH2(tt_disc) = T_a_out.e1(tt_disc); % [K]
p_a_in.HXH2(tt_disc) = p_a_out.e1(tt_disc); % [kPa]
T_HTF_in.HXH2(tt_disc) = T_HTF.TES_out(tt_disc); 
Phi.HXH2(tt_disc) = Coeff_Phi(tt_disc)*(T_HTF_in.HXH2(tt_disc)-T_a_in.HXH2(tt_disc)); % [W] % HEH_1.T_in_water_rated should be replaced with T_TES
T_a_out.HXH2(tt_disc) = T_a_in.HXH2(tt_disc) + Phi.HXH2(tt_disc)/(Cp.Air*m_air.turb(tt_disc)); % [K]
T_HTF_out.HXH2(tt_disc) = T_HTF_in.HXH2(tt_disc) - Phi.HXH2(tt_disc)/(Cp.Air*m_air.turb(tt_disc))/C_HX_Rated.HXH2; % [K]   
eta_P.HXH2(tt_disc) = 1-PressureDrop.HXH*0.0083*Sigma.HXH2(tt_disc)/(1-Sigma.HXH2(tt_disc)); % [-]
p_a_out.HXH2(tt_disc) = eta_P.HXH2(tt_disc)*p_a_in.HXH2(tt_disc); % [kPa]

%% 2-stage-Turb
T_a_in.e2(tt_disc) = T_a_out.HXH2(tt_disc); % [K]
p_a_in.e2(tt_disc) = p_a_out.HXH2(tt_disc); % [KPa]
if OFFDesign.Turb
    eta.e2(tt_disc) = eta.e2_rated*Scale.Eta_Turb(m_air.turb(tt_disc)/m_air.turb_rated); % [-]
    beta.e2(tt_disc) = beta.e2_rated*Scale.Beta_Turb(m_air.turb(tt_disc)/m_air.turb_rated); % [-]
else
    eta.e2(tt_disc) = eta.e2_rated;  % [-]
    beta.e2(tt_disc) = beta.e2_rated; % [-]
end
T_a_out.e2(tt_disc) = T_a_in.e2(tt_disc)*(1-eta.e2(tt_disc)+eta.e2(tt_disc)*(beta.e2(tt_disc)^(-lambda))); % [K]
p_a_out.e2(tt_disc) = p_a_in.e2(tt_disc)/beta.e2(tt_disc); % [KPa]
W_disc.e2(tt_disc) = m_air.turb(tt_disc)*Cp.Air*(T_a_in.e2(tt_disc)-T_a_out.e2(tt_disc)); % [W]

%% 3-stage-HE-Heat
CMin.HXH3(tt_disc) = CMin_Rated.HXH3*m_air.turb(tt_disc)/m_air.turb_rated;
NTU.HXH3(tt_disc) = UA_Rated.HXH3*Scale.U_HE(m_air.turb(tt_disc)/m_air.turb_rated)/CMin.HXH3(tt_disc);        
C_HX.HXH3(tt_disc) = C_HX_Rated.HXH3;  % assuming that C_e_HX keeps as the rated value;
Sigma.HXH3(tt_disc) = (1-exp(-NTU.HXH3(tt_disc)*(1-C_HX.HXH3(tt_disc))))/ ...
                      (1-C_HX.HXH3(tt_disc)*exp(-NTU.HXH3(tt_disc)*(1-C_HX.HXH3(tt_disc))));
if OFFDesign.HEH
    Coeff_Phi(tt_disc) = Sigma.HXH3_rated*CMin_Rated.HXH3; 
else
    Coeff_Phi(tt_disc) = Sigma.HXH3(tt_disc)*CMin.HXH3(tt_disc); 
end
T_a_in.HXH3(tt_disc) = T_a_out.e2(tt_disc); % [K]
p_a_in.HXH3(tt_disc) = p_a_out.e2(tt_disc); % [kPa]
T_HTF_in.HXH3(tt_disc) = T_HTF.TES_out(tt_disc); 
Phi.HXH3(tt_disc) = Coeff_Phi(tt_disc)*(T_HTF_in.HXH3(tt_disc)-T_a_in.HXH3(tt_disc)); % [W] % HEH_1.T_in_water_rated should be replaced with T_TES
T_a_out.HXH3(tt_disc) = T_a_in.HXH3(tt_disc) + Phi.HXH3(tt_disc)/(Cp.Air*m_air.turb(tt_disc)); % [K]
T_HTF_out.HXH3(tt_disc) = T_HTF_in.HXH3(tt_disc) - Phi.HXH3(tt_disc)/(Cp.Air*m_air.turb(tt_disc))/C_HX_Rated.HXH3; % [K]   
eta_P.HXH3(tt_disc) = 1-PressureDrop.HXH*0.0083*Sigma.HXH3(tt_disc)/(1-Sigma.HXH3(tt_disc)); % [-]
p_a_out.HXH3(tt_disc) = eta_P.HXH3(tt_disc)*p_a_in.HXH3(tt_disc); % [kPa]

%% 3-stage-Turb
T_a_in.e3(tt_disc) = T_a_out.HXH3(tt_disc); % [K]
p_a_in.e3(tt_disc) = p_a_out.HXH3(tt_disc); % [KPa]
if OFFDesign.Turb
    eta.e3(tt_disc) = eta.e3_rated*Scale.Eta_Turb(m_air.turb(tt_disc)/m_air.turb_rated); % [-]
    beta.e3(tt_disc) = beta.e3_rated*Scale.Beta_Turb(m_air.turb(tt_disc)/m_air.turb_rated); % [-]
else
    eta.e3(tt_disc) = eta.e3_rated;  % [-]
    beta.e3(tt_disc) = beta.e3_rated; % [-]
end
T_a_out.e3(tt_disc) = T_a_in.e3(tt_disc)*(1-eta.e3(tt_disc)+eta.e3(tt_disc)*(beta.e3(tt_disc)^(-lambda))); % [K]
p_a_out.e3(tt_disc) = p_a_in.e3(tt_disc)/beta.e3(tt_disc); % [KPa]
W_disc.e3(tt_disc) = m_air.turb(tt_disc)*Cp.Air*(T_a_in.e3(tt_disc)-T_a_out.e3(tt_disc)); % [W]