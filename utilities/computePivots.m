function [W2,W3,Bogie] = computePivots(l2,l3,l23,W2,W3,theta2,theta3)

for i = 1:length(W2)
    z0 = W2(i,3);
    z1 = W3(i,3);
    x0 = W2(i,2);
    x1 = W3(i,2);
    
    A = [x0, 0, z0];
    B = [x1, 0, z1];

    u = B-A;
    x_axis = [1, 0, 0];

    alphaB(i) = atan2(norm(cross(u,x_axis)),dot(u,x_axis));

%     num = l23*cos(W2(i,6)+alphaB(i));
%     den = l3*cos(alphaB(i)-W3(i,6)-theta3)*sin(W2(i,6)+W3(i,6))+tan(alphaB(i)-W3(i,6)-theta3);
end

for i = 1:length(W2)
    if W2(i,3)>W3(i,3)
        phiB(i) = -alphaB(i);
    else
        phiB(i) = alphaB(i);
    end
    xB(i) = W2(i,2)+l2*cos(alphaB(i)+theta2);
    zB(i) = W2(i,3)+l2*sin(alphaB(i)+theta2);
end

for i = 1:length(W2)
    xc = W2(i,2);
    yc = W2(i,3);
    r = l2;
    n = 1000;
    % Generate polyshape n-points of a circle with center (xc,yc) radius r
    angle = (0:n-1)*(2*pi/n);
    C2x(i,:) = xc + r*cos(angle);
    C2y(i,:) = yc + r*sin(angle);
end

for i = 1:length(W3)
    xc = W3(i,2);
    yc = W3(i,3);
    r = l3;
    n = 1000;
    % Generate polyshape n-points of a circle with center (xc,yc) radius r
    angle = (0:n-1)*(2*pi/n);
    C3x(i,:) = xc + r*cos(angle);
    C3y(i,:) = yc + r*sin(angle);
end

for i = 1:length(W2)
    [x,z] = intersections(C2x(i,:),C2y(i,:),C3x(i,:),C3y(i,:),1);
    if length(x)>1
        index=find(z==max(z),1,'first');
        tB(i) = W2(i,1);
        xB(i) = x(index);
        zB(i) = z(index);
    elseif isempty(x)
        W2(i,:) = NaN;
        W3(i,:) = NaN;
        tB(i) = NaN;
        xB(i) = NaN;
        zB(i) = NaN;
    else
        tB(i) = W2(i,1);
        xB(i) = x;
        zB(i) = z;
    end

    if and(zB(i) < W2(i,3),zB(i)<W3(i,3))
        W2(i,:) = NaN;
        W3(i,:) = NaN;
        tB(i) = NaN;
        xB(i) = NaN;
        zB(i) = NaN;
    end

end
    
    
    W2 = sortrows(W2,1);
    W3 = sortrows(W3,1);
    W2 = deleteNaN(W2);
    W3 = deleteNaN(W3);

Bogie = [tB',xB',zB',phiB'];

end