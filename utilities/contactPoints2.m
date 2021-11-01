%% Contact Points

% ALERT : if the wheel has two contact points they have been added to the
% array, the right one (new ramp) is chosen, the left one (actual ramp)
% discarded but memorized as third column in the vector

function CP = contactPoints2(terrainProfileTime,alpha,r)

alpha = abs(alpha);

CP(1,1) = terrainProfileTime(1,1);
CP(1,2) = terrainProfileTime(1,2);
CP(1,3) = terrainProfileTime(1,3);
% CP(1,4) = NaN;
% CP(1,5) = NaN;
% CP(1,6) = NaN;

for i = 2:length(terrainProfileTime)-1

    if alpha(i) > alpha(i-1)
        [tCP_left,zCP_left,tCP_right,zCP_right] =...
            tan2circle(terrainProfileTime(i-1,1),terrainProfileTime(i-1,3),...
            terrainProfileTime(i,1),terrainProfileTime(i,3),...
            terrainProfileTime(i+1,1),terrainProfileTime(i+1,3),alpha(i-1),alpha(i),r);
        
        CP(i,1) = tCP_left;
        CP(i,2) = linearRegression(terrainProfileTime(i,1),terrainProfileTime(i,2),...
            terrainProfileTime(i+1,1),terrainProfileTime(i+1,2),tCP_right);
        CP(i,3) = zCP_left;
        CP(i+1,1) = tCP_right;
        CP(i+1,2) = linearRegression(terrainProfileTime(i-1,1),terrainProfileTime(i-1,2),...
            terrainProfileTime(i,1),terrainProfileTime(i,2),tCP_left);
        CP(i+1,3) = zCP_right;

        i=i+1;


    else
        CP(i,1) = terrainProfileTime(i,1);
        CP(i,2) = terrainProfileTime(i,2);
        CP(i,3) = terrainProfileTime(i,3);
%         CP(i,4) = NaN;
%         CP(i,5) = NaN;
%         CP(1,6) = NaN;
    end
end

CP(end,1) = terrainProfileTime(end,1);
CP(end,2) = terrainProfileTime(end,2);
CP(end,3) = terrainProfileTime(end,3);
% CP(end,4) = NaN;
% CP(end,5) = NaN;
% CP(end,6) = NaN;

% k=0;
% l=length(CP);
% for i=1:length(CP)
%     if ~isnan(CP(i,4))
%         k = k+1;
%         CP(l+k,1)=CP(i,4);
%         CP(l+k,2)=CP(i,5);
%         CP(l+k,3)=CP(i,6);
%     end
% end
% 
% CP(:,4:end)=[];

CP = sortrows(CP,1);