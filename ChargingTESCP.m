% this model should be updated according to different TES schemes

m_HTF.TES_in(tt_char) = m_HTF.HXC1(tt_char)+m_HTF.HXC2(tt_char)+m_HTF.HXC3(tt_char)+m_HTF.HXC4(tt_char)+m_HTF.HXC5(tt_char);
T_HTF.TES_in(tt_char) = [m_HTF.HXC1(tt_char) m_HTF.HXC2(tt_char) m_HTF.HXC3(tt_char) m_HTF.HXC4(tt_char) ...
                         m_HTF.HXC5(tt_char)]* [T_HTF_out.HXC1(tt_char) T_HTF_out.HXC2(tt_char) T_HTF_out.HXC3(tt_char) ...
                         T_HTF_out.HXC4(tt_char) T_HTF_out.HXC5(tt_char)]'/m_HTF.TES_in(tt_char);
if tt_char == 1
    M_TES0_char = 0; % no water at initial time   
    M_TES.Char(1) = M_TES0_char + m_HTF.TES_in(1)*tstep; 
    T_TES.Char(1) = T_HTF.TES_in(1)*m_HTF.TES_in(1)*tstep/M_TES.Char(1);
else
    M_TES.Char(tt_char) = M_TES.Char(tt_char-1) + m_HTF.TES_in(tt_char)*tstep;
    T_TES.Char(tt_char) = (M_TES.Char(tt_char-1)*T_TES.Char(tt_char-1)+T_HTF.TES_in(tt_char)*m_HTF.TES_in(tt_char)*tstep)/M_TES.Char(tt_char);
end