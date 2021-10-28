%function (xW,zW) = wheelPosition(terrainProfile,contactPoint)

clear; close all; clc;

rad = 0.25;
x0 = 0;
x1 = 2;
z0 = 0;
xCP = 2;
hill = -1;
flat = 0;
z1 = hill*4;
zCP = hill*4;
x2 = 3;
z2 = 3;

if flat == 1
    z1 = z0;
    zCP = z0;
end

A = [x0, 0, z0];
B = [x1, 0, z1];
C = [x2, 0, z2];

u = A-B;
u1 = C-B;
z_axis = [0, 0, 1];
x_axis = [1, 0, 0];

alpha = atan2(norm(cross(u,x_axis)),dot(u,x_axis));
alpha1 = atan2(norm(cross(u1,x_axis)),dot(u1,x_axis));

hW = rad/cos(alpha); % height of the wheel center from the ground
d = hW*sin(alpha); % distance from the CP of the wheel to the zGround point

if z1 > z0 % wheel rolls uphill
    xW = xCP - d*cos(alpha); % projection on the x-axis
else if z1 < z0 % wheel rolls downhill
        xW = xCP + d*cos(alpha); % projection on the x-axis
else if z1 == z0 % wheel on flat ground
        xW = xCP;
end
end
end

zGround = linearRegression(x0,z0,x1,z1,xW);

zW = zGround+hW;

plotVectorArrow([x0,z0],[x1,z1])
hold on
plotVectorArrow([x1,z1],[x2,z2])
hold on
plotVectorArrow([0,0],[1,0])
hold on
scatter(xW,zW);
hold on
plotCircle(xW,zW,rad,'r',2);
daspect([1 1 1]);
plotVectorArrow([xCP,zCP],[xW,zW])