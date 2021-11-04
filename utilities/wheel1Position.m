function [W1,W2,W3,Bogie] = wheel1Position(W2,W3,Bogie,l1B)

for i = 1:length(Bogie)
    xc = Bogie(i,2);
    yc = Bogie(i,3);
    r = l1B;
    n = 1000;
    % Generate polyshape n-points of a circle with center (xc,yc) radius r
    angle = (0:n-1)*(2*pi/n);
    CBx(i,:) = xc + r*cos(angle);
    CBy(i,:) = yc + r*sin(angle);
end

for i = 1:length(Bogie)
    W1(i,1) = W2(i,1);
    [x,z] = intersections(W2(:,2)',W2(:,3)',CBx(i,:),CBy(i,:),1);
    if length(x)>1
        index=find(x<W2(i,2),1,'last');
        W1(i,2) = x(index);
        W1(i,3) = z(index);
    elseif isempty(x)
        W1(i,:) = NaN;
        W2(i,:) = NaN;
        W3(i,:) = NaN;
        Bogie(i,:) = NaN;
    else
        W3(i,2) = x;
        W3(i,3) = z;
    end
end

for i = 1 : length(W1)
    if or(W1(i,2)>W2(i,2),W1(i,2)==0)
        W1(i,:) = NaN;
        W2(i,:) = NaN;
        W3(i,:) = NaN;
        Bogie(i,:) = NaN;
    end
end

W1 = sortrows(W1,1);
W2 = sortrows(W2,1);
W3 = sortrows(W3,1);
Bogie = sortrows(Bogie,1);
W1 = deleteNaN(W1);
W2 = deleteNaN(W2);
W3 = deleteNaN(W3);
Bogie = deleteNaN(Bogie);

end