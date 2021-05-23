clear all
close all

open_system('rover_open_loop.slx')
out = sim('rover_open_loop.slx');
plot(out.acc); hold on;
plot(out.vel);
plot(out.pos);
grid on;