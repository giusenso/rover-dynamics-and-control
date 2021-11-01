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

%%
%%%%%% DON'T TOUCH %%%%%%

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
terrainProfileTime = [terrainProfileTime(:,1),terrainProfile(:,1),terrainProfileTime(:,2)];

stopTime = int2str(terrainProfileTime(end,1)); % end of simulation

%% Contact Points

CP = contactPoints(terrainProfileTime,alpha,r,sampleTime);
[W1,CP,alpha] = wheelPosition(terrainProfileTime,CP,r);




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


