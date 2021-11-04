% https://www.uahirise.org/ESP_068360_1985 (25 February 2021)

clc; clear all; close all; warning off;
bdclose('all');

% picture chosen or choice = 0 for a pre-built profile
choice = 0; % picture 4 recommended

%% SIMULATION SETUP

LOAD_WORKSPACE = 0; % To speed up the simulation load a prebuilt workspace
CREATE_VIDEO = 1; % Set 1 to plot rover animation and save it

%%%%%% DON'T TOUCH %%%%%%

load_system('testSimulink');

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
    initParams4Simulink;
    save('standardTerrainProfile.mat', '-regexp', '^(?!(LOAD_WORKSPACE|choice|CREATE_VIDEO)$).')
else
    load terrainProfile_workspace.mat;
end

fprintf("Running Simulink model... (%f [s])\n",toc(tStart));
%set_param('testSimulink','StartTime','0','StopTime',stopTime);
%sim('testSimulink'); % running model from script
%Plots

taskDuration = seconds(totalTime);
taskDuration.Format = 'hh:mm:ss.SSS';
fprintf("Task duration [hh:mm:ss.SSS]: %s\n",string(taskDuration));
fprintf("Distance traveled [m]: %f\n",distanceTraveled);
tFinish = toc(tStart);
fprintf("Rendering video... (%f [s])\n",tFinish);

if CREATE_VIDEO == 1
    createVideo(terrainProfileTime,W1,W2,W3,r,Bogie,Rocker);
end
