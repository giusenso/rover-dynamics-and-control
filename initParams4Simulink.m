%% Model Parameters

speed = 0.01; % m/s
sampleTime = 0.5; % [s]

% constant data
m = 1025;
g = -9.807;
r = 1.25;
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

%% Contact Points

% ALERT : if the wheel has two contact points they have been added to the
% array, the right one (new ramp) is chosen, the left one (actual ramp)
% discarded but memorized as third column in the vector

CP(1,1) = terrainProfileTime(1,1);
CP(1,2) = terrainProfileTime(1,2);
CP(1,3) = NaN;

for i = 2:length(terrainProfileTime)-1

    CP(i,1) = terrainProfileTime(i,1);

    if alpha(i) > alpha(i-1)
        [xCP_left,zCP_left,xCP_right,zCP_right] =...
            tan2circle(terrainProfileTime(i-1,1),terrainProfileTime(i-1,2),...
            terrainProfileTime(i,1),terrainProfileTime(i,2),...
            terrainProfileTime(i+1,1),terrainProfileTime(i+1,2),alpha(i-1),alpha(i),r);
        CP(i,1) = xCP_right;
        CP(i,2) = zCP_right;
        CP(i,3) = zCP_left;

    else
        CP(i,2) = terrainProfileTime(i,2);
        CP(i,3) = NaN;
    end
end

CP(end,1) = terrainProfileTime(end,1);
CP(end,2) = terrainProfileTime(end,2);
CP(end,3) = NaN;

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

stopTime = int2str(terrainProfileTime(end,1)); % end of simulation


