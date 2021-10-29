figure(1)
RGB_mars = '#934838';
plot(terrainProfileTime(:,1),terrainProfileTime(:,2),'Color',RGB_mars);
grid on
hold on


figure(2)
RGB_mars = '#934838';
plot(terrainProfileTime(:,1),terrainProfileTime(:,3),'Color',RGB_mars);
grid on
hold on

figure(3)
RGB_mars = '#934838';
plot(terrainProfileTime(:,2),terrainProfileTime(:,3),'Color',RGB_mars);
hold on
plot(Wheel1(:,2),Wheel1(:,3),'Color','b');
grid on
hold on
