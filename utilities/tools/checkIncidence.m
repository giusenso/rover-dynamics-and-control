
function [incidence,norm2] = checkIncidence(xc,yc,r,x1,y1,x2,y2)

C = [xc; yc]; % centre of the circle
Radius = r; % is the radius of the circle
P1 = [x1; y1]; % 1st point of the segment
P2 = [x2; y2]; % 2nd point of the segment

LocalP1 = P1-C;
LocalP2 = P2-C;

P2MinusP1 = LocalP2 - LocalP1;

a = (P2MinusP1(1)) * (P2MinusP1(1)) + (P2MinusP1(2)) * (P2MinusP1(2));
b = 2 * ((P2MinusP1(1) * LocalP1(1)) + (P2MinusP1(2) * LocalP1(2)));
c = (LocalP1(1) * LocalP1(1)) + (LocalP1(2) * LocalP1(2)) - (Radius * Radius);

delta = b * b - (4 * a * c);

% incidence = 0 no intersection
% incidence = 1 tangent
% incidence = -1 intersection

if delta == 0
    incidence = 1;
    xS1 = (-b+sqrt(delta))/2*a;
    yS1 = linearRegression(x1,y1,x2,y2,xS1);
    xS2 = (-b-sqrt(delta))/2*a;
    yS2 = linearRegression(x1,y1,x2,y2,xS1);
    norm2 = 0;
elseif delta < 0
    incidence = 0;
    norm2 = 0;
elseif delta > 0
    incidence = -1;
    xS1 = (-b+sqrt(delta))/2*a;
    yS1 = linearRegression(x1,y1,x2,y2,xS1);
    xS2 = (-b-sqrt(delta))/2*a;
    yS2 = linearRegression(x1,y1,x2,y2,xS1);
    norm2 = norm([xS1,yS1]-[xS2,yS2]);
end

end