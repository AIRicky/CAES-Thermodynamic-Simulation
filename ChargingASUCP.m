% ASU CP mode 
if strcmp(ASU_Model,'G')
    Radius_as = (5/3.14)^(0.5); % assuming 5[m^2]*20[m]
    A_as_W = (2*3.14*Radius_as)*20 + 2*3.14*(Radius_as)^2; % [m^2]
    alpha_w(tt_char) = 0.02356 + 0.0149*(m_air.comp(tt_char)).^(0.8);
    T_as_W = Ta0; % can be updated
    if  tt_char == 1
        M_as.Char(1) = M_Init + m_air.comp(1)*tstep; % [kg]   % first step
        T_as.Char(1) = Ta0 + 1/M_as.Char(1)*((1-1/1.4)*(m_air.comp(1)*T_as_in(1)))*tstep;% [K]
        P_as.Char(1) = Pa0 + (1.4*Rg*(m_air.comp(1)*T_as_in(1))/V_as*tstep)*From_Pa_to_KPa; % [KPa]
    else
        M_as.Char(tt_char) = M_as.Char(tt_char-1) + m_air.comp(tt_char)*tstep; % [kg]
        T_as.Delta_Char(tt_char) = alpha_w(tt_char)*A_as_W*(T_as_W-T_as.Char(tt_char-1))/(m_air.comp(tt_char)*Cp.Air); % [K]
        P_as.Delta_Char(tt_char) = Rg*(m_air.comp(tt_char)*Cp.Air)/(Cva*V_as)*T_as_Delta.Char(tt_char); % [KPa]
        P_as.Char(tt_char) = P_as.Char(tt_char-1) + (1.4*Rg*(m_c(tt_char)*T_as_in(tt_char))/V_as*tstep)*From_Pa_to_KPa; %[KPa]
        T_as.Char(tt_char) = T_as.Char(tt_char-1) + 1/M_as.Char(tt_char)*((1-1/1.4)*(m_air.comp(tt_char)*T_as_in(tt_char)))*tstep;%[K]
        P_as.Char(tt_char) = P_as.Char(tt_char) + P_as.Delta_Char(tt_char);
        T_as.Char(tt_char) = T_as.Char(tt_char) + T_as.Delta_Char(tt_char);
    end
end
%%% VT Model
if strcmp(ASU_Model, 'VT')
    T_as.Char(tt_char) = Ta0;
    if  tt_char == 1
        M_as.Char(1) = M_Init + m_air.comp(1)*tstep; % [kg]   % first step
        P_as.Char(1) = Pa0 + (1.4*Rg*(m_air.comp(1)*T_as_in(1))/V_as*tstep)*From_Pa_to_KPa; % [KPa]
    else
        M_as.Char(tt_char) = M_as.Char(tt_char-1) + m_air.comp(tt_char)*tstep; % [kg]
        P_as.Char(tt_char) = P_as_char(tt_char-1) + (1.4*Rg*(m_air.comp(tt_char)*T_as_in(tt_char))/V_as*tstep)*From_Pa_to_KPa; %[KPa]
    end  
end
%%%% VA Model 
if strcmp(ASU_Model, 'VA')
    if tt_char == 1
        M_as.Char(1) = M_Init + m_air.comp(1)*tstep; % [kg]   % first step
        T_as.Char(1) = Ta0 + 1/M_as.Char(1)*((1-1/1.4)*(m_air.comp(1)*T_as_in(1)))*tstep;% [K]
        P_as.Char(1) = Pa0 + (1.4*Rg*(m_air.comp(1)*T_as_in(1))/V_as*tstep)*From_Pa_to_KPa; % [KPa]
    else
        M_as.Char(tt_char) = M_as.Char(tt_char-1) + m_air.comp(tt_char)*tstep; % [kg]
        P_as.Char(tt_char) = P_as.Char(tt_char-1) + (1.4*Rg*(m_air.comp(tt_char)*T_as_in(tt_char))/V_as*tstep)*From_Pa_to_KPa; %[KPa]
        T_as.Char(tt_char) = T_as.Char(tt_char-1) + 1/M_as.Char(tt_char)*((1-1/1.4)*(m_air.comp(tt_char)*T_as_in(tt_char)))*tstep;%[K]
    end
end