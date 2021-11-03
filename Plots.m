figure(4)
RGB_mars = '#934838';
plot(terrainProfileTime(:,1),terrainProfileTime(:,2),'Color',RGB_mars);
grid on
hold on


figure(5)
RGB_mars = '#934838';
plot(terrainProfileTime(:,1),terrainProfileTime(:,3),'Color',RGB_mars);
grid on
hold on
plot(W1(:,1),W1(:,3),'Color','b');
hold on

figure(6)
RGB_mars = '#934838';
plot(terrainProfileTime(:,2),terrainProfileTime(:,3),'Color',RGB_mars);
hold on
%plot(W3(:,2),W3(:,3),'Color','b');
hold on
for i = 1:length(W3)
    plotCircle(W3(i,2),W3(i,3),r,'r',1);
    hold on
end
% for i = 1:length(CP)
% %scatter(CP(i,2),CP(i,3),'blue','+');
% hold on 
% end
grid on
hold on
daspect([1 1 1])
