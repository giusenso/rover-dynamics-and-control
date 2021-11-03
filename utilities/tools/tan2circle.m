%% Tangent points to circle

function [xT1,yT1,xT2,yT2] = tan2circle(x0,y0,x1,y1,x2,y2,alpha0,alpha1,r)

A = [x0, 0, y0];
B = [x1, 0, y1];
C = [x2, 0, y2];

u1 = B-A;
u2 = B-C;

angle = atan2d(norm(cross(u1,u2)),dot(u1,u2));
displacement = r*cotd(angle/2);
s = r/sind(angle/2);

xT1 = x1-displacement*cos(abs(alpha0));
xT2 = x1+displacement*cos(abs(alpha1));

yT1 = linearRegression(x0,y0,x1,y1,xT1);
yT2 = linearRegression(x1,y1,x2,y2,xT2);

end