function WP = contactPointsFromWheel(terrainProfile,WP,rad)

for i = 1:length(WP)

    firstLowerIndex = find(terrainProfile(:,2)<=WP(i,2),1,'last');
    firstGreaterIndex = find(terrainProfile(:,2)>WP(i,2),1,'first');

    if firstLowerIndex == length(terrainProfile)
        firstLowerIndex = length(terrainProfile)-1;
        firstGreaterIndex = length(terrainProfile);
    end


    z0 = terrainProfile(firstLowerIndex,3);
    z1 = terrainProfile(firstGreaterIndex,3);
    x0 = terrainProfile(firstLowerIndex,2);
    x1 = terrainProfile(firstGreaterIndex,2);
    xW = WP(i,2);
    

    A = [x0, 0, z0];
    B = [x1, 0, z1];

    u = B-A;
    x_axis = [1, 0, 0];

    alpha(i) = atan2(norm(cross(u,x_axis)),dot(u,x_axis));

    hW = rad/cos(alpha(i)); % height of the wheel center from the ground
    d = hW*sin(alpha(i)); % distance from the CP of the wheel to the zGround point

    if z1 > z0 % wheel rolls uphill
        xCP(i) = xW + d*cos(alpha(i)); % projection on the x-axis
    elseif z1 < z0 % wheel rolls downhill
        xCP(i) = xW - d*cos(alpha(i));  % projection on the x-axis
    elseif z1 == z0 % wheel on flat ground
        xCP(i) = xW;
    end

    zCP(i) = linearRegression(x0,z0,x1,z1,xCP(i));
    
    WP(i,4) = xCP(i);
    WP(i,5) = zCP(i);
    WP(i,6) = alpha(i);
end

end