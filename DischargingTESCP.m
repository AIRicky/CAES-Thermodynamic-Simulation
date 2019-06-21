% TES discharging
m_HTF.HXH1(tt_disc) = m_HTF.HXH1_rated*m_air.turb(tt_disc)/m_air.turb_rated;
m_HTF.HXH2(tt_disc) = m_HTF.HXH2_rated*m_air.turb(tt_disc)/m_air.turb_rated;
m_HTF.HXH3(tt_disc) = m_HTF.HXH3_rated*m_air.turb(tt_disc)/m_air.turb_rated;
m_HTF.TES_out(tt_disc) = m_HTF.HXH1(tt_disc) + m_HTF.HXH2(tt_disc) + m_HTF.HXH3(tt_disc);
if tt_disc == 1
    M_TES.Disc(1) = M_TES.disc0 - m_HTF.TES_out(1)*tstep; 
    T_TES.Disc(1) = T_TES.disc0; % need update
    T_HTF.TES_out(1) = T_TES.disc0; % need update
else
    M_TES.Disc(tt_disc) = M_TES.Disc(tt_disc-1) - m_HTF.TES_out(tt_disc)*tstep;
    T_TES.Disc(tt_disc) = (M_TES.Disc(tt_disc-1)*T_TES.Disc(tt_disc-1)-T_HTF.TES_out(tt_disc-1)*m_HTF.TES_out(tt_disc)*tstep)/M_TES.Disc(tt_disc); % there is a problem
    T_HTF.TES_out(tt_disc) = T_TES.Disc(tt_disc); %% ?? update
end  