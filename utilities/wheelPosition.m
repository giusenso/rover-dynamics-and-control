function WP = wheelPosition(terrainProfile,CP,alpha,rad)

alpha = abs(alpha);

angle = alpha(1);
hW = rad/cos(angle); % height of the wheel center from the ground
d = hW*sin(angle); % distance from the CP of the wheel to the zGround point

t0 = terrainProfile(1,1);
t1 = terrainProfile(2,1);
z0 = terrainProfile(1,3);
z1 = terrainProfile(2,3);
x0 = terrainProfile(1,2);
x1 = terrainProfile(2,2);

if z1 > z0 % wheel rolls uphill
    tW(1) = CP(1,1) - d*cos(angle); % projection on the x-axis
else if z1 < z0 % wheel rolls downhill
        tW(1) = CP(1,1) + d*cos(angle); % projection on the x-axis
else if z1 == z0 % wheel on flat ground
        tW(1) = CP(1,1);
end
end
end

zGround = linearRegression(t0,z0,t1,z1,tW(1));

zW(1) = zGround+hW;

xW(1) = linearRegression(t0,x0,t1,x1,tW(1));

for i =2:length(CP)
    firstLowerIndex = find(terrainProfile(:,1)<CP(i,1),1,'last')
    firstGreaterIndex = find(terrainProfile(:,1)>=CP(i,1),1,'first');
    angle = alpha(firstLowerIndex);
    hW = rad/cos(angle); % height of the wheel center from the ground
    d = hW*sin(angle); % distance from the CP of the wheel to the zGround point

    t0 = terrainProfile(firstLowerIndex,1);
    t1 = terrainProfile(firstGreaterIndex,1);
    z0 = terrainProfile(firstLowerIndex,3);
    z1 = terrainProfile(firstGreaterIndex,3);
    x0 = terrainProfile(firstLowerIndex,2);
    x1 = terrainProfile(firstGreaterIndex,2);

    if z1 > z0 % wheel rolls uphill
        tW(i) = CP(i,1) - d*cos(angle); % projection on the x-axis
    else if z1 < z0 % wheel rolls downhill
            tW(i) = CP(i,1) + d*cos(angle); % projection on the x-axis
    else if z1 == z0 % wheel on flat ground
            tW(i) = CP(i,1);
    end
    end
    end

    zGround = linearRegression(t0,z0,t1,z1,tW(i));

    zW(i) = zGround+hW;

    xW(i) = linearRegression(t0,x0,t1,x1,tW(i));

end

WP = [tW;xW;zW]';

end