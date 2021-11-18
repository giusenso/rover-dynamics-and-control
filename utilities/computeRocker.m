function [W1,W2,W3,Bogie,Rocker] = computeRocker(l1,lB,W1,W2,W3,Bogie,theta1)

for i = 1:length(W1)
    z0 = W1(i,3);
    z1 = Bogie(i,3);
    x0 = W1(i,2);
    x1 = Bogie(i,2);

    A = [x0, 0, z0];
    B = [x1, 0, z1];

    u = B-A;
    x_axis = [1, 0, 0];

    alphaR(i) = atan2(norm(cross(u,x_axis)),dot(u,x_axis));

end

for i = 1:length(W1)
    if W1(i,3)>W2(i,3)
        phi(i) = -alphaR(i);
    else
        phi(i) = alphaR(i);
    end
end

for i = 1:length(W2)
    xc = W1(i,2);
    yc = W1(i,3);
    r = l1;
    n = 1500;
    % Generate polyshape n-points of a circle with center (xc,yc) radius r
    angle = (0:n-1)*(2*pi/n);
    C1x(i,:) = xc + r*cos(angle);
    C1y(i,:) = yc + r*sin(angle);
end

for i = 1:length(Bogie)
    xc = Bogie(i,2);
    yc = Bogie(i,3);
    r = lB;
    n = 1500;
    % Generate polyshape n-points of a circle with center (xc,yc) radius r
    angle = (0:n-1)*(2*pi/n);
    CBx(i,:) = xc + r*cos(angle);
    CBy(i,:) = yc + r*sin(angle);
end

for i = 1:length(W2)
    [x,z] = intersections(C1x(i,:),C1y(i,:),CBx(i,:),CBy(i,:),1);
    if length(x)>1
        index=find(z==max(z),1);
        tR(i) = W1(i,1);
        xR(i) = x(index);
        zR(i) = z(index);
    elseif isempty(x)
        W1(i,:) = NaN;
        W2(i,:) = NaN;
        W3(i,:) = NaN;
        tR(i) = NaN;
        xR(i) = NaN;
        zR(i) = NaN;
    else
        tR(i) = W1(i,1);
        xR(i) = x;
        zR(i) = z;
    end

end

Rocker = [tR',xR',zR',phi'];

for i = 1 : length(Rocker)
    if or(Rocker(i,3) < Bogie(i,3),Rocker(i,2)<W1(i,2)+l1*cos(theta1+phi))
    %if or((Rocker(i,2)-W1(i,2))^2+(Rocker(i,3)-W1(i,3))^2 ~= l1^2,(Rocker(i,2)-Bogie(i,2))^2+(Rocker(i,3)-Bogie(i,3))^2 ~= lB^2)
        W1(i,:) = NaN;
        W2(i,:) = NaN;
        W3(i,:) = NaN;
        Bogie(i,:) = NaN;
        Rocker(i,:) = NaN;
    end
end

Bogie = sortrows(Bogie,1);
Rocker = sortrows(Rocker,1);
W1 = sortrows(W1,1);
W2 = sortrows(W2,1);
W3 = sortrows(W3,1);


Bogie = deleteDuplicates(Bogie,2);
Rocker = deleteDuplicates(Rocker,2);
W1 = deleteDuplicates(W1,2);
W2 = deleteDuplicates(W2,2);
W3 = deleteDuplicates(W3,2);

W1 = deleteNaN(W1);
W2 = deleteNaN(W2);
W3 = deleteNaN(W3);
Bogie = deleteNaN(Bogie);
Rocker = deleteNaN(Rocker);

end