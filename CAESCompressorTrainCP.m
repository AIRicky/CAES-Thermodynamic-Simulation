%% Compressor CP V2.0
%% 1-stage-compressor
if OFFDesign.Comp
    eta.c1(tt_char) = eta.c1_rated*Scale.Eta_Comp(m_air.comp(tt_char)/m_air.comp_rated); % [-]
    beta.c1(tt_char) = beta.c1_rated*Scale.Beta_Comp(m_air.comp(tt_char)/m_air.comp_rated); % [-]
else
    eta.c1(tt_char) = eta.c1_rated; % [-]
    beta.c1(tt_char) = beta.c1_rated; % [-]
end
p_a_out.c1(tt_char) = p_a_in.c1(tt_char)*beta.c1(tt_char); % [KPa]
T_a_out.c1(tt_char) = 1/eta.c1(tt_char)*T_a_in.c1(tt_char)*(beta.c1(tt_char)^lambda+eta.c1(tt_char)-1); % [K]
W_char.c1(tt_char) = m_air.comp(tt_char)*Cp.Air*(T_a_out.c1(tt_char)-T_a_in.c1(tt_char)); % [W]

%% 1-stage-HE-Cold 
CMin.HXC1(tt_char) = CMin_Rated.HXC1*m_air.comp(tt_char)/m_air.comp_rated;
NTU.HXC1(tt_char) = UA_Rated.HXC1*Scale.U_HE(m_air.comp(tt_char)/m_air.comp_rated)/CMin.HXC1(tt_char);
C_HX.HXC1(tt_char) = C_HX_Rated.HXC1; % assuming that C_c_HX keeps as the rated value; / can adjust
Sigma.HXC1(tt_char) = (1-exp(-NTU.HXC1(tt_char)*(1-C_HX.HXC1(tt_char))))/ ...
                      (1-C_HX.HXC1(tt_char)*exp(-NTU.HXC1(tt_char)*(1-C_HX.HXC1(tt_char))));
if OFFDesign.HEC
    Coeff_Phi(tt_char) = Sigma.HXC1_rated*CMin_Rated.HXC1; 
else
    Coeff_Phi(tt_char) = Sigma.HXC1(tt_char)*CMin.HXC1(tt_char); 
end
T_a_in.HXC1(tt_char) = T_a_out.c1(tt_char); % [K]
T_a_HTF.HXC1(tt_char) = T_HTF_in.HXC1_rated; % [K]
Phi.HXC1(tt_char) = Coeff_Phi(tt_char)*(T_HTF_in.HXC1_rated-T_a_in.HXC1(tt_char)); % [W]
T_a_out.HXC1(tt_char) = T_a_in.HXC1(tt_char)+Phi.HXC1(tt_char)/(Cp.Air*m_air.comp(tt_char)); % [K]
T_HTF_out.HXC1(tt_char) = T_HTF_in.HXC1_rated-Phi.HXC1(tt_char)/(Cp.Air*m_air.comp(tt_char)/C_HX_Rated.HXC1); % [K]
m_HTF.HXC1(tt_char) = m_air.comp(tt_char)*Cp.Air*(T_a_in.HXC1(tt_char)-T_a_out.HXC1(tt_char))/ ...
                       (Cp.HTF*(T_HTF_out.HXC1(tt_char)-T_HTF_in.HXC1_rated)); % [kg/s]
eta_P.HXC1(tt_char) = 1-PressureDrop.HXC*0.0083*Sigma.HXC1(tt_char)/(1-Sigma.HXC1(tt_char)); % [-]
p_a_in.HXC1(tt_char) = p_a_out.c1(tt_char); % [kPa]
p_a_out.HXC1(tt_char) = eta_P.HXC1(tt_char)*p_a_in.HXC1(tt_char); % [kPa]

%% 2-stage-Comp
T_a_in.c2(tt_char) = T_a_out.HXC1(tt_char); % [K]
p_a_in.c2(tt_char) = p_a_out.HXC1(tt_char); % [KPa]
if OFFDesign.Comp
    eta.c2(tt_char) = eta.c2_rated*Scale.Eta_Comp(m_air.comp(tt_char)/m_air.comp_rated); % [-]
    beta.c2(tt_char) = beta.c2_rated*Scale.Beta_Comp(m_air.comp(tt_char)/m_air.comp_rated); % [-]
else
    eta.c2(tt_char) = eta.c2_rated; % [-]
    beta.c2(tt_char) = beta.c2_rated; % [-]
end
p_a_out.c2(tt_char) = p_a_in.c2(tt_char)*beta.c2(tt_char); % [KPa]
T_a_out.c2(tt_char) = 1/eta.c2(tt_char)*T_a_in.c2(tt_char)*(beta.c2(tt_char)^lambda+eta.c2(tt_char)-1); % [K]
W_char.c2(tt_char) = m_air.comp(tt_char)*Cp.Air*(T_a_out.c2(tt_char)-T_a_in.c2(tt_char)); % [W]

%% 2-stage-HE-Cold    
CMin.HXC2(tt_char) = CMin_Rated.HXC2*m_air.comp(tt_char)/m_air.comp_rated;
NTU.HXC2(tt_char) = UA_Rated.HXC2*Scale.U_HE(m_air.comp(tt_char)/m_air.comp_rated)/CMin.HXC2(tt_char);
C_HX.HXC2(tt_char) = C_HX_Rated.HXC2; % assuming that C_c_HX keeps as the rated value; / can adjust
Sigma.HXC2(tt_char) = (1-exp(-NTU.HXC2(tt_char)*(1-C_HX.HXC2(tt_char))))/ ...
                      (1-C_HX.HXC2(tt_char)*exp(-NTU.HXC2(tt_char)*(1-C_HX.HXC2(tt_char))));
if OFFDesign.HEC
    Coeff_Phi(tt_char) = Sigma.HXC2_rated*CMin_Rated.HXC2; 
else
    Coeff_Phi(tt_char) = Sigma.HXC2(tt_char)*CMin.HXC2(tt_char); 
end
T_a_in.HXC2(tt_char) = T_a_out.c2(tt_char); % [K]
T_a_HTF.HXC2(tt_char) = T_HTF_in.HXC2_rated; % [K]
Phi.HXC2(tt_char) = Coeff_Phi(tt_char)*(T_HTF_in.HXC2_rated-T_a_in.HXC2(tt_char)); % [W]
T_a_out.HXC2(tt_char) = T_a_in.HXC2(tt_char)+Phi.HXC2(tt_char)/(Cp.Air*m_air.comp(tt_char)); % [K]
T_HTF_out.HXC2(tt_char) = T_HTF_in.HXC2_rated-Phi.HXC2(tt_char)/(Cp.Air*m_air.comp(tt_char)/C_HX_Rated.HXC2); % [K]
m_HTF.HXC2(tt_char) = m_air.comp(tt_char)*Cp.Air*(T_a_in.HXC2(tt_char)-T_a_out.HXC2(tt_char))/ ...
                      (Cp.HTF*(T_HTF_out.HXC2(tt_char)-T_HTF_in.HXC2_rated)); % [kg/s]
eta_P.HXC2(tt_char) = 1-PressureDrop.HXC*0.0083*Sigma.HXC2(tt_char)/(1-Sigma.HXC2(tt_char)); % [-]
p_a_in.HXC2(tt_char) = p_a_out.c2(tt_char); % [kPa]
p_a_out.HXC2(tt_char) = eta_P.HXC2(tt_char)*p_a_in.HXC2(tt_char); % [kPa]

%% 3-stage-Comp
T_a_in.c3(tt_char) = T_a_out.HXC2(tt_char); % [K]
p_a_in.c3(tt_char) = p_a_out.HXC2(tt_char); % [KPa]
if OFFDesign.Comp
    eta.c3(tt_char) = eta.c3_rated*Scale.Eta_Comp(m_air.comp(tt_char)/m_air.comp_rated); % [-]
    beta.c3(tt_char) = beta.c3_rated*Scale.Beta_Comp(m_air.comp(tt_char)/m_air.comp_rated); % [-]
else
    eta.c3(tt_char) = eta.c3_rated; % [-]
    beta.c3(tt_char) = beta.c3_rated; % [-]
end
p_a_out.c3(tt_char) = p_a_in.c3(tt_char)*beta.c3(tt_char); % [KPa]
T_a_out.c3(tt_char) = 1/eta.c3(tt_char)*T_a_in.c3(tt_char)*(beta.c3(tt_char)^lambda+eta.c3(tt_char)-1); % [K]
W_char.c3(tt_char) = m_air.comp(tt_char)*Cp.Air*(T_a_out.c3(tt_char)-T_a_in.c3(tt_char)); % [W]

%% 3-stage-HE-Cold
CMin.HXC3(tt_char) = CMin_Rated.HXC3*m_air.comp(tt_char)/m_air.comp_rated;
NTU.HXC3(tt_char) = UA_Rated.HXC3*Scale.U_HE(m_air.comp(tt_char)/m_air.comp_rated)/CMin.HXC3(tt_char);
C_HX.HXC3(tt_char) = C_HX_Rated.HXC3; % assuming that C_c_HX keeps as the rated value; / can adjust
Sigma.HXC3(tt_char) = (1-exp(-NTU.HXC3(tt_char)*(1-C_HX.HXC3(tt_char))))/ ...
                      (1-C_HX.HXC3(tt_char)*exp(-NTU.HXC3(tt_char)*(1-C_HX.HXC3(tt_char))));
if OFFDesign.HEC
    Coeff_Phi(tt_char) = Sigma.HXC3_rated*CMin_Rated.HXC3; 
else
    Coeff_Phi(tt_char) = Sigma.HXC3(tt_char)*CMin.HXC3(tt_char); 
end
T_a_in.HXC3(tt_char) = T_a_out.c3(tt_char); % [K]
T_a_HTF.HXC3(tt_char) = T_HTF_in.HXC3_rated; % [K]
Phi.HXC3(tt_char) = Coeff_Phi(tt_char)*(T_HTF_in.HXC3_rated-T_a_in.HXC3(tt_char)); % [W]
T_a_out.HXC3(tt_char) = T_a_in.HXC3(tt_char)+Phi.HXC3(tt_char)/(Cp.Air*m_air.comp(tt_char)); % [K]
T_HTF_out.HXC3(tt_char) = T_HTF_in.HXC3_rated-Phi.HXC3(tt_char)/(Cp.Air*m_air.comp(tt_char)/C_HX_Rated.HXC3); % [K]
m_HTF.HXC3(tt_char) = m_air.comp(tt_char)*Cp.Air*(T_a_in.HXC3(tt_char)-T_a_out.HXC3(tt_char))/ ...
                       (Cp.HTF*(T_HTF_out.HXC3(tt_char)-T_HTF_in.HXC3_rated)); % [kg/s]
eta_P.HXC3(tt_char) = 1-PressureDrop.HXC*0.0083*Sigma.HXC3(tt_char)/(1-Sigma.HXC3(tt_char)); % [-]
p_a_in.HXC3(tt_char) = p_a_out.c3(tt_char); % [kPa]
p_a_out.HXC3(tt_char) = eta_P.HXC3(tt_char)*p_a_in.HXC3(tt_char); % [kPa]

%% 4-stage-Comp
T_a_in.c4(tt_char) = T_a_out.HXC3(tt_char); % [K]
p_a_in.c4(tt_char) = p_a_out.HXC3(tt_char); % [KPa]
if OFFDesign.Comp
    eta.c4(tt_char) = eta.c4_rated*Scale.Eta_Comp(m_air.comp(tt_char)/m_air.comp_rated); % [-]
    beta.c4(tt_char) = beta.c4_rated*Scale.Beta_Comp(m_air.comp(tt_char)/m_air.comp_rated); % [-]
else
    eta.c4(tt_char) = eta.c4_rated; % [-]
    beta.c4(tt_char) = beta.c4_rated; % [-]
end
p_a_out.c4(tt_char) = p_a_in.c4(tt_char)*beta.c4(tt_char); % [KPa]
T_a_out.c4(tt_char) = 1/eta.c4(tt_char)*T_a_in.c4(tt_char)*(beta.c4(tt_char)^lambda+eta.c4(tt_char)-1); % [K]
W_char.c4(tt_char) = m_air.comp(tt_char)*Cp.Air*(T_a_out.c4(tt_char)-T_a_in.c4(tt_char)); % [W]

%% 4-stage-HE-Cold
CMin.HXC4(tt_char) = CMin_Rated.HXC4*m_air.comp(tt_char)/m_air.comp_rated;
NTU.HXC4(tt_char) = UA_Rated.HXC4*Scale.U_HE(m_air.comp(tt_char)/m_air.comp_rated)/CMin.HXC4(tt_char);
C_HX.HXC4(tt_char) = C_HX_Rated.HXC4; % assuming that C_c_HX keeps as the rated value; / can adjust
Sigma.HXC4(tt_char) = (1-exp(-NTU.HXC4(tt_char)*(1-C_HX.HXC4(tt_char))))/ ...
                      (1-C_HX.HXC4(tt_char)*exp(-NTU.HXC4(tt_char)*(1-C_HX.HXC4(tt_char))));
if OFFDesign.HEC
    Coeff_Phi(tt_char) = Sigma.HXC4_rated*CMin_Rated.HXC4; 
else
    Coeff_Phi(tt_char) = Sigma.HXC4(tt_char)*CMin.HXC4(tt_char); 
end
T_a_in.HXC4(tt_char) = T_a_out.c4(tt_char); % [K]
T_a_HTF.HXC4(tt_char) = T_HTF_in.HXC4_rated; % [K]
Phi.HXC4(tt_char) = Coeff_Phi(tt_char)*(T_HTF_in.HXC4_rated-T_a_in.HXC4(tt_char)); % [W]
T_a_out.HXC4(tt_char) = T_a_in.HXC4(tt_char)+Phi.HXC4(tt_char)/(Cp.Air*m_air.comp(tt_char)); % [K]
T_HTF_out.HXC4(tt_char) = T_HTF_in.HXC4_rated-Phi.HXC4(tt_char)/(Cp.Air*m_air.comp(tt_char)/C_HX_Rated.HXC4); % [K]
m_HTF.HXC4(tt_char) = m_air.comp(tt_char)*Cp.Air*(T_a_in.HXC4(tt_char)-T_a_out.HXC4(tt_char))/ ...
                       (Cp.HTF*(T_HTF_out.HXC4(tt_char)-T_HTF_in.HXC4_rated)); % [kg/s]
eta_P.HXC4(tt_char) = 1-PressureDrop.HXC*0.0083*Sigma.HXC4(tt_char)/(1-Sigma.HXC4(tt_char)); % [-]
p_a_in.HXC4(tt_char) = p_a_out.c4(tt_char); % [kPa]
p_a_out.HXC4(tt_char) = eta_P.HXC4(tt_char)*p_a_in.HXC4(tt_char); % [kPa]

%% 5-stage-Comp
T_a_in.c5(tt_char) = T_a_out.HXC4(tt_char); % [K]
p_a_in.c5(tt_char) = p_a_out.HXC4(tt_char); % [KPa]
if OFFDesign.Comp
    eta.c5(tt_char) = eta.c5_rated*Scale.Eta_Comp(m_air.comp(tt_char)/m_air.comp_rated); % [-]
    beta.c5(tt_char) = beta.c5_rated*Scale.Beta_Comp(m_air.comp(tt_char)/m_air.comp_rated); % [-]
else
    eta.c5(tt_char) = eta.c5_rated; % [-]
    beta.c5(tt_char) = beta.c5_rated; % [-]
end
p_a_out.c5(tt_char) = p_a_in.c5(tt_char)*beta.c5(tt_char); % [KPa]
T_a_out.c5(tt_char) = 1/eta.c5(tt_char)*T_a_in.c5(tt_char)*(beta.c5(tt_char)^lambda+eta.c5(tt_char)-1); % [K]
W_char.c5(tt_char) = m_air.comp(tt_char)*Cp.Air*(T_a_out.c5(tt_char)-T_a_in.c5(tt_char)); % [W]

%% 5-stage-HE-Cold
CMin.HXC5(tt_char) = CMin_Rated.HXC5*m_air.comp(tt_char)/m_air.comp_rated;
NTU.HXC5(tt_char) = UA_Rated.HXC5*Scale.U_HE(m_air.comp(tt_char)/m_air.comp_rated)/CMin.HXC5(tt_char);
C_HX.HXC5(tt_char) = C_HX_Rated.HXC5; % assuming that C_c_HX keeps as the rated value; / can adjust
Sigma.HXC5(tt_char) = (1-exp(-NTU.HXC5(tt_char)*(1-C_HX.HXC5(tt_char))))/ ...
                      (1-C_HX.HXC5(tt_char)*exp(-NTU.HXC5(tt_char)*(1-C_HX.HXC5(tt_char))));
if OFFDesign.HEC
    Coeff_Phi(tt_char) = Sigma.HXC5_rated*CMin_Rated.HXC5; 
else
    Coeff_Phi(tt_char) = Sigma.HXC5(tt_char)*CMin.HXC5(tt_char); 
end
T_a_in.HXC5(tt_char) = T_a_out.c5(tt_char); % [K]
T_a_HTF.HXC5(tt_char) = T_HTF_in.HXC5_rated; % [K]
Phi.HXC5(tt_char) = Coeff_Phi(tt_char)*(T_HTF_in.HXC5_rated-T_a_in.HXC5(tt_char)); % [W]
T_a_out.HXC5(tt_char) = T_a_in.HXC5(tt_char)+Phi.HXC5(tt_char)/(Cp.Air*m_air.comp(tt_char)); % [K]
T_HTF_out.HXC5(tt_char) = T_HTF_in.HXC5_rated-Phi.HXC5(tt_char)/(Cp.Air*m_air.comp(tt_char)/C_HX_Rated.HXC5); % [K]
m_HTF.HXC5(tt_char) = m_air.comp(tt_char)*Cp.Air*(T_a_in.HXC5(tt_char)-T_a_out.HXC5(tt_char))/ ...
                       (Cp.HTF*(T_HTF_out.HXC5(tt_char)-T_HTF_in.HXC5_rated)); % [kg/s]
eta_P.HXC5(tt_char) = 1-PressureDrop.HXC*0.0083*Sigma.HXC5(tt_char)/(1-Sigma.HXC5(tt_char)); % [-]
p_a_in.HXC5(tt_char) = p_a_out.c5(tt_char); % [kPa]
p_a_out.HXC5(tt_char) = eta_P.HXC5(tt_char)*p_a_in.HXC5(tt_char); % [kPa]