clear all
close all

line_width = 2

open_system('rover_open_loop.slx')
out = sim('rover_open_loop.slx');

%% plot dynamics
figure()
plot(out.pos); hold on;
plot(out.vel);
plot(out.acc);
plot(out.input, '--', 'linewidth', line_width);
grid on;
title("Rover dynamics");
legend('pos_x', 'vel_x', 'acc_x', 'acc_x input');
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