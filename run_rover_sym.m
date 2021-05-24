clear all
close all

line_width = 2

open_system('rover_open_loop.slx')
out = sim('rover_open_loop.slx');

%% plot dynamics
figure()
plot(out.acc); hold on;
plot(out.vel);
plot(out.pos);
grid on;
title("Rover dynamics");
legend('acc_x', 'vel_x', 'pos_x');
ylabel('Meter (m)')
set(findall(gcf,'type','line'),'linewidth', line_width);
set(gcf,'Renderer','Painters');

%% plot wheel torques
figure()
plot(out.torque);
grid on;
title("Wheel torques");
legend('tau_1', 'tau_2', 'tau_3');
ylabel('Torque (Nm)')
set(findall(gcf,'type','line'),'linewidth', line_width);
set(gcf,'Renderer','Painters');