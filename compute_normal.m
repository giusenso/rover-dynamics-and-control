clear all

[N,eta] = normal_forces(0,0,[0;0;0])

function [N,eta] = normal_forces(phi, phiB, alpha)

% constant data
m = 10;
g = -9.807;
r = 0.25;
l1 = 2;
lB = 1;
l2 = 1;
l3 = 1;
gamma = pi/2;
beta = pi/2;

% wheel-link angle
theta1 = pi/2 - gamma/2;
thetaB = pi/2 + gamma/2;
theta2 = pi/2 - beta/2;
theta3 = pi/2 + beta/2;

%% ground to pivot vectors
R = [cos(phi) -sin(phi); sin(phi) cos(phi)];
RB = [cos(phiB) -sin(phiB); sin(phiB) cos(phiB)];

a = R*[l1*cos(theta1)-r*sin(alpha(1)); l1*sin(theta1)+r*cos(alpha(1))]
b = R*[lB*cos(thetaB); lB*sin(thetaB)]
c = R*RB*[l2*cos(theta2)-r*sin(alpha(2)); l2*sin(theta2)+r*cos(alpha(2))]
d = R*RB*[l3*cos(theta3)-r*sin(alpha(3)); l3*sin(theta3)+r*cos(alpha(3))]

w = a-b;
eta = [-sin(alpha(1)), cos(alpha(1)); -cos(alpha(1)), -sin(alpha(1))]*w

a_ = abs(a(1));
b_ = abs(b(1));
c_ = abs(c(1));
d_ = abs(d(1));

%% Forces
Fz = m*g;
Fz1 = Fz*(b_/(a_+b_));
FzB = Fz*(a_/(a_+b_));
Fz2 = FzB*(d_/(c_+d_));
Fz3 = FzB*(c_/(c_+d_));

N = [-Fz1; -Fz2; -Fz3];
end







%