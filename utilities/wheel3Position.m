function [W2,W3] = wheel3Position(W2,l23)

for i = 1:length(W2)
    xc = W2(i,2);
    yc = W2(i,3);
    r = l23;
    n = 1000;
    % Generate polyshape n-points of a circle with center (xc,yc) radius r
    angle = (0:n-1)*(2*pi/n);
    Cx(i,:) = xc + r*cos(angle);
    Cy(i,:) = yc + r*sin(angle);
end

for i = 1:length(W2)
    W3(i,1) = W2(i,1);
    [x,z] = intersections(W2(:,2)',W2(:,3)',Cx(i,:),Cy(i,:),1);
    if length(x)>1
        index=find(x>W2(i,2),1,'first');
        W3(i,2) = x(index);
        W3(i,3) = z(index);
    elseif isempty(x)
        W2(i,:) = NaN;
        W3(i,:) = NaN;
    else
        W3(i,2) = x;
        W3(i,3) = z;
    end

    if W2(i,2)>W3(i,2)
        W2(i,:) = NaN;
        W3(i,:) = NaN;
    end

end
W2 = sortrows(W2,1);
W3 = sortrows(W3,1);
W2 = deleteNaN(W2);
W3 = deleteNaN(W3);

end