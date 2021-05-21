alpha = [0;0;0];
eta = [0.9571; -2.1213];
F = [1000; 0; 0];
PSI = [0; 10050; -7180];

tau = inv_dyn(alpha, eta, F, PSI);

function tau = inv_dyn(alpha, eta, F, PSI)

r = 0.25;
c1 = cos(alpha(1));
c2 = cos(alpha(2));
c3 = cos(alpha(3));
s1 = sin(alpha(1));
s2 = sin(alpha(2));
s3 = sin(alpha(3));

% input matrix
G = [-(1/r)*c1, -(1/r)*c2, -(1/r)*c3;
     (1/r)*s1, (1/r)*s2, (1/r)*s3;
     -(1/r)*eta(1), 0, 0]


F = G*[-2;-2;-2]

tau = pinv(G)*F

end