%% Model Parameters

speed = 0.01; % m/s
sampleTime = 15; % [s] % If 0, only critical points, otherwise 15 is very dense

% constant data
m = 1025;
g = -9.807;
r = 0.525; %[m]
l1 = 4; % 2
lB = 2; % 1
l2 = 2; % 1
l3 = 2; % 1
gamma = pi/2; % known
beta = pi/2; % known
l1B = sqrt(l1^2 + lB^2 - 2*l1*lB*cos(gamma));
l23 = sqrt(l2^2 + l3^2 - 2*l2*l3*cos(beta));
theta1 = (pi-gamma)/2; % known
thetaB = asin(l1*sin(theta1)/lB);
theta2 = (pi-beta)/2; % known
theta3 = theta2; % known

%%
%%%%%% DON'T TOUCH %%%%%%

%% Computation of alpha angles, time and slope on the whole profile

totalTime = 0; % initialize total time for completing the task
distanceTraveled = 0; % initialize total distance for completing the task

terrainProfile = terrainProfile';

z_axis = [0, 0, 1];
x_axis = [1, 0, 0];

for i = 1:length(terrainProfile)-1
    vec = [terrainProfile(i+1,1),0,terrainProfile(i+1,2)]-...
        [terrainProfile(i,1),0,terrainProfile(i,2)]; % vector from point i to point i+1
    alpha(i) = atan2(norm(cross(vec,x_axis)),dot(vec,x_axis));

    if terrainProfile(i+1,2)<terrainProfile(i,2) % wheel rolls downhill
        alpha(i) = -alpha(i);
    end

    pieceLength(i)=sqrt((terrainProfile(i+1,2)-terrainProfile(i,2))^2+...
        (terrainProfile(i+1,1)-terrainProfile(i,1))^2);

    distanceTraveled = distanceTraveled + pieceLength(i);

    timeStartPiece(i) = totalTime; 

    timeDurationPiece(i) = pieceLength(i)/speed; % [s]

    totalTime = totalTime + timeDurationPiece(i);

%     slope(i+1) = slope(i)+...
%         ((terrainProfile(i+1,2)-terrainProfile(i,2))/timeDurationPiece(i));
    
    slope(i) = terrainProfile(i,2);
end


slope(end+1) = terrainProfile(end,2);
timeStartPiece(end+1) = totalTime;

terrainProfileTime = [timeStartPiece;slope]';
terrainProfileTime = [terrainProfileTime(:,1),terrainProfile(:,1),terrainProfileTime(:,2)];

stopTime = int2str(terrainProfileTime(end,1)); % end of simulation

%% Wheels, Contact Points, Pivots, Phi and PhiB

fprintf("Computing Wheel 2 positions and contact points... (%f [s])\n",toc(tStart));
firstGuess_CP = contactPointsFromTerrain(terrainProfileTime,sampleTime);
W2 = wheel2Position(terrainProfileTime,firstGuess_CP,r);

fprintf("Computing Wheel 3 positions and contact points... (%f [s])\n",toc(tStart));
[W2,W3] = wheel3Position(W2,l23);
W3 = contactPointsFromWheel(terrainProfileTime,W3,r);

fprintf("Computing Bogie positions and phiB angle... (%f [s])\n",toc(tStart));
[W2,W3,Bogie] = computeBogie(l2,l3,W2,W3);

fprintf("Computing Wheel 1 positions and contact points... (%f [s])\n",toc(tStart));
[W1,W2,W3,Bogie] = wheel1Position(W2,W3,Bogie,l1B);
W1 = contactPointsFromWheel(terrainProfileTime,W1,r);

fprintf("Computing Rocker positions and phi angle... (%f [s])\n",toc(tStart));
[W1,W2,W3,Bogie,Rocker] = computeRocker(l1,lB,W1,W2,W3,Bogie,theta1);

