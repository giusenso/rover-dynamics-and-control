% https://www.uahirise.org/ESP_068360_1985 (25 February 2021)

clear; close all; clc;

%% Set the parameters depending on the picture

choice = 1;

switch choice
    case 1
        I = imread('ESP_068360_1985.jpg'); % 29.5 cm/pixel (Perseverance)
        mpp = 0.295; % meters per pixel (ESP pics)
        % gaussian filter smoothing factor (sigma = 16 for maximum smoothing)
        sigma = 16; %(ESP pic)
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
        sigma = 16; %(ESP pic)
        maxHeigth = 50; % (fake param)
        
    case 4
        I = imread('volcans-mars-hirise.jpg'); % 5.196 m/pixel
        mpp = 5.196/10; % meters per pixel (volcans pic)
        % gaussian filter smoothing factor (sigma = 16 for maximum smoothing)
        sigma = 4; %(volcans pic)
        maxHeigth = 400/10; % (volcanos pic h_real = 400 m)
end



%% Plots

figure(1)
title('Mars surface');
xLimit = (size(I,2)-1)*mpp;
yLimit = (size(I,1)-1)*mpp;
RI = imref2d(size(I));
RI.XWorldLimits = [0 xLimit];
RI.YWorldLimits = [0 yLimit];
imshow(I)
hax = gca;
hax.YTickLabel = flipud(hax.YTickLabel); % flipping the y-axis
movegui('west');

roi = drawline('Color','r'); % draw line interactively

% Read out start and end coordinates
startPose = [roi.Position(1,2) roi.Position(1,1)];
goalPose = [roi.Position(2,2) roi.Position(2,1)];

I = flip(I ,1);           % vertical flip
Iblur = imgaussfilt(I,sigma); % gaussian filter

grayScale = rgb2gray(Iblur);   % Grayscale Image

grayScale = maxHeigth*rescale(grayScale);

[dim_y_axis_grayScale, dim_x_axis_grayScale] = size(grayScale);


x = 0:size(grayScale,2)-1;
y = 0:size(grayScale,1)-1;
[X,Y] = meshgrid(mpp*x,mpp*y);  % Coordinate Matrices

figure(2)
title('Mesh Plot')
meshc(X, Y, grayScale)                              % Mesh Plot
grid on
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')
colormap(autumn)                                   % Set ‘colormap’
daspect([1 1 1])
movegui('northeast');

surfaceLength = (max(x,[],'all'))*mpp;
surfaceWidth = (max(y,[],'all'))*mpp;
surfaceHeigth = (max(grayScale,[],'all'));

% costMap = normalize(double(grayScale), 'range'); % normalize from 0 to 1

% extract pixel values along line
pixvals = improfile(grayScale,startPose,goalPose);

terrainProfile(1,:) = (1:length(pixvals))*mpp;
terrainProfile(2,:) = pixvals;

figure(3)
title('Terrain Profile')
%plot(1:length(pixvals),pixvals,'k'), axis tight, title('pixel values')
plot(terrainProfile(1,:),terrainProfile(2,:),'k');
ylabel('Z (m)');
xlabel('X (m)');
daspect([1 1 1]);
%axis tight
movegui('southeast');
