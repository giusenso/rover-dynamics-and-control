function terrainProfile = meshCreation(I, mpp, sigma, maxHeight)

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

I = flip(I ,1);           % vertical flip
I = imrotate(I,270);

roi = drawline('Color','r'); % draw line interactively

% Read out start and end coordinates
startPose = [roi.Position(1,2) roi.Position(1,1)]*mpp;
goalPose = [roi.Position(2,2) roi.Position(2,1)]*mpp;

Iblur = imgaussfilt(I,sigma); % gaussian filter

grayScale = rgb2gray(Iblur);   % Grayscale Image

grayScale = maxHeight*rescale(grayScale);

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
hold on
scatter(startPose(1),startPose(2),'y')
scatter(goalPose(1),goalPose(2),'b')
movegui('northeast');

surfaceLength = (max(x,[],'all'))*mpp;
surfaceWidth = (max(y,[],'all'))*mpp;
surfaceHeight = (max(grayScale,[],'all'));

% costMap = normalize(double(grayScale), 'range'); % normalize from 0 to 1

% extract pixel values along line
pixvals = improfile(grayScale,startPose,goalPose);

terrainProfile(1,:) = (1:length(pixvals));
terrainProfile(2,:) = pixvals;

figure(3)
title('Terrain Profile')
RGB_mars = '#934838';
%plot(1:length(pixvals),pixvals,'k'), axis tight, title('pixel values')
plot(terrainProfile(1,:),terrainProfile(2,:),'color',RGB_mars);
ylabel('Z (m)');
xlabel('X (m)');
daspect([1 1 1]);
%axis tight
movegui('southeast');

end