%% Model Parameters

if LOAD_WORKSPACE == 0

    speed = 0.01; % m/s
    sampleTime = 15; % [s] % If 0, only critical points, otherwise 15 is very dense

    % constant data
    L = 3; %[m]
    W =	2.7; %[m]
    H = 2.2; %[m]
    nWheels = 3; % planar case, longitudinal dynamics = 3 wheels
    mTot = 1025;
    m = mTot/2; % mTot/2 if planar case
    Iyy = 1/12*m*(H^2+L^2); % Mass moment of inertia
    tractionCoeff = 0.5; % https://asmedigitalcollection.asme.org/memagazineselect/article-pdf/120/04/74/6381472/me-1998-apr6.pdf
    g = 3.721;
    r = 0.5/2; %[m]
    l1 = 2; % 2
    lB = 1; % 1
    l2 = 1; % 1
    l3 = 1; % 1
    gamma = pi/2; % known
    beta = pi/2; % known
    l1B = sqrt(l1^2 + lB^2 - 2*l1*lB*cos(gamma));
    l23 = sqrt(l2^2 + l3^2 - 2*l2*l3*cos(beta));
    theta1 = (pi-gamma)/2; % known
    thetaB = pi/2 + gamma/2;
    theta2 = (pi-beta)/2; % known
    theta3 = theta2; % known
    phi_shift = 0.25*pi - acos(l1/l1B);
    maxTorque = 677*nWheels; %[N m] torque max per wheel
    minTorque = -maxTorque;

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

    %% Wheels, Contact Points, Pivots, Phi and PhiB

    fprintf("Computing Wheel 2 positions and contact points... (%f [s])\n",toc(tStart));
    firstGuess_CP = contactPointsFromTerrain(terrainProfileTime,sampleTime);
    W2 = wheel2Position(terrainProfileTime,firstGuess_CP,r,DATA_AUGMENTATION);

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

    stopTime = int2str(Rocker(end,1)); % end of simulation

end

%% Build time series

W1_ts = timeseries(W1(:,4:5), W1(:,1), 'name','W1');
W2_ts = timeseries(W2(:,4:5), W2(:,1), 'name','W2');
W3_ts = timeseries(W3(:,4:5), W3(:,1), 'name','W3');

bogie_ts = timeseries(Bogie(:,2:4), Bogie(:,1), 'name','bogie');
alpha_ts = timeseries([W1(:,6), W2(:,6), W3(:,6)], W1(:,1), 'name','alpha');
rocker_ts = timeseries(Rocker(:,2:4), Rocker(:,1), 'name','rocker');

[v_ref_x, acc_ref_x] = firstsecondderivatives(Rocker(:,1),Rocker(:,2));
[v_ref_z, acc_ref_z] = firstsecondderivatives(Rocker(:,1),Rocker(:,3));
[omega_dot_ref, omega_ddot_ref] = firstsecondderivatives(Rocker(:,1),Rocker(:,4)-phi_shift);


% rocker_dx = rocker_ts.Data(2:end,1)-rocker_ts.Data(1:end-1,1);
% rocker_dz = rocker_ts.Data(2:end,2)-rocker_ts.Data(1:end-1,2);
% rocker_dphi = rocker_ts.Data(2:end,3)-rocker_ts.Data(1:end-1,3);
% rocker_dt = rocker_ts.Time(2:end)-rocker_ts.Time(1:end-1);
%
% coeff = 1.33;
% dphi_thresh = 0.01;
% v_ref_thresh = 0.05;
%
% v_ref_data = zeros(length(rocker_dx),1);
% for i = 1:length(rocker_dx)
%     if (rocker_dphi(i)>dphi_thresh)
%         rocker_dphi(i) = dphi_thresh;
%     end
%     v_ref_data(i,1) = norm(([rocker_dx(i), rocker_dz(i)]) - coeff*abs(rocker_dphi(i)))/rocker_dt(i);
%     if (v_ref_data(i,1) > v_ref_thresh)
%         v_ref_data(i,1) = v_ref_thresh;
%     end
% end

v_ref_x = v_ref_x';
v_ref_z = v_ref_z';

v_ref_x_filt = movingAverageFilter(v_ref_x,10);
v_ref_z_filt = movingAverageFilter(v_ref_z,10);
v_ref_data = [v_ref_x_filt, v_ref_z_filt];
v_ref_time = Rocker(:,1);

v_ref_ts = timeseries(v_ref_data, v_ref_time);

omega_dot_ref = omega_dot_ref';
omega_dot_ref_time = Rocker(:,1);

omega_dot_ref_ts = timeseries(omega_dot_ref, omega_dot_ref_time);

[v_W1_x, acc_W1_x] = firstsecondderivatives(W1(:,1),W1(:,2));
[v_W1_z, acc_W1_z] = firstsecondderivatives(W1(:,1),W1(:,3));
v_W1_data = [v_W1_x; v_W1_z];
v_W1_time = W1(:,1);
v_W1_ts = timeseries(v_W1_data', v_W1_time);

[v_W2_x, acc_W2_x] = firstsecondderivatives(W2(:,1),W2(:,2));
[v_W2_z, acc_W2_z] = firstsecondderivatives(W2(:,1),W2(:,3));
v_W2_data = [v_W2_x; v_W2_z];
v_W2_time = W2(:,1);
v_W2_ts = timeseries(v_W2_data', v_W2_time);

[v_W3_x, acc_W3_x] = firstsecondderivatives(W3(:,1),W3(:,2));
[v_W3_z, acc_W3_z] = firstsecondderivatives(W3(:,1),W3(:,3));
v_W3_data = [v_W3_x; v_W3_z];
v_W3_time = W3(:,1);
v_W3_ts = timeseries(v_W3_data', v_W3_time);

% for i=1:length(v_W1_x)
%     v_W1(i) = norm(v_W1_x(i),v_W1_z(i));
% end
% 
% for i=1:length(v_W2_x)
%     v_W2(i) = norm(v_W2_x(i),v_W2_z(i));
% end
% 
% for i=1:length(v_W3_x)
%     v_W3(i) = norm(v_W3_x(i),v_W3_z(i));
% end
% 
% S = slipRatio(v_W1,v_ref);

%v_ref_ts = timeseries(v_ref_data, rocker_ts.Time(1:end-1));
%
% v_ref_eu_ts = timeseries(v_ref_x(:),v_ref_z(:), Rocker(:,1), 'name','vel_eu');

%%

% clear W1_ts W2_ts W3_ts bogie_ts alpha_ts rocker_ts v_ref_x acc_ref_x v_ref_z ...
%     acc_ref_z omega_dot_ref omega_ddot_ref v_ref_x_filt v_ref_z_filt ...
%     v_ref_data v_ref_time v_ref_ts omega_dot_ref_time omega_dot_ref_ts ...
%     rocker_dx rocker_dz rocker_dphi rocker_dt coeff dphi_thresh v_ref_thresh...
%     ans out simulation