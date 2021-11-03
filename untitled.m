x = [1,2];
y = [1,2];

xC = 0;
yC = 0;
r = 1;

p = polyfit(x,y,1)
slope = p(1)
intercpt = p(2)
[xout,yout] = linecirc(slope,intercpt,xC,yC,r);