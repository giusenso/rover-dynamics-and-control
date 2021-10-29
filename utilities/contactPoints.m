%% Contact Points

% ALERT : if the wheel has two contact points they have been added to the
% array, the right one (new ramp) is chosen, the left one (actual ramp)
% discarded but memorized as third column in the vector

function CP = contactPoints(terrainProfileTime,alpha,r)

CP(1,1) = terrainProfileTime(1,1);
CP(1,2) = terrainProfileTime(1,2);
CP(1,3) = NaN;
CP(1,4) = NaN;

for i = 2:length(terrainProfileTime)-1

    if alpha(i) > alpha(i-1)
        [xCP_left,zCP_left,xCP_right,zCP_right] =...
            tan2circle(terrainProfileTime(i-1,1),terrainProfileTime(i-1,2),...
            terrainProfileTime(i,1),terrainProfileTime(i,2),...
            terrainProfileTime(i+1,1),terrainProfileTime(i+1,2),alpha(i-1),alpha(i),r);
        CP(i,3) = xCP_left;
        CP(i,4) = zCP_left;
        CP(i,1) = xCP_right;
        CP(i,2) = zCP_right;


    else
        CP(i,1) = terrainProfileTime(i,1);
        CP(i,2) = terrainProfileTime(i,2);
        CP(i,3) = NaN;
        CP(i,4) = NaN;
    end
end

CP(end,1) = terrainProfileTime(end,1);
CP(end,2) = terrainProfileTime(end,2);
CP(end,3) = NaN;
CP(end,4) = NaN;

k=0;
l=length(CP);
for i=1:length(CP)
    if ~isnan(CP(i,3))
        k = k+1;
        CP(l+k,1)=CP(i,3);
        CP(l+k,2)=CP(i,4);
    end
end

CP(:,4)=[];
CP(:,3)=[];

CP = sortrows(CP,1);

end
