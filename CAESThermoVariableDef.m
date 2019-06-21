%% Energy Conversion Module V2.0
% air mass flow rates 
m_air.comp = zeros(1,length(TT_Char));
m_air.turb = zeros(1,length(TT_Disc));

% compressor/turbine efficiency
eta.c1 = zeros(1,length(TT_Char));
eta.c2 = zeros(1,length(TT_Char));
eta.c3 = zeros(1,length(TT_Char));
eta.c4 = zeros(1,length(TT_Char));
eta.c5 = zeros(1,length(TT_Char));
eta.e1 = zeros(1,length(TT_Disc));
eta.e2 = zeros(1,length(TT_Disc));
eta.e3 = zeros(1,length(TT_Disc));

% compression and expansion ratio
beta.c1 = zeros(1,length(TT_Char));
beta.c2 = zeros(1,length(TT_Char));
beta.c3 = zeros(1,length(TT_Char));
beta.c4 = zeros(1,length(TT_Char));
beta.c5 = zeros(1,length(TT_Char));
beta.e1 = zeros(1,length(TT_Disc));
beta.e2 = zeros(1,length(TT_Disc));
beta.e3 = zeros(1,length(TT_Disc));

% inlet air temperature of compressor/turbine
T_a_in.c1 = zeros(1,length(TT_Char));
T_a_in.c2 = zeros(1,length(TT_Char));
T_a_in.c3 = zeros(1,length(TT_Char));
T_a_in.c4 = zeros(1,length(TT_Char));
T_a_in.c5 = zeros(1,length(TT_Char));
T_a_in.e1 = zeros(1,length(TT_Disc));
T_a_in.e2 = zeros(1,length(TT_Disc));
T_a_in.e3 = zeros(1,length(TT_Disc));

% outlet air temperature of compressor/turbine
T_a_out.c1 = zeros(1,length(TT_Char));
T_a_out.c2 = zeros(1,length(TT_Char));
T_a_out.c3 = zeros(1,length(TT_Char));
T_a_out.c4 = zeros(1,length(TT_Char));
T_a_out.c5 = zeros(1,length(TT_Char));
T_a_out.e1 = zeros(1,length(TT_Disc));
T_a_out.e2 = zeros(1,length(TT_Disc));
T_a_out.e3 = zeros(1,length(TT_Disc));

% inlet air pressure of compressor/turbine
p_a_in.c1 = zeros(1,length(TT_Char));
p_a_in.c2 = zeros(1,length(TT_Char));
p_a_in.c3 = zeros(1,length(TT_Char));
p_a_in.c4 = zeros(1,length(TT_Char));
p_a_in.c5 = zeros(1,length(TT_Char));
p_a_in.e1 = zeros(1,length(TT_Disc));
p_a_in.e2 = zeros(1,length(TT_Disc));
p_a_in.e3 = zeros(1,length(TT_Disc));

% outlet air pressure of compressor/turbine
p_a_out.c1 = zeros(1,length(TT_Char));
p_a_out.c2 = zeros(1,length(TT_Char));
p_a_out.c3 = zeros(1,length(TT_Char));
p_a_out.c4 = zeros(1,length(TT_Char));
p_a_out.c5 = zeros(1,length(TT_Char));
p_a_out.e1 = zeros(1,length(TT_Disc));
p_a_out.e2 = zeros(1,length(TT_Disc));
p_a_out.e3 = zeros(1,length(TT_Disc));

% power consumption/generation of compressor/turbine
W_char.c1 = zeros(1,length(TT_Char));
W_char.c2 = zeros(1,length(TT_Char));
W_char.c3 = zeros(1,length(TT_Char));
W_char.c4 = zeros(1,length(TT_Char));
W_char.c5 = zeros(1,length(TT_Char));
W_disc.e1 = zeros(1,length(TT_Disc));
W_disc.e2 = zeros(1,length(TT_Disc));
W_disc.e3 = zeros(1,length(TT_Disc));
W_char.all = zeros(1,length(TT_Char));
W_disc.all = zeros(1,length(TT_Disc));

% compessor on/off at the slide charging mode
CompOn.c1 = zeros(1,length(TT_Char));
CompOn.c2 = zeros(1,length(TT_Char));
CompOn.c3 = zeros(1,length(TT_Char));
CompOn.c4 = zeros(1,length(TT_Char));
CompOn.c5 = zeros(1,length(TT_Char));

%% Energy Transfer Module
% NTU of heat exchanger at compression/expansion side
NTU.HXC1 = zeros(1,length(TT_Char));
NTU.HXC2 = zeros(1,length(TT_Char));
NTU.HXC3 = zeros(1,length(TT_Char));
NTU.HXC4 = zeros(1,length(TT_Char));
NTU.HXC5 = zeros(1,length(TT_Char));
NTU.HXH1 = zeros(1,length(TT_Disc));
NTU.HXH2 = zeros(1,length(TT_Disc));
NTU.HXH3 = zeros(1,length(TT_Disc));

% efficiency of heat exchanger
Sigma.HXC1 = zeros(1,length(TT_Char));
Sigma.HXC2 = zeros(1,length(TT_Char));
Sigma.HXC3 = zeros(1,length(TT_Char));
Sigma.HXC4 = zeros(1,length(TT_Char));
Sigma.HXC5 = zeros(1,length(TT_Char));
Sigma.HXH1 = zeros(1,length(TT_Disc));
Sigma.HXH2 = zeros(1,length(TT_Disc));
Sigma.HXH3 = zeros(1,length(TT_Disc));

% Cmin of heat exchanger
CMin.HXC1 = zeros(1,length(TT_Char));
CMin.HXC2 = zeros(1,length(TT_Char));
CMin.HXC3 = zeros(1,length(TT_Char));
CMin.HXC4 = zeros(1,length(TT_Char));
CMin.HXC5 = zeros(1,length(TT_Char));
CMin.HXH1 = zeros(1,length(TT_Disc));
CMin.HXH2 = zeros(1,length(TT_Disc));
CMin.HXH3 = zeros(1,length(TT_Disc));

% Heat Exchange of heat exchanger
Phi.HXC1 = zeros(1,length(TT_Char));
Phi.HXC2 = zeros(1,length(TT_Char));
Phi.HXC3 = zeros(1,length(TT_Char));
Phi.HXC4 = zeros(1,length(TT_Char));
Phi.HXC5 = zeros(1,length(TT_Char));
Phi.HXH1 = zeros(1,length(TT_Disc));
Phi.HXH2 = zeros(1,length(TT_Disc));
Phi.HXH3 = zeros(1,length(TT_Disc));

% Heat Capacity Ratio of heat exchanger
C_HX.HXC1 = zeros(1,length(TT_Char));
C_HX.HXC2 = zeros(1,length(TT_Char));
C_HX.HXC3 = zeros(1,length(TT_Char));
C_HX.HXC4 = zeros(1,length(TT_Char));
C_HX.HXC5 = zeros(1,length(TT_Char));
C_HX.HXH1 = zeros(1,length(TT_Disc));
C_HX.HXH2 = zeros(1,length(TT_Disc));
C_HX.HXH3 = zeros(1,length(TT_Disc));

% Inlet air pressure of heat exchanger
p_a_in.HXC1 = zeros(1,length(TT_Char));
p_a_in.HXC2 = zeros(1,length(TT_Char));
p_a_in.HXC3 = zeros(1,length(TT_Char));
p_a_in.HXC4 = zeros(1,length(TT_Char));
p_a_in.HXC5 = zeros(1,length(TT_Char));
p_a_in.HXH1 = zeros(1,length(TT_Disc));
p_a_in.HXH2 = zeros(1,length(TT_Disc));
p_a_in.HXH3 = zeros(1,length(TT_Disc));

% outlet air pressure of heat exchanger
p_a_out.HXC1 = zeros(1,length(TT_Char));
p_a_out.HXC2 = zeros(1,length(TT_Char));
p_a_out.HXC3 = zeros(1,length(TT_Char));
p_a_out.HXC4 = zeros(1,length(TT_Char));
p_a_out.HXC5 = zeros(1,length(TT_Char));
p_a_out.HXH1 = zeros(1,length(TT_Disc));
p_a_out.HXH2 = zeros(1,length(TT_Disc));
p_a_out.HXH3 = zeros(1,length(TT_Disc));

% inlet air temperature of heat exchanger
T_a_in.HXC1 = zeros(1,length(TT_Char));
T_a_in.HXC2 = zeros(1,length(TT_Char));
T_a_in.HXC3 = zeros(1,length(TT_Char));
T_a_in.HXC4 = zeros(1,length(TT_Char));
T_a_in.HXC5 = zeros(1,length(TT_Char));
T_a_in.HXH1 = zeros(1,length(TT_Disc));
T_a_in.HXH2 = zeros(1,length(TT_Disc));
T_a_in.HXH3 = zeros(1,length(TT_Disc));

% outlet air temperature of heat exchanger
T_a_out.HXC1 = zeros(1,length(TT_Char));
T_a_out.HXC2 = zeros(1,length(TT_Char));
T_a_out.HXC3 = zeros(1,length(TT_Char));
T_a_out.HXC4 = zeros(1,length(TT_Char));
T_a_out.HXC5 = zeros(1,length(TT_Char));
T_a_out.HXH1 = zeros(1,length(TT_Disc));
T_a_out.HXH2 = zeros(1,length(TT_Disc));
T_a_out.HXH3 = zeros(1,length(TT_Disc));

% inlet HTF temperature of heat exchanger
T_HTF_in.HXC1 = zeros(1,length(TT_Char));
T_HTF_in.HXC2 = zeros(1,length(TT_Char));
T_HTF_in.HXC3 = zeros(1,length(TT_Char));
T_HTF_in.HXC4 = zeros(1,length(TT_Char));
T_HTF_in.HXC5 = zeros(1,length(TT_Char));
T_HTF_in.HXH1 = zeros(1,length(TT_Disc));
T_HTF_in.HXH2 = zeros(1,length(TT_Disc));
T_HTF_in.HXH3 = zeros(1,length(TT_Disc));

% outlet HTF temperature of heat exchanger
T_HTF_out.HXC1 = zeros(1,length(TT_Char));
T_HTF_out.HXC2 = zeros(1,length(TT_Char));
T_HTF_out.HXC3 = zeros(1,length(TT_Char));
T_HTF_out.HXC4 = zeros(1,length(TT_Char));
T_HTF_out.HXC5 = zeros(1,length(TT_Char));
T_HTF_out.HXH1 = zeros(1,length(TT_Disc));
T_HTF_out.HXH2 = zeros(1,length(TT_Disc));
T_HTF_out.HXH3 = zeros(1,length(TT_Disc));

% mass flow rates of HTF of heat exchanger
m_HTF.HXC1 = zeros(1,length(TT_Char));
m_HTF.HXC2 = zeros(1,length(TT_Char));
m_HTF.HXC3 = zeros(1,length(TT_Char));
m_HTF.HXC4 = zeros(1,length(TT_Char));
m_HTF.HXC5 = zeros(1,length(TT_Char));
m_HTF.HXH1 = zeros(1,length(TT_Disc));
m_HTF.HXH2 = zeros(1,length(TT_Disc));
m_HTF.HXH3 = zeros(1,length(TT_Disc));

% Pressure Drop factor
eta_P.HXC1 = zeros(1,length(TT_Char));
eta_P.HXC2 = zeros(1,length(TT_Char));
eta_P.HXC3 = zeros(1,length(TT_Char));
eta_P.HXC4 = zeros(1,length(TT_Char));
eta_P.HXC5 = zeros(1,length(TT_Char));
eta_P.HXH1 = zeros(1,length(TT_Disc));
eta_P.HXH2 = zeros(1,length(TT_Disc));
eta_P.HXH3 = zeros(1,length(TT_Disc));

%% Energy Storage Module
% air storage chamber
p_as_in = zeros(1,length(TT_Char));
T_as_in = zeros(1,length(TT_Char));
p_as_out = zeros(1,length(TT_Disc));
T_as_out = zeros(1,length(TT_Disc));

M_as.Char = zeros(1,length(TT_Char)); % charging process
T_as.Char = zeros(1,length(TT_Char)); 
P_as.Char = zeros(1,length(TT_Char)); 
M_as.Disc = zeros(1,length(TT_Disc)); % discharging process
T_as.Disc = zeros(1,length(TT_Disc)); 
P_as.Disc = zeros(1,length(TT_Disc)); 

P_as.Delta_Char = zeros(1,length(TT_Char)); % for G model
P_as.Delta_Disc = zeros(1,length(TT_Disc));
T_as.Delta_Char = zeros(1,length(TT_Char));
T_as.Delta_Disc = zeros(1,length(TT_Disc));

P_as_in_SP_Req = zeros(1,length(TT_Char)); % Air pressure requirement

% thermal storage tank
T_TES.Char = zeros(1,length(TT_Char));
M_TES.Char = zeros(1,length(TT_Char));
T_TES.Disc = zeros(1,length(TT_Disc));
M_TES.Disc = zeros(1,length(TT_Disc));

m_HTF.TES_in = zeros(1,length(TT_Char));
m_HTF.TES_out = zeros(1,length(TT_Disc));
T_HTF_in.TES = zeros(1,length(TT_Char));
T_HTF_out.TES = zeros(1,length(TT_Disc));