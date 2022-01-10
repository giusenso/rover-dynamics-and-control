% https://www.uahirise.org/ESP_068360_1985 (25 February 2021)

%% Simulink File

load_system('roverDynamics');
save_system('roverDynamics');
clc; clear all; close all; warning off;
%bdclose('all');
rehash;
% sl_refresh_customizations;
% exit

%% SIMULATION SETUP

% picture chosen or choice = 0 for a pre-built profile
choice = 0; % picture 4 recommended

LOAD_WORKSPACE = 1; % To speed up the simulation load a prebuilt workspace
filenameWorkspace = 'standardTerrainProfile_workspace';
CREATE_VIDEO = 0; % Set 1 to plot rover animation and save it

PLOTS = 1; % Set 1 to plot results from simulink

DATA_AUGMENTATION = 10; % 10; % Set different from 0 if the simulation shows implausibility due to the lack of samplepoints
                       % If different from 0 the simulation time will increase exponentially


%%%%%% DON'T TOUCH %%%%%%

load_system('roverDynamics');

% Add that folder plus all subfolders to the path.
addpath(genpath('utilities'));
addpath(genpath('mars surface'));

if choice == 0 
    load terrainProfile.mat;

else

    %% Set the parameters depending on the picture

    switch choice
        case 1
            I = imread('ESP_068360_1985.jpg'); % 29.5 cm/pixel (Perseverance)
            mpp = 0.295; % meters per pixel (ESP pics)
            % gaussian filter smoothing factor (sigma = 16 for maximum smoothing)
            sigma = 8; %(ESP pic)
            maxHeigth = 20; % (fake param)

        case 2
            I = imread('ESP_059329_2095_RGB.jpg'); % 29.5 cm/pixel
            mpp = 0.295; % meters per pixel (ESP pics)
            % gaussian filter smoothing factor (sigma = 16 for maximum smoothing)
            sigma = 16; %(ESP pic)
            maxHeigth = 20; % (fake param)


        case 3
            I = imread('mars_surface.jpg'); % 504.38 m/pixel
            mpp = 0.50438; % meters per pixel (mars surface pic, fake param)
            % gaussian filter smoothing factor (sigma = 16 for maximum smoothing)
            sigma = 8; %(ESP pic)
            maxHeigth = 50; % (fake param)

        case 4
            I = imread('volcans-mars-hirise.jpg'); % 5.196 m/pixel
            mpp = 5.196/5; % meters per pixel (volcans pic)
            % gaussian filter smoothing factor (sigma = 16 for maximum smoothing)
            sigma = 8; %(volcans pic)
            maxHeigth = 400/5; % (volcanos pic h_real = 400 m)
    end

    terrainProfile = meshCreation(I,mpp,sigma,maxHeigth);

end


%% Terrain Profile

if LOAD_WORKSPACE == 0
    tStart = tic;
    fprintf("Processing terrain profile... (%f [s])\n",toc(tStart));
    save('standardTerrainProfile.mat', '-regexp', '^(?!(LOAD_WORKSPACE|choice|CREATE_VIDEO|DATA_AUGMENTATION)$).')
else
    load(filenameWorkspace);
end

initParams4Simulink;
fprintf("Running Simulink model... (%f [s])\n",toc(tStart));
set_param('roverDynamics','StartTime','0','StopTime',stopTime);
simulation = sim('roverDynamics'); % running model from script
variablesFromSimulink;

if PLOTS == 1
    Plots
end

taskDuration = seconds(totalTime);
taskDuration.Format = 'hh:mm:ss.SSS';
fprintf("Task duration [hh:mm:ss.SSS]: %s\n",string(taskDuration));
fprintf("Distance traveled [m]: %f\n",distanceTraveled);


%% Create video

if CREATE_VIDEO == 1
    tFinish = toc(tStart);
    fprintf("Rendering video... (%f [s])\n",tFinish);
    createVideo(terrainProfileTime,W1,W2,W3,r,Bogie,Rocker,...
        u_input_vec,vel_x_vec,v_ref_ts_vec(:,1:2),vel_error_x_vec,speed,maxTorque,...
        pos_ref_ts_vec(:,1:2),pos_x_vec,pos_error_x_vec,taskDuration,distanceTraveled);
end
