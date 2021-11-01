%% Contact Points

function CP = contactPoints(terrainProfileTime,alpha,r,sampleTime)

%alpha = abs(alpha);

CP(1,1) = terrainProfileTime(1,1);
CP(1,2) = terrainProfileTime(1,2);
CP(1,3) = terrainProfileTime(1,3);
CP(1,4) = NaN;
CP(1,5) = NaN;
CP(1,6) = NaN;

for i = 2:length(terrainProfileTime)-1

%     if alpha(i) < alpha(i-1)
%         [tCP_left,zCP_left,tCP_right,zCP_right] =...
%             tan2circle(terrainProfileTime(i-1,1),terrainProfileTime(i-1,3),...
%             terrainProfileTime(i,1),terrainProfileTime(i,3),...
%             terrainProfileTime(i+1,1),terrainProfileTime(i+1,3),alpha(i-1),alpha(i),r);
% 
%         CP(i,1) = tCP_right;
%         CP(i,2) = linearRegression(terrainProfileTime(i,1),terrainProfileTime(i,2),...
%             terrainProfileTime(i+1,1),terrainProfileTime(i+1,2),tCP_right);
%         CP(i,3) = zCP_right;
%         CP(i,4) = tCP_left;
%         CP(i,5) = linearRegression(terrainProfileTime(i-1,1),terrainProfileTime(i-1,2),...
%             terrainProfileTime(i,1),terrainProfileTime(i,2),tCP_left);
%         CP(i,6) = zCP_left;
% 
% 
%     else
        CP(i,1) = terrainProfileTime(i,1);
        CP(i,2) = terrainProfileTime(i,2);
        CP(i,3) = terrainProfileTime(i,3);
        CP(i,4) = NaN;
        CP(i,5) = NaN;
        CP(1,6) = NaN;
%     end
end

CP(end,1) = terrainProfileTime(end,1);
CP(end,2) = terrainProfileTime(end,2);
CP(end,3) = terrainProfileTime(end,3);
CP(end,4) = NaN;
CP(end,5) = NaN;
CP(end,6) = NaN;

k=0;
p=1;
l=length(CP);
for i=1:length(CP)
    if ~isnan(CP(i,4))
        k = k+1;
        CP(l+k,1)=CP(i,4);
        CP(l+k,2)=CP(i,5);
        CP(l+k,3)=CP(i,6);
    end
end

CP(:,4:end)=[];

CP = sortrows(CP,1);

l=length(CP)+1;

for i = 1:length(CP)-1

    mid_diff = (CP(i+1,1)-CP(i,1))/2;
    CP(l,1) = CP(i,1)+mid_diff;

    t0 = CP(i,1);
    t1 = CP(i+1,1);
    z0 = CP(i,3);
    z1 = CP(i+1,3);
    x0 = CP(i,2);
    x1 = CP(i+1,2);

    CP(l,2) = linearRegression(t0,x0,t1,x1,CP(l,1));
    CP(l,3) = linearRegression(t0,z0,t1,z1,CP(l,1));

    l = l+1;
end

if sampleTime ~= 0

    l = length(CP)+1;
    duration = sampleTime;


    while duration < max(terrainProfileTime(:,1))
        firstLowerIndex = find(terrainProfileTime(:,1)<=duration,1,'last');
        firstGreaterIndex = find(terrainProfileTime(:,1)>duration,1,'first');

        t0 = terrainProfileTime(firstLowerIndex,1);
        t1 = terrainProfileTime(firstGreaterIndex,1);
        z0 = terrainProfileTime(firstLowerIndex,3);
        z1 = terrainProfileTime(firstGreaterIndex,3);
        x0 = terrainProfileTime(firstLowerIndex,2);
        x1 = terrainProfileTime(firstGreaterIndex,2);

        tP(l,1) = duration;
        xP(l,2) = linearRegression(t0,x0,t1,x1,duration);
        zP(l,3) = linearRegression(t0,z0,t1,z1,duration);

        CP(l,1) = duration;
        CP(l,2) = linearRegression(t0,x0,t1,x1,duration);
        CP(l,3) = linearRegression(t0,z0,t1,z1,duration);

        l=l+1;
        duration = duration + sampleTime;
    end

end

CP = sortrows(CP,1);

index = 0;
for i = 2:length(CP)
    if isnan(CP(i,1)) && not(isnan(CP(i-1,1)))
        index = i;
    end
end

if index ~= 0
    CP = CP(1:index-1,:);
end

end

