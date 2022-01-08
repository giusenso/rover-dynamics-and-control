%% Control effort torque

figure(4)

title('Control effort')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(u_input_vec(1:end,1),u_input_vec(1:end,2),'Color','b');
hold on
yline([-maxTorque,maxTorque]);
hold on
grid on
infY = -maxTorque-0.1*maxTorque;
supY = maxTorque+0.1*maxTorque;

xlim([u_input_vec(1:1) u_input_vec(end,1)])
ylim([infY supY])

legend({'control input','control bounds'},'Location', 'Best','Orientation','horizontal')


%% Velocity tracking

figure(5)

title('Velocity tracking X')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(v_ref_ts_vec(1:end,1),v_ref_ts_vec(1:end,2),'Color','r');
hold on
plot(vel_x_vec(1:end,1),vel_x_vec(1:end,2),'Color','b');
hold on

grid on

infY = speed-speed*0.5;
supY = speed+speed*0.5;
xlim([vel_x_vec(1:1) vel_x_vec(end,1)])
ylim([infY supY])

legend({'velocity reference','actual velocity'},'Location', 'Best','Orientation','horizontal')

%%

figure(6)

title('Velocity tracking Z')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(v_ref_ts_vec(1:end,1),v_ref_ts_vec(1:end,3),'Color','r');
hold on
plot(vel_z_vec(1:end,1),vel_z_vec(1:end,2),'Color','b');
hold on

grid on

infY = -speed-speed*0.5;
supY = speed+speed*0.5;
xlim([vel_z_vec(1:1) vel_z_vec(end,1)])
ylim([infY supY])

legend({'velocity reference','actual velocity'},'Location', 'Best','Orientation','horizontal')


%% Tracking error velocity

figure(7)

title('Velocity tracking error X')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(vel_error_x_vec(1:end,1),vel_error_x_vec(1:end,2),'Color','b');
hold on
grid on


infY = -speed;
supY = speed;
xlim([vel_error_x_vec(1:1) vel_error_x_vec(end,1)])
ylim([infY supY])

legend({'velocity error'},'Location', 'Best','Orientation','horizontal')

%%

figure(8)

title('Velocity tracking error Z')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(vel_error_z_vec(1:end,1),vel_error_z_vec(1:end,2),'Color','b');
hold on
grid on


infY = -speed;
supY = speed;
xlim([vel_error_z_vec(1:1) vel_error_z_vec(end,1)])
ylim([infY supY])

legend({'velocity error'},'Location', 'Best','Orientation','horizontal')

%% Position tracking

figure(9)

title('Position tracking X')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(pos_ref_ts_vec(1:end,1),pos_ref_ts_vec(1:end,2),'Color','r');
hold on
plot(pos_x_vec(1:end,1),pos_x_vec(1:end,2),'Color','b');
hold on

grid on

%     infX = min(pos_ref_ts_vec(:,1));
%     supX = max(pos_ref_ts_vec(:,1));

infY = min(pos_ref_ts_vec(:,2))-1;
supY = max(pos_ref_ts_vec(:,2))+1;

xlim([vel_x_vec(1:1) vel_x_vec(end,1)])
ylim([infY supY])

legend({'position reference','actual position'},'Location', 'Best','Orientation','horizontal')

%%

figure(10)

title('Position tracking Z')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(pos_ref_ts_vec(1:end,1),pos_ref_ts_vec(1:end,3),'Color','r');
hold on
plot(pos_z_vec(1:end,1),pos_z_vec(1:end,2),'Color','b');
hold on

grid on

%     infX = min(pos_ref_ts_vec(:,1));
%     supX = max(pos_ref_ts_vec(:,1));

infY = min(pos_ref_ts_vec(:,3))-1;
supY = max(pos_ref_ts_vec(:,3))+1;

xlim([vel_z_vec(1:1) vel_z_vec(end,1)])
ylim([infY supY])

legend({'position reference','actual position'},'Location', 'Best','Orientation','horizontal')

%% Tracking error position

figure(11)

title('Position tracking error X')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(pos_error_x_vec(1:end,1),pos_error_x_vec(1:end,2),'Color','b');
hold on
grid on


infY = -speed;
supY = speed;
xlim([vel_x_vec(1:1) vel_x_vec(end,1)])
ylim([infY supY])

legend({'position error'},'Location', 'Best','Orientation','horizontal')

%%

figure(12)

title('Position tracking error Z')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(pos_error_z_vec(1:end,1),pos_error_z_vec(1:end,2),'Color','b');
hold on
grid on


infY = -speed;
supY = speed;
xlim([vel_z_vec(1:1) vel_z_vec(end,1)])
ylim([infY supY])

legend({'position error'},'Location', 'Best','Orientation','horizontal')

%% Tractions

figure(13)

%% Wheel 1

subplot(3,1,1);
title('Traction control Wheel 1')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(T1_vec(1:end,1),T1_vec(1:end,4),'Color','b');
hold on
% plot(N_vec(1:end,1),N_vec(:,2)*tractionCoefficient,'Color','g');
% hold on
yline([(minTorque/nWheels)/r,(maxTorque/nWheels)/r]);
hold on
grid on
infY = (minTorque/nWheels)/r-0.1*(minTorque/nWheels)/r;
supY = (maxTorque/nWheels)/r+0.1*(maxTorque/nWheels)/r;

xlim([T1_vec(1:1) T1_vec(end,1)])
ylim([infY supY])

legend({'T1 input','T1 bounds'},'Location', 'Best','Orientation','horizontal')

subplot(3,1,2);
title('Slip Ratio Wheel 1')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(slipRatio_vec(1:end,1),slipRatio_vec(1:end,2),'Color','b');
hold on
grid on
infY = -1.1;
supY = 1.1;

xlim([slipRatio_vec(1:1) slipRatio_vec(end,1)])
ylim([infY supY])

legend({'Slip Ratio W1','Slip bounds'},'Location', 'Best','Orientation','horizontal')

subplot(3,1,3);
title('Pacejka MF Wheel 1')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(T_Pacejka_vec(1:end,1),T_Pacejka_vec(1:end,2),'Color','b');
hold on
% plot(N_vec(1:end,1),N_vec(:,2)*tractionCoefficient,'Color','g');
% hold on
yline([(minTorque/nWheels)/r,(maxTorque/nWheels)/r]);
hold on
grid on
infY = (minTorque/nWheels)/r-0.1*(minTorque/nWheels)/r;
supY = (maxTorque/nWheels)/r+0.1*(maxTorque/nWheels)/r;

xlim([T_Pacejka_vec(1:1) T_Pacejka_vec(end,1)])
ylim([infY supY])

legend({'T1 Pacejka input','T1 bounds'},'Location', 'Best','Orientation','horizontal')

%% Wheel 2

figure(14)

subplot(3,1,1);
title('Traction control Wheel 2')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(T2_vec(1:end,1),T2_vec(1:end,4),'Color','b');
hold on
% plot(N_vec(1:end,1),N_vec(:,2)*tractionCoefficient,'Color','g');
% hold on
yline([(minTorque/nWheels)/r,(maxTorque/nWheels)/r]);
hold on
grid on
infY = (minTorque/nWheels)/r-0.1*(minTorque/nWheels)/r;
supY = (maxTorque/nWheels)/r+0.1*(maxTorque/nWheels)/r;

xlim([T2_vec(1:1) T2_vec(end,1)])
ylim([infY supY])

legend({'T1 input','T1 bounds'},'Location', 'Best','Orientation','horizontal')

subplot(3,1,2);
title('Slip Ratio Wheel 2')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(slipRatio_vec(1:end,1),slipRatio_vec(1:end,3),'Color','b');
hold on
grid on
infY = -1.1;
supY = 1.1;

xlim([slipRatio_vec(1:1) slipRatio_vec(end,1)])
ylim([infY supY])

legend({'Slip Ratio W2','Slip bounds'},'Location', 'Best','Orientation','horizontal')

subplot(3,1,3);
title('Pacejka MF Wheel 2')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(T_Pacejka_vec(1:end,1),T_Pacejka_vec(1:end,3),'Color','b');
hold on
% plot(N_vec(1:end,1),N_vec(:,2)*tractionCoefficient,'Color','g');
% hold on
yline([(minTorque/nWheels)/r,(maxTorque/nWheels)/r]);
hold on
grid on
infY = (minTorque/nWheels)/r-0.1*(minTorque/nWheels)/r;
supY = (maxTorque/nWheels)/r+0.1*(maxTorque/nWheels)/r;

xlim([T_Pacejka_vec(1:1) T_Pacejka_vec(end,1)])
ylim([infY supY])

legend({'T2 Pacejka input','T2 bounds'},'Location', 'Best','Orientation','horizontal')

%% Wheel 3

figure(15)

subplot(3,1,1);
title('Traction control Wheel 1')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(T3_vec(1:end,1),T3_vec(1:end,4),'Color','b');
hold on
% plot(N_vec(1:end,1),N_vec(:,2)*tractionCoefficient,'Color','g');
% hold on
yline([(minTorque/nWheels)/r,(maxTorque/nWheels)/r]);
hold on
grid on
infY = (minTorque/nWheels)/r-0.1*(minTorque/nWheels)/r;
supY = (maxTorque/nWheels)/r+0.1*(maxTorque/nWheels)/r;

xlim([T3_vec(1:1) T3_vec(end,1)])
ylim([infY supY])

legend({'T3 input','T3 bounds'},'Location', 'Best','Orientation','horizontal')

subplot(3,1,2);
title('Slip Ratio Wheel 3')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(slipRatio_vec(1:end,1),slipRatio_vec(1:end,4),'Color','b');
hold on
grid on
infY = -1.1;
supY = 1.1;

xlim([slipRatio_vec(1:1) slipRatio_vec(end,1)])
ylim([infY supY])

legend({'Slip Ratio W3','Slip bounds'},'Location', 'Best','Orientation','horizontal')

subplot(3,1,3);
title('Pacejka MF Wheel 3')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(T_Pacejka_vec(1:end,1),T_Pacejka_vec(1:end,4),'Color','b');
hold on
% plot(N_vec(1:end,1),N_vec(:,2)*tractionCoefficient,'Color','g');
% hold on
yline([(minTorque/nWheels)/r,(maxTorque/nWheels)/r]);
hold on
grid on
infY = (minTorque/nWheels)/r-0.1*(minTorque/nWheels)/r;
supY = (maxTorque/nWheels)/r+0.1*(maxTorque/nWheels)/r;

xlim([T_Pacejka_vec(1:1) T_Pacejka_vec(end,1)])
ylim([infY supY])

legend({'T3 Pacejka input','T3 bounds'},'Location', 'Best','Orientation','horizontal')

%% Slip

figure(16)

title('Slip Ratios')
%set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
hold on
plot(slipRatio_vec(1:end,1),slipRatio_vec(1:end,2:4));
hold on
grid on
legend({'slipRatio W1', 'slipRatio W2', 'slipRatio W3'},'Location', 'Best','Orientation','horizontal')

xlim([slipRatio_vec(1:1) slipRatio_vec(end,1)])