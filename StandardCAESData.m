% Adjust the rated value based on thermodynamic assumptions if necessary
% Standard AA-CAES Data Set for Thermodynamic Simulation
% No. (1) | beta (2) [-] | eta (3) [%] | In_P (4) [MPa]| Out_P (5) [MPa]| In_T (6) [C]| Out_T(7)[C] 
Compressor = [
1   3.5     74.4    0.1     0.35    25  153;
2   2.676   77.5    0.34    0.91    45  146.7;
3   2.697   80.5    0.89    2.40    45  147.6;
4   2.468   82.4    2.35    5.80    45  142.2;
5   1.963   83.0    5.72    11.23   45  109.1];

% No. (1) | beta (2) [-] | eta (3) [%] | In_P (4) [MPa]| Out_P (5) [MPa]| In_T (6) [C]| Out_T(7)[C] 
Turbine = [
1   2.212   82.6    2.50    1.13    100    12;
2   2.8     81.0    1.12    0.40    100    13;
3   3.714   81.6    0.39    0.105   100    13];

% No. (1)|In_T_Air(2)[C]|Out_T_Air(3)[C]|In_T_Water(4)[C]|Out_T_Water(5)[C]|T_Diff_Hot(6)[C]|T_Diff_Cold(7)[C]|Mass_flow(8)[kh/h] 
CoolHE = [
1   153     45  35  120   23    10  484.6;
2   146.7   45  35  120   26.7  10  456.3;
3   147.6   45  35  120   27.6  10  460.4;
4   142.2   45  35  120   22.2  10  436.2;
5   109.1   45  35  60    49.1  10  991.7];

% No. (1)|In_T_Air(2)[C]|Out_T_Air(3)[C]|In_T_Water(4)[C]|Out_T_Water(5)[C]|T_Diff_Hot(6)[C]|T_Diff_Cold(7)[C]|Mass_flow(8)[kh/h] 
HeatHE = [
1   -15  100   120   35   20    50   2827.8;
2   30   100   120   35   20    5    2163.9;
3   25   100   120   35   20    10   2139.3];
