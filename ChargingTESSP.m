%% TES model should be updated 
if tt_char == 1
    M_TES0_char = 0; % no water at initial time   
    M_TES.Char(1) = M_TES0_char + m_HTF.TES_in(1)*tstep; 
    T_TES.Char(1) = T_HTF.TES_in(1)*m_HTF.TES_in(1)*tstep/M_TES.Char(1);
else
    M_TES.Char(tt_char) = M_TES.Char(tt_char-1) + m_HTF.TES_in(tt_char)*tstep;
    T_TES.Char(tt_char) = (M_TES.Char(tt_char-1)*T_TES.Char(tt_char-1)+T_HTF.TES_in(tt_char)*m_HTF.TES_in(tt_char)*tstep)/M_TES.Char(tt_char);
end