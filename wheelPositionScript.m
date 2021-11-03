%function WP = wheelPosition(terrainProfile,contactPoint)

%clear; close all; clc;

rad = 0.525;
x0 = 103;
x1 = 104;
z0 = 48.3636;
xCP = x0;
hill = 1;
flat = 0;
z1 = hill*50.1818;
zCP = hill*z0;
beta = pi/2;
l1B = sqrt(l1^2 + lB^2 - 2*l1*lB*cos(gamma));
l23 = sqrt(l2^2 + l3^2 - 2*l2*l3*cos(beta));

if flat == 1
    z1 = z0;
    zCP = z0;
end

A = [x0, 0, z0];
B = [x1, 0, z1];

u = B-A;
z_axis = [0, 0, 1];
x_axis = [1, 0, 0];

alpha = atan2(norm(cross(u,x_axis)),dot(u,x_axis))

hW = rad/cos(alpha); % height of the wheel center from the ground
d = hW*sin(alpha); % distance from the CP of the wheel to the zGround point

if z1 > z0 % wheel rolls uphill
    xCP = xW + d*cos(alpha); % projection on the x-axis
elseif z1 < z0 % wheel rolls downhill
    xCP = xW - d*cos(alpha);  % projection on the x-axis
elseif z1 == z0 % wheel on flat ground
    xCP = xW;
end

zGround = linearRegression(x0,z0,x1,z1,xCP);

%zW = zGround+hW;

% v1 = {x2-x1, y2-y1}   # Vector 1
% v2 = {xA-x1, yA-y1}   # Vector 2
% cross_product = v1.x*v2.y - v1.y*v2.x
% if cross_product > 0:
%     print 'pointA is on the counter-clockwise side of line'
% elif cross_product < 0:
%     print 'pointA is on the clockwise side of line'
% else:
%     print 'pointA is exactly on the line'



figure(3)
plotVectorArrow([x0,z0],[x1,z1])
hold on
plotVectorArrow([0,0],[1,0])
hold on
scatter(xW,zW);
hold on
plotCircle(xW,zW,rad,'r',2);
hold on
plotVectorArrow([xCP,zCP],[xW,zW])
hold on
scatter(xCP,zCP);
daspect([1 1 1]);