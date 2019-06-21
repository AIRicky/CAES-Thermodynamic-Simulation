%% Exergy Model V1.0
% compressor
exergy_in.c1 = zeros(1,length(TT_Char));
exergy_in.c2 = zeros(1,length(TT_Char));
exergy_in.c3 = zeros(1,length(TT_Char));
exergy_in.c4 = zeros(1,length(TT_Char));
exergy_in.c5 = zeros(1,length(TT_Char));

exergy_out.c1 = zeros(1,length(TT_Char));
exergy_out.c2 = zeros(1,length(TT_Char));
exergy_out.c3 = zeros(1,length(TT_Char));
exergy_out.c4 = zeros(1,length(TT_Char));
exergy_out.c5 = zeros(1,length(TT_Char));

exergy_loss.c1 = zeros(1,length(TT_Char));
exergy_loss.c2 = zeros(1,length(TT_Char));
exergy_loss.c3 = zeros(1,length(TT_Char));
exergy_loss.c4 = zeros(1,length(TT_Char));
exergy_loss.c5 = zeros(1,length(TT_Char));

% turbine
exergy_in.e1 = zeros(1,length(TT_Disc));
exergy_in.e2 = zeros(1,length(TT_Disc));
exergy_in.e3 = zeros(1,length(TT_Disc));

exergy_out.e1 = zeros(1,length(TT_Disc));
exergy_out.e2 = zeros(1,length(TT_Disc));
exergy_out.e3 = zeros(1,length(TT_Disc));

exergy_loss.e1 = zeros(1,length(TT_Disc));
exergy_loss.e2 = zeros(1,length(TT_Disc));
exergy_loss.e3 = zeros(1,length(TT_Disc));

% heat exchanger at compressor side
exergy_in.HXC1 = zeros(1,length(TT_Char));
exergy_in.HXC2 = zeros(1,length(TT_Char));
exergy_in.HXC3 = zeros(1,length(TT_Char));
exergy_in.HXC4 = zeros(1,length(TT_Char));
exergy_in.HXC5 = zeros(1,length(TT_Char));

exergy_out.HXC1 = zeros(1,length(TT_Char));
exergy_out.HXC2 = zeros(1,length(TT_Char));
exergy_out.HXC3 = zeros(1,length(TT_Char));
exergy_out.HXC4 = zeros(1,length(TT_Char));
exergy_out.HXC5 = zeros(1,length(TT_Char));

exergy_loss.HXC1 = zeros(1,length(TT_Char));
exergy_loss.HXC2 = zeros(1,length(TT_Char));
exergy_loss.HXC3 = zeros(1,length(TT_Char));
exergy_loss.HXC4 = zeros(1,length(TT_Char));
exergy_loss.HXC5 = zeros(1,length(TT_Char));

% heat exchanger at turbine side
exergy_in.HXH1 = zeros(1,length(TT_Disc));
exergy_in.HXH2 = zeros(1,length(TT_Disc));
exergy_in.HXH3 = zeros(1,length(TT_Disc));

exergy_out.HXH1 = zeros(1,length(TT_Disc));
exergy_out.HXH2 = zeros(1,length(TT_Disc));
exergy_out.HXH3 = zeros(1,length(TT_Disc));

exergy_loss.HXH1 = zeros(1,length(TT_Disc));
exergy_loss.HXH2 = zeros(1,length(TT_Disc));
exergy_loss.HXH3 = zeros(1,length(TT_Disc));

% TV at compressor side
exergy_in.TVC = zeros(1,length(TT_Char));
exergy_out.TVC = zeros(1,length(TT_Char));
exergy_loss.TVC = zeros(1,length(TT_Char));

% TV at turbine side
exergy_in.TVE = zeros(1,length(TT_Disc));
exergy_out.TVE = zeros(1,length(TT_Disc));
exergy_loss.TVE = zeros(1,length(TT_Disc));

% TV at turbine side