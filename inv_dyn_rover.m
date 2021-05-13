syms u1 u2 u3 ax az dwy k1 k2 k3
syms m Iy r Im alpha1 alpha2 alpha3 gamma1
a = [ax; az; dwy];
k = [k1; k2; k3];
G = [-1/m*((Im/r)*cos(alpha1)), -1/m*((Im/r)*cos(alpha2)), -1/m*((Im/r)*cos(alpha3));
     1/m*((Im/r)*sin(alpha1)), 1/m*((Im/r)*sin(alpha2)), 1/m*((Im/r)*sin(alpha3));
     -1/Iy*((Im/r)*gamma1), 0, 0]
 
 u = simplify(inv(G)\(a-k))