%% Model Parameters

speed = 0.01; % m/s
sampleTime = 15; % [s] % If 0, only critical points, otherwise 15 is very dense

% constant data
m = 1025;
g = -9.807;
r = 0.525; %[m]
l1 = 2;
lB = 1;
l2 = 1;
l3 = 1;
gamma = pi/2;
beta = pi/2;
l1B = sqrt(l1^2 + lB^2 - 2*l1*lB*cos(gamma));
l23 = sqrt(l2^2 + l3^2 - 2*l2*l3*cos(beta));
theta1 = (pi-gamma)/2;
thetaB = (pi+gamma)/2;
theta2 = (pi-beta)/2;
theta3 = (pi+beta)/2;
l1B_l1_angle = acos(l1/l1B);    % for gamma=pi/2 only

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

%% Contact Points

firstGuess_CP = contactPointsFromTerrain(terrainProfileTime,sampleTime);
W2 = wheel2Position(terrainProfileTime,firstGuess_CP,r);
W1 = wheel1Position(W2,l1,l2,lB,theta1,theta2,gamma);
[W2,W3] = wheel3Position(W2,l23);
W3 = contactPointsFromWheel(terrainProfileTime,W3,r);
[W2,W3,Bogie] = computePivots(l2,l3,l23,W2,W3,theta2,theta3);




%% Wheel positions

% i = 1;
% totalSampleTime = 0;
% numSamples = floor(totalTime/sampleTime);
% for k = 1:numSamples
%     cp1(k,1) = totalSampleTime;
%     cp1(k,2) = linearRegression(terrainProfileTime(i,1),terrainProfileTime(i,2),...
%         terrainProfileTime(i+1,1),terrainProfileTime(i+1,2),totalSampleTime);
%     totalSampleTime = totalSampleTime + sampleTime;
%     if totalSampleTime>terrainProfileTime(i,1)
%     i = i+1;
% end

%%


