function terrainProfile = meshCreation(I, mpp, sigma, maxHeight)

%% Plots

figure(1)
title('Mars surface');
% xLimit = (size(I,2)-1)*mpp;
% yLimit = (size(I,1)-1)*mpp;
xLimit = (size(I,2)-1);
yLimit = (size(I,1)-1);
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
startPose = [roi.Position(1,2) roi.Position(1,1)];
goalPose = [roi.Position(2,2) roi.Position(2,1)];

Iblur = imgaussfilt(I,sigma); % gaussian filter

grayScale = rgb2gray(Iblur);   % Grayscale Image

grayScale = maxHeight*rescale(grayScale);

[dim_y_axis_grayScale, dim_x_axis_grayScale] = size(grayScale);


x = 0:size(grayScale,2)-1;
y = 0:size(grayScale,1)-1;
[X,Y] = meshgrid(x,y);  % Coordinate Matrices

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
pixvals = improfile(grayScale,[startPose(1),goalPose(1)],[startPose(2),goalPose(2)]);

terrainProfile(1,:) = (1:length(pixvals))*mpp;
terrainProfile(2,:) = pixvals;

terrainProfile = terrainProfile(:,1:end);
terrainProfile = terrainProfile';
terrainProfile = sortrows(terrainProfile,1);
terrainProfile = deleteNaN(terrainProfile);
terrainProfile = terrainProfile';

shiftFactor = terrainProfile(1,1);
for i = 1: length(terrainProfile)
    terrainProfile(1,i)=terrainProfile(1,i)-shiftFactor;
end
    
figure(3)
title('Terrain Profile')
RGB_mars = '#934838';
%plot(1:length(pixvals),pixvals,'k'), axis tight, title('pixel values')
plot(terrainProfile(1,:),terrainProfile(2,:),'color',RGB_mars,'Linewidth',2);
ylabel('Z (m)');
xlabel('X (m)');
grid on;
daspect([1 1 1]);
%axis tight
movegui('southeast');

end