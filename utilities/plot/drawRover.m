function drawRover(i,r,WheelPoints1,WheelPoints2,WheelPoints3,bogie,rocker)

plotCircle(WheelPoints1(i,2),WheelPoints1(i,3),r,'r',1);
hold on
plotCircle(WheelPoints2(i,2),WheelPoints2(i,3),r,'r',1);
hold on
plotCircle(WheelPoints3(i,2),WheelPoints3(i,3),r,'r',1);
hold on

% draw bogie
draw_link([WheelPoints2(i,2),WheelPoints2(i,3)],[bogie(i,2),bogie(i,3)]);
hold on
draw_link([WheelPoints3(i,2),WheelPoints3(i,3)],[bogie(i,2),bogie(i,3)]);
hold on
draw_joint(bogie(i,2),bogie(i,3));
hold on
draw_axis(bogie(i,2),bogie(i,3),bogie(i,4));
hold on

% draw rocker
draw_link([rocker(i,2),rocker(i,3)],[bogie(i,2),bogie(i,3)]);
hold on
draw_link([WheelPoints1(i,2),WheelPoints1(i,3)],[rocker(i,2),rocker(i,3)]);
hold on
draw_joint(rocker(i,2),rocker(i,3));
hold on
draw_axis(rocker(i,2),rocker(i,3),rocker(i,4));
hold on

end