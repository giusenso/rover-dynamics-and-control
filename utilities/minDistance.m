%% Function to return the minimum distance between a line segment AB and a point E

function minDist = minDistance(x0,x1,y0,y1,xP,yP)

% vector AB
A = [x0,y0];
B = [x1,y1];
AB = B-A;

% vector BP
E = [xP,yP];
BE = E-B;

% vector AP
AE = E-A;

% Variables to store dot product

% Calculating the dot product
AB_BE = AB(1) * BE(1) + AB(2) * BE(2);
AB_AE = AB(1) * AE(1) + AB(2) * AE(2);

% Minimum distance from point E to the line segment
minDist = 0;

% Case 1
if (AB_BE > 0)

    % Finding the magnitude
    y = E(2) - B(2);
    x = E(1) - B(1);
    minDist = sqrt(x * x + y * y);

    % Case 2
elseif (AB_AE < 0)
    y = E(2) - A(2);
    x = E(1) - A(1);
    minDist = sqrt(x * x + y * y);

    % Case 3
else

    % Finding the perpendicular distance
    x1 = AB(1);
    y1 = AB(2);
    x2 = AE(1);
    y2 = AE(2);
    mod = sqrt(x1 * x1 + y1 * y1);
    minDist = abs(x1 * y2 - y1 * x2) / mod;
end

end