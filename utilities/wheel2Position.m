function WP = wheel2Position(terrainProfile,CP,rad,DATA_AUGMENTATION)

x_axis = [1, 0, 0];

for i = 1: length(CP)-1
    firstLowerIndex = find(terrainProfile(:,1)<=CP(i,1),1,'last');
    firstGreaterIndex = find(terrainProfile(:,1)>CP(i,1),1,'first');

    t0 = terrainProfile(firstLowerIndex,1);
    t1 = terrainProfile(firstGreaterIndex,1);
    z0 = terrainProfile(firstLowerIndex,3);
    z1 = terrainProfile(firstGreaterIndex,3);
    x0 = terrainProfile(firstLowerIndex,2);
    x1 = terrainProfile(firstGreaterIndex,2);

    A = [x0, 0, z0];
    B = [x1, 0, z1];

    u = B-A;

    angle(i) = atan2(norm(cross(u,x_axis)),dot(u,x_axis));

    hW = rad/cos(angle(i)); % height of the wheel center from the ground
    d = hW*sin(angle(i)); % distance from the CP of the wheel to the zGround point

    if z1 > z0 % wheel rolls uphill
        tW(i) = CP(i,1) - d*cos(angle(i)); % projection on the x-axis
    elseif z1 < z0 % wheel rolls downhill
        tW(i) = CP(i,1) + d*cos(angle(i)); % projection on the x-axis
    elseif z1 == z0 % wheel on flat ground
        tW(i) = CP(i,1);
    end

    zGround = linearRegression(t0,z0,t1,z1,tW(i));

    zW(i) = zGround+hW;

    xW(i) = linearRegression(t0,x0,t1,x1,tW(i));

    dist1(i) = minDistance(x0,x1,z0,z1,xW(i),zW(i));
    norm1(i) = norm([CP(i,2),CP(i,3)]-[xW(i),zW(i)]);

    % Check whether a circle is tangent to the terrain
    [incidence(i),chordLength(i)] = checkIncidence(xW(i),zW(i),rad,x0,z0,x1,z1);

    contactPoint(1,i) = CP(i,1);
    contactPoint(2,i) = CP(i,2);
    contactPoint(3,i) = CP(i,3);

    % Check variable for outliers
    if or(xW(i)<=x0,xW(i)>=x1)
        check(i) = 0;  % To discard
    else
        check(i) = 1; % To keep
    end
end

WP1 = [tW;xW;zW;contactPoint;dist1;chordLength;check;angle]';

for i = 2: length(CP)
    firstLowerIndex = find(terrainProfile(:,1)<CP(i,1),1,'last');
    firstGreaterIndex = find(terrainProfile(:,1)>=CP(i,1),1,'first');

    t0 = terrainProfile(firstLowerIndex,1);
    t1 = terrainProfile(firstGreaterIndex,1);
    z0 = terrainProfile(firstLowerIndex,3);
    z1 = terrainProfile(firstGreaterIndex,3);
    x0 = terrainProfile(firstLowerIndex,2);
    x1 = terrainProfile(firstGreaterIndex,2);

    A = [x0, 0, z0];
    B = [x1, 0, z1];

    u = B-A;

    angle(i) = atan2(norm(cross(u,x_axis)),dot(u,x_axis));

    hW = rad/cos(angle(i)); % height of the wheel center from the ground
    d = hW*sin(angle(i)); % distance from the CP of the wheel to the zGround point

    if z1 > z0 % wheel rolls uphill
        tW(i) = CP(i,1) - d*cos(angle(i)); % projection on the x-axis
    elseif z1 < z0 % wheel rolls downhill
        tW(i) = CP(i,1) + d*cos(angle(i)); % projection on the x-axis
    elseif z1 == z0 % wheel on flat ground
        tW(i) = CP(i,1);
    end

    zGround = linearRegression(t0,z0,t1,z1,tW(i));

    zW(i) = zGround+hW;

    xW(i) = linearRegression(t0,x0,t1,x1,tW(i));

    % Check whether a circle is tangent to the terrain
    [incidence(i),chordLength(i)] = checkIncidence(xW(i),zW(i),rad,x0,z0,x1,z1);

    dist2(i) = minDistance(x0,x1,z0,z1,xW(i),zW(i));
    norm2(i) = norm([CP(i,2),CP(i,3)]-[xW(i),zW(i)]);

    contactPoint(1,i) = CP(i,1);
    contactPoint(2,i) = CP(i,2);
    contactPoint(3,i) = CP(i,3);

    % Check variable for outliers
    if or(xW(i)<=x0,xW(i)>=x1)
        check(i) = 0;  % To discard
    else
        check(i) = 1; % To keep
    end
end

WP2 = [tW;xW;zW;contactPoint;dist2;chordLength;check;angle]';

WP = [WP1;WP2];

% Delete outliers
for i = 1:length(WP)
    if abs(WP(i,7)-rad)>0.00000000000001*rad
        WP(i,:) = NaN;
    end
end

for i = 1:length(WP)
    index = find(WP(:,4)==WP(i,4));
    if length(index) > 1
        for k = 1: length(index)
            if WP(k,8) > min(WP(index,8))
                WP(k,:) = NaN;
            end
        end
    end
end

for i = 1:length(WP)
    if WP(i,9) == 0
        WP(i,:) = NaN;
    end
end


% k=1;
% for i = 1:length(WP)
%     index = find(round(WP(:,2))==round(WP(i,2)),2);
%     if length(index) == 2
%         indices(:,k) = index;
%         k=k+1;
%     end
% end
%
% for i = 1:length(indices)
%     j = indices(1,i);
%     k = indices(2,i);
%     if WP(j,8) <= WP(k,8)
%         WP(k,:) = NaN;
%     else
%         WP(j,:) = NaN;
%     end
% end

WP = sortrows(WP,1);

WP = deleteNaN(WP);

CP = WP(:,4:6);

alpha = WP(:,10);
% for i = 1:length(CP)-1
%     if CP(i+1,3)<CP(i,3) % wheel rolls downhill
%         alpha(i) = -alpha(i);
%     end
% end

WP = WP(:,1:3);
WP = [WP,CP(:,2:3),alpha];

WP = sortrows(WP,1);

WP = deleteDuplicates(WP,2);

WP = deleteNaN(WP);

if DATA_AUGMENTATION ~= 0
    l = length(WP)*DATA_AUGMENTATION;
    WP_augmented = interparc(l,WP(:,1),WP(:,2),WP(:,3),WP(:,4),WP(:,5),WP(:,6),'linear');
end

WP = [WP;WP_augmented];
WP = sortrows(WP,1);

end

