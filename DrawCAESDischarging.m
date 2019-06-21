%% Discharging visulization interface V1.0
%%% Air Pressure
figure
plot(1/60*tstep*time_period_disc, p_a_in.e1(time_period_disc)*1e-3, 'r-'); % KPa -> MPa
hold on
plot(1/60*tstep*time_period_disc, p_a_in.e2(time_period_disc)*1e-3, 'g-');
plot(1/60*tstep*time_period_disc, p_a_in.e3(time_period_disc)*1e-3, 'b-');
plot(1/60*tstep*time_period_disc, P_as.Disc(time_period_disc)*1e-3, 'k-.')
if strcmp(DrawOption.lang, 'ch')
    xlabel('时间 (min)');
    ylabel('压力 (MPa)')
    legend('一级透平进气', '二级透平进气', '三级透平进气', '储气压力')
    if strcmp(TV_Mode.Turb, 'CP')
       title('常压放气模式下的进气压力')
    else       
       title('滑压放气模式下的进气压力')
    end
else % 'en' 
    % pass
end

%%% Power generation
figure
W_disc.all = W_disc.e1 + W_disc.e2 + W_disc.e3;
plot(1/60*tstep*time_period_disc, W_disc.e1(time_period_disc)*1e-3, 'r-'); % W -> kW
hold on
plot(1/60*tstep*time_period_disc, W_disc.e2(time_period_disc)*1e-3, 'g-');
plot(1/60*tstep*time_period_disc, W_disc.e3(time_period_disc)*1e-3, 'b-');
plot(1/60*tstep*time_period_disc, W_disc.all(time_period_disc)*1e-3, 'k-.')
if strcmp(DrawOption.lang, 'ch')
    xlabel('时间 (min)');
    ylabel('功率 (kW)')
    legend('一级透平', '二级透平', '三级透平', '总功率')
    if strcmp(TV_Mode.Turb, 'CP')
       title('常压放气模式下的透平输出功')
    else       
       title('滑压放气模式下的透平输出功')
    end
else
    % pass
end

%%% Heat Exchanger heat exchanger amount
figure
plot(1/60*tstep*time_period_disc, Phi.HXH1(time_period_disc)*1e-3, 'r-'); % W -> kW
hold on
plot(1/60*tstep*time_period_disc, Phi.HXH2(time_period_disc)*1e-3, 'g-');
plot(1/60*tstep*time_period_disc, Phi.HXH3(time_period_disc)*1e-3, 'b-');
if strcmp(DrawOption.lang, 'ch')
    xlabel('时间 (min)');
    ylabel('换热量 (kW)')
    legend('一级换热器', '二级换热器', '三级换热器')
    if strcmp(TV_Mode.Turb, 'CP')
       title('常压放气模式下的换热量')
    else       
       title('滑压放气模式下的换热量')
    end
else
    % pass
end

%%% Inlet and outlet temperature of HX
figure
subplot(2,2,1)
plot(1/60*tstep*time_period_disc, T_a_in.HXH1(time_period_disc),'r-'); % [K]
hold on
plot(1/60*tstep*time_period_disc, T_HTF_in.HXH1(time_period_disc),'b-');
plot(1/60*tstep*time_period_disc, T_a_out.HXH1(time_period_disc),'r-.');
plot(1/60*tstep*time_period_disc, T_HTF_out.HXH1(time_period_disc),'b-.');
legend('入口空气', '入口HTF', '出口空气', '出口HTF')
xlabel('时间 (min)')
ylabel('温度 (K)')
if strcmp(TV_Mode.Turb, 'CP')
   title('常压放气模式下的一级换热器温度')
else       
   title('滑压放气模式下的一级换热器温度')
end

subplot(2,2,2)
plot(1/60*tstep*time_period_disc, T_a_in.HXH2(time_period_disc),'r-'); % [K]
hold on
plot(1/60*tstep*time_period_disc, T_HTF_in.HXH2(time_period_disc),'b-');
plot(1/60*tstep*time_period_disc, T_a_out.HXH2(time_period_disc),'r-.');
plot(1/60*tstep*time_period_disc, T_HTF_out.HXH2(time_period_disc),'b-.');
legend('入口空气', '入口HTF', '出口空气', '出口HTF')
xlabel('时间 (min)')
ylabel('温度 (K)')
if strcmp(TV_Mode.Turb, 'CP')
   title('常压放气模式下的二级换热器温度')
else       
   title('滑压放气模式下的二级换热器温度')
end

subplot(2,2,3)
plot(1/60*tstep*time_period_disc, T_a_in.HXH3(time_period_disc),'r-'); % [K]
hold on
plot(1/60*tstep*time_period_disc, T_HTF_in.HXH3(time_period_disc),'b-');
plot(1/60*tstep*time_period_disc, T_a_out.HXC3(time_period_disc),'r-.');
plot(1/60*tstep*time_period_disc, T_HTF_out.HXC3(time_period_disc),'b-.');
legend('入口空气', '入口HTF', '出口空气', '出口HTF')
xlabel('时间 (min)')
ylabel('温度 (K)')
if strcmp(TV_Mode.Turb, 'CP')
   title('常压放气模式下的三级换热器温度')
else       
   title('滑压放气模式下的三级换热器温度')
end

%%% Mass/Pressure/Temperature of ASU
figure
subplot(2,1,1)
plot(1/60*tstep*time_period_disc, M_as.Disc(time_period_disc), 'r-'); % kg
if strcmp(DrawOption.lang, 'ch')
    xlabel('时间 (min)');
    ylabel('空气质量 (kg)')
    if strcmp(TV_Mode.Turb, 'CP')
       title('常压放气模式下的储气库空气质量')
    else       
       title('滑压放气模式下的储气库空气质量')
    end
else
    % pass
end

subplot(2,1,2)
hAx = plotyy(1/60*tstep*time_period_disc,P_as.Disc(time_period_disc)*1e-3,1/60*tstep*time_period_disc,T_as.Disc(time_period_disc));
xlabel('时间 (min)')
ylabel(hAx(1), '储气库压力 (MPa)')
ylabel(hAx(2), '储气库温度 (K)')
if strcmp(TV_Mode.Comp, 'CP')
    title('常压放气模式下的储气库动态特性')
else
    title('滑压放气模式下的储气库动态特性')
end

%%% Mass and Temperature of TES
figure
hAx = plotyy(1/60*tstep*time_period_disc, T_TES.Disc(time_period_disc), 1/60*tstep*time_period_disc, M_TES.Disc(time_period_disc));
xlabel('时间 (min)')
ylabel(hAx(1), '储热罐温度 (K)')
ylabel(hAx(2), '储热罐质量 (Kg)')
hAx(1).YLim = [270,450];
if strcmp(TV_Mode.Turb, 'CP')
    title('常压放气模式下的储热罐动态特性')
else
    title('滑压放气模式下的储热罐动态特性')
end