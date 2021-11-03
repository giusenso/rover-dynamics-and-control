function W1 = wheel1Position(W2,l1,l2,lB,theta1,theta2,gamma)
    
    
    tW = W2(:,1);

    

    
    xW = W2(:,2) + (l2*cos(theta2)+lB*cos(theta1+gamma)-l1*cos(theta1))...
         -(l2*sin(theta2)+lB*sin(theta1+gamma)-l1*sin(theta1));
    zW = W2(:,3) - (l2*sin(theta2)+lB*sin(theta1)-l1*sin(theta1));


%     for i = 1: length(W2)
%     
%     firstLowerIndex = find(W2(:,2)<=xW(i),1,'last')
%     if isempty(firstLowerIndex)
%         firstLowerIndex = 1;
%         firstGreaterIndex = 2;
%     else
%         firstGreaterIndex = find(W2(:,2)>xW(i),1,'first');
%     end
%     
% 
%     zW(i) = linearRegression(W2(firstLowerIndex,2),W2(firstLowerIndex,3),...
%         W2(firstGreaterIndex,2),W2(firstGreaterIndex,3),xW(i));
%     end
% 
%     zW = zW';
%     size(tW)
%     size(xW)
%     size(zW)
    W1 = [tW,xW,zW];

end