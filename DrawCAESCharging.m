%% Charging visulization interface V1.0
%%% Air Pressure
figure
if strcmp(TV_Mode.Comp, 'SP')
    plot(1/60*tstep*time_period_char, CompOn.c1(time_period_char).*p_a_out.c1(time_period_char)*1e-3, 'r-'); % KPa -> MPa
    hold on
    plot(1/60*tstep*time_period_char, CompOn.c2(time_period_char).*p_a_out.c2(time_period_char)*1e-3, 'g-');
    plot(1/60*tstep*time_period_char, CompOn.c3(time_period_char).*p_a_out.c3(time_period_char)*1e-3, 'b-');
    plot(1/60*tstep*time_period_char, CompOn.c4(time_period_char).*p_a_out.c4(time_period_char)*1e-3, 'm-');
    plot(1/60*tstep*time_period_char, CompOn.c5(time_period_char).*p_a_out.c4(time_period_char)*1e-3, 'c-');
    plot(1/60*tstep*time_period_char, P_as.Char(time_period_char)*1e-3, 'k-.')
else
    plot(1/60*tstep*time_period_char, p_a_out.c1(time_period_char)*1e-3, 'r-'); % KPa -> MPa
    hold on
    plot(1/60*tstep*time_period_char, p_a_out.c2(time_period_char)*1e-3, 'g-');
    plot(1/60*tstep*time_period_char, p_a_out.c3(time_period_char)*1e-3, 'b-');
    plot(1/60*tstep*time_period_char, p_a_out.c4(time_period_char)*1e-3, 'm-');
    plot(1/60*tstep*time_period_char, p_a_out.c4(time_period_char)*1e-3, 'c-');
    plot(1/60*tstep*time_period_char, P_as.Char(time_period_char)*1e-3, 'k-.')
end

if strcmp(DrawOption.lang, 'ch')
    xlabel('时间 (min)');
    ylabel('压力 (MPa)')
    legend('一级压缩机排气', '二级压缩机排气', '三级压缩机排气', '四级压缩机排气', '五级压缩机排气', '储气压力')
    if strcmp(TV_Mode.Comp, 'CP')
       title('常压充气模式下的排气压力')
    else       
       title('滑压充气模式下的排气压力')
    end
else % 'en' 
    % pass
end

%%% Power Consumption
figure
if strcmp(TV_Mode.Comp, 'SP')
    W_char.all = CompOn.c1.*W_char.c1 + CompOn.c2.*W_char.c2 + CompOn.c3.*W_char.c3 + CompOn.c4.*W_char.c4 + CompOn.c5.*W_char.c5;
    plot(1/60*tstep*time_period_char, CompOn.c1(time_period_char).*W_char.c1(time_period_char)*1e-3, 'r-'); % W -> kW
    hold on
    plot(1/60*tstep*time_period_char, CompOn.c2(time_period_char).*W_char.c2(time_period_char)*1e-3, 'g-');
    plot(1/60*tstep*time_period_char, CompOn.c3(time_period_char).*W_char.c3(time_period_char)*1e-3, 'b-');
    plot(1/60*tstep*time_period_char, CompOn.c4(time_period_char).*W_char.c4(time_period_char)*1e-3, 'm-');
    plot(1/60*tstep*time_period_char, CompOn.c5(time_period_char).*W_char.c5(time_period_char)*1e-3, 'c-');
    plot(1/60*tstep*time_period_char, W_char.all(time_period_char)*1e-3, 'k-.')
else
    W_char.all = W_char.c1 + W_char.c2 + W_char.c3 + W_char.c4 + W_char.c5;
    plot(1/60*tstep*time_period_char, W_char.c1(time_period_char)*1e-3, 'r-'); % W -> kW
    hold on
    plot(1/60*tstep*time_period_char, W_char.c2(time_period_char)*1e-3, 'g-');
    plot(1/60*tstep*time_period_char, W_char.c3(time_period_char)*1e-3, 'b-');
    plot(1/60*tstep*time_period_char, W_char.c4(time_period_char)*1e-3, 'm-');
    plot(1/60*tstep*time_period_char, W_char.c5(time_period_char)*1e-3, 'c-');
    plot(1/60*tstep*time_period_char, W_char.all(time_period_char)*1e-3, 'k-.')
end

if strcmp(DrawOption.lang, 'ch')
    xlabel('时间 (min)');
    ylabel('功率 (kW)')
    legend('一级压缩机', '二级压缩机', '三级压缩机', '四级压缩机', '五级压缩机', '总耗功')
    if strcmp(TV_Mode.Comp, 'CP')
       title('常压充气模式下的压缩机耗功')
    else       
       title('滑压充气模式下的压缩机耗功')
    end
else
    % pass
end

%%% Heat Exchanger heat exchanger amount
figure
if strcmp(TV_Mode.Comp, 'SP')
    plot(1/60*tstep*time_period_char, abs(CompOn.c1(time_period_char).*Phi.HXC1(time_period_char)*1e-3), 'r-'); % W -> kW
    hold on
    plot(1/60*tstep*time_period_char, abs(CompOn.c2(time_period_char).*Phi.HXC2(time_period_char)*1e-3), 'g-');
    plot(1/60*tstep*time_period_char, abs(CompOn.c3(time_period_char).*Phi.HXC3(time_period_char)*1e-3), 'b-');
    plot(1/60*tstep*time_period_char, abs(CompOn.c4(time_period_char).*Phi.HXC4(time_period_char)*1e-3), 'm-');
    plot(1/60*tstep*time_period_char, abs(CompOn.c5(time_period_char).*Phi.HXC5(time_period_char)*1e-3), 'c-');
else
    plot(1/60*tstep*time_period_char, abs(Phi.HXC1(time_period_char)*1e-3), 'r-'); % W -> kW
    hold on
    plot(1/60*tstep*time_period_char, abs(Phi.HXC2(time_period_char)*1e-3), 'g-');
    plot(1/60*tstep*time_period_char, abs(Phi.HXC3(time_period_char)*1e-3), 'b-');
    plot(1/60*tstep*time_period_char, abs(Phi.HXC4(time_period_char)*1e-3), 'm-');
    plot(1/60*tstep*time_period_char, abs(Phi.HXC5(time_period_char)*1e-3), 'c-');
end

if strcmp(DrawOption.lang, 'ch')
    xlabel('时间 (min)');
    ylabel('换热量 (kW)')
    legend('一级换热器', '二级换热器', '三级换热器', '四级换热器', '五级换热器')
    if strcmp(TV_Mode.Comp, 'CP')
       title('常压充气模式下的换热量')
    else       
       title('滑压充气模式下的换热量')
    end
else
    % pass
end

%%% Inlet and outlet temperature of HX
figure
subplot(3,2,1)
if strcmp(TV_Mode.Comp, 'SP')
    plot(1/60*tstep*time_period_char, CompOn.c1(time_period_char).*T_a_in.HXC1(time_period_char), 'r-'); % [K]
    hold on
    plot(1/60*tstep*time_period_char, CompOn.c1(time_period_char).*(T_HTF_in.HXC1_rated*ones(1,length(time_period_char))), 'b-');
    plot(1/60*tstep*time_period_char, CompOn.c1(time_period_char).*T_a_out.HXC1(time_period_char), 'r-.');
    plot(1/60*tstep*time_period_char, CompOn.c1(time_period_char).*T_HTF_out.HXC1(time_period_char), 'b-.');
else
    plot(1/60*tstep*time_period_char, T_a_in.HXC1(time_period_char), 'r-'); % [K]
    hold on
    plot(1/60*tstep*time_period_char, T_HTF_in.HXC1_rated*ones(1,length(time_period_char)), 'b-');
    plot(1/60*tstep*time_period_char, T_a_out.HXC1(time_period_char), 'r-.');
    plot(1/60*tstep*time_period_char, T_HTF_out.HXC1(time_period_char), 'b-.');
end
legend('入口空气', '入口HTF', '出口空气', '出口HTF')
xlabel('时间 (min)')
ylabel('温度 (K)')
if strcmp(TV_Mode.Comp, 'CP')
   title('常压充气模式下的一级换热器温度')
else       
   title('滑压充气模式下的一级换热器温度')
end

subplot(3,2,2)
if strcmp(TV_Mode.Comp, 'SP')
    plot(1/60*tstep*time_period_char, CompOn.c2(time_period_char).*T_a_in.HXC2(time_period_char), 'r-'); % [K]
    hold on
    plot(1/60*tstep*time_period_char, CompOn.c2(time_period_char).*(T_HTF_in.HXC2_rated*ones(1,length(time_period_char))), 'b-');
    plot(1/60*tstep*time_period_char, CompOn.c2(time_period_char).*T_a_out.HXC2(time_period_char), 'r-.');
    plot(1/60*tstep*time_period_char, CompOn.c2(time_period_char).*T_HTF_out.HXC2(time_period_char), 'b-.');
else
    plot(1/60*tstep*time_period_char, T_a_in.HXC2(time_period_char), 'r-'); % [K]
    hold on
    plot(1/60*tstep*time_period_char, T_HTF_in.HXC2_rated*ones(1,length(time_period_char)), 'b-');
    plot(1/60*tstep*time_period_char, T_a_out.HXC2(time_period_char), 'r-.');
    plot(1/60*tstep*time_period_char, T_HTF_out.HXC2(time_period_char), 'b-.');
end
legend('入口空气', '入口HTF', '出口空气', '出口HTF')
xlabel('时间 (min)')
ylabel('温度 (K)')
if strcmp(TV_Mode.Comp, 'CP')
   title('常压充气模式下的二级换热器温度')
else       
   title('滑压充气模式下的二级换热器温度')
end

subplot(3,2,3)
if strcmp(TV_Mode.Comp, 'SP')
    plot(1/60*tstep*time_period_char, CompOn.c3(time_period_char).*T_a_in.HXC3(time_period_char), 'r-'); % [K]
    hold on
    plot(1/60*tstep*time_period_char, CompOn.c3(time_period_char).*(T_HTF_in.HXC3_rated*ones(1,length(time_period_char))), 'b-');
    plot(1/60*tstep*time_period_char, CompOn.c3(time_period_char).*T_a_out.HXC3(time_period_char), 'r-.');
    plot(1/60*tstep*time_period_char, CompOn.c3(time_period_char).*T_HTF_out.HXC3(time_period_char), 'b-.');
else
    plot(1/60*tstep*time_period_char, T_a_in.HXC3(time_period_char), 'r-'); % [K]
    hold on
    plot(1/60*tstep*time_period_char, T_HTF_in.HXC3_rated*ones(1,length(time_period_char)), 'b-');
    plot(1/60*tstep*time_period_char, T_a_out.HXC3(time_period_char), 'r-.');
    plot(1/60*tstep*time_period_char, T_HTF_out.HXC3(time_period_char), 'b-.');
end
legend('入口空气', '入口HTF', '出口空气', '出口HTF')
xlabel('时间 (min)')
ylabel('温度 (K)')
if strcmp(TV_Mode.Comp, 'CP')
   title('常压充气模式下的三级换热器温度')
else       
   title('滑压充气模式下的三级换热器温度')
end

subplot(3,2,4)
if strcmp(TV_Mode.Comp, 'SP')
    plot(1/60*tstep*time_period_char, CompOn.c4(time_period_char).*T_a_in.HXC4(time_period_char), 'r-'); % [K]
    hold on
    plot(1/60*tstep*time_period_char, CompOn.c4(time_period_char).*(T_HTF_in.HXC4_rated*ones(1,length(time_period_char))), 'b-');
    plot(1/60*tstep*time_period_char, CompOn.c4(time_period_char).*T_a_out.HXC4(time_period_char), 'r-.');
    plot(1/60*tstep*time_period_char, CompOn.c4(time_period_char).*T_HTF_out.HXC4(time_period_char), 'b-.');
else
    plot(1/60*tstep*time_period_char, T_a_in.HXC4(time_period_char), 'r-'); % [K]
    hold on
    plot(1/60*tstep*time_period_char, T_HTF_in.HXC4_rated*ones(1,length(time_period_char)), 'b-');
    plot(1/60*tstep*time_period_char, T_a_out.HXC4(time_period_char), 'r-.');
    plot(1/60*tstep*time_period_char, T_HTF_out.HXC4(time_period_char), 'b-.');
end
legend('入口空气', '入口HTF', '出口空气', '出口HTF')
xlabel('时间 (min)')
ylabel('温度 (K)')
if strcmp(TV_Mode.Comp, 'CP')
   title('常压充气模式下的四级换热器温度')
else      
   title('滑压充气模式下的四级换热器温度')
end

subplot(3,2,5)
if strcmp(TV_Mode.Comp, 'SP')
    plot(1/60*tstep*time_period_char, CompOn.c5(time_period_char).*T_a_in.HXC5(time_period_char), 'r-'); % [K]
    hold on
    plot(1/60*tstep*time_period_char, CompOn.c5(time_period_char).*(T_HTF_in.HXC5_rated*ones(1,length(time_period_char))), 'b-');
    plot(1/60*tstep*time_period_char, CompOn.c5(time_period_char).*T_a_out.HXC5(time_period_char), 'r-.');
    plot(1/60*tstep*time_period_char, CompOn.c5(time_period_char).*T_HTF_out.HXC5(time_period_char), 'b-.');
else
    plot(1/60*tstep*time_period_char, T_a_in.HXC5(time_period_char), 'r-'); % [K]
    hold on
    plot(1/60*tstep*time_period_char, T_HTF_in.HXC5_rated*ones(1,length(time_period_char)), 'b-');
    plot(1/60*tstep*time_period_char, T_a_out.HXC5(time_period_char), 'r-.');
    plot(1/60*tstep*time_period_char, T_HTF_out.HXC5(time_period_char), 'b-.');
end
legend('入口空气', '入口HTF', '出口空气', '出口HTF')
xlabel('时间 (min)')
ylabel('温度 (K)')
if strcmp(TV_Mode.Comp, 'CP')
   title('常压充气模式下的五级换热器温度')
else      
   title('滑压充气模式下的五级换热器温度')
end
% subplot(3,2,6) % 

%%% Mass/Pressure/Temperature of ASU
figure
subplot(2,1,1)
plot(1/60*tstep*time_period_char, M_as.Char(time_period_char), 'r-'); % kg
if strcmp(DrawOption.lang, 'ch')
    xlabel('时间 (min)');
    ylabel('空气质量 (kg)')
    if strcmp(TV_Mode.Comp, 'CP')
       title('常压充气模式下的储气库空气质量')
    else       
       title('滑压充气模式下的储气库空气质量')
    end
else
    % pass
end

subplot(2,1,2)
hAx = plotyy(1/60*tstep*time_period_char,P_as.Char(time_period_char)*1e-3,1/60*tstep*time_period_char,T_as.Char(time_period_char));
xlabel('时间 (min)')
ylabel(hAx(1), '储气库压力 (MPa)')
ylabel(hAx(2), '储气库温度 (K)')
if strcmp(TV_Mode.Comp, 'CP')
    title('常压充气模式下的储气库动态特性')
else
    title('滑压充气模式下的储气库动态特性')
end

%%% Mass and Temperature of TES
figure
hAx = plotyy(1/60*tstep*time_period_char, T_TES.Char(time_period_char), 1/60*tstep*time_period_char, M_TES.Char(time_period_char));
xlabel('时间 (min)')
ylabel(hAx(1), '储热罐温度 (K)')
ylabel(hAx(2), '储热罐质量 (Kg)')
hAx(1).YLim = [270,450];
if strcmp(TV_Mode.Comp, 'CP')
    title('常压充气模式下的储热罐动态特性')
else
    title('滑压充气模式下的储热罐动态特性')
end