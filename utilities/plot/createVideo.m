function createVideo(terrainProfileTime,W1,W2,W3,r,Bogie,Rocker)

%% Draw/Render the Scenario
%figh = figure; % figure handle
%figure(3);
figh = figureFullScreen(10);

fps = 25;
videoLength = 30; %[s]
totCameraPic = fps*videoLength;

WheelPoints1 = interparc(totCameraPic,W1(:,1),W1(:,2),W1(:,3),W1(:,4),W1(:,5),'linear');
WheelPoints1 = sortrows(WheelPoints1,1);
WheelPoints1 = deleteNaN(WheelPoints1);

WheelPoints2 = interparc(totCameraPic,W2(:,1),W2(:,2),W2(:,3),W2(:,4),W2(:,5),'linear');
WheelPoints2 = sortrows(WheelPoints2,1);
WheelPoints2 = deleteNaN(WheelPoints2);

WheelPoints3 = interparc(totCameraPic,W3(:,1),W3(:,2),W3(:,3),W3(:,4),W3(:,5),'linear');
WheelPoints3 = sortrows(WheelPoints3,1);
WheelPoints3 = deleteNaN(WheelPoints3);

bogie = interparc(totCameraPic,Bogie(:,1),Bogie(:,2),Bogie(:,3),Bogie(:,4),'linear');
bogie = sortrows(bogie,1);
bogie = deleteNaN(bogie);

rocker = interparc(totCameraPic,Rocker(:,1),Rocker(:,2),Rocker(:,3),Rocker(:,4),'linear');
rocker = sortrows(rocker,1);
rocker = deleteNaN(rocker);



RGB_mars = '#934838';

i=1;
while i<=length(WheelPoints2)

    % Wipe the slate clean so we are plotting with a blank figure
    clf % clear figure

    %subplot(1,2,1) % left subplot
    subplot(2,1,1) % upper subplot
    hold on
    plot(terrainProfileTime(:,2),terrainProfileTime(:,3),'Color',RGB_mars);
    hold on
    plotCircle(WheelPoints1(i,2),WheelPoints1(i,3),r,'r',1);
    hold on
    plotCircle(WheelPoints2(i,2),WheelPoints2(i,3),r,'r',1);
    hold on
    plotCircle(WheelPoints3(i,2),WheelPoints3(i,3),r,'r',1);
    hold on

    % draw bogie
    draw_link([WheelPoints2(i,2),WheelPoints2(i,3)],[bogie(i,2),bogie(i,3)]);
    hold on
    draw_link([WheelPoints3(i,2),WheelPoints3(i,3)],[bogie(i,2),bogie(i,3)]);
    hold on
    draw_joint(bogie(i,2),bogie(i,3));
    hold on
    draw_axis(bogie(i,2),bogie(i,3),bogie(i,4));
    hold on

    % draw rocker
    draw_link([rocker(i,2),rocker(i,3)],[bogie(i,2),bogie(i,3)]);
    hold on
    draw_link([WheelPoints1(i,2),WheelPoints1(i,3)],[rocker(i,2),rocker(i,3)]);
    hold on
    draw_joint(rocker(i,2),rocker(i,3));
    hold on
    draw_axis(rocker(i,2),rocker(i,3),rocker(i,4));
    hold on

    xline(WheelPoints2(i,2));
    hold on

    grid on
    daspect([1 1 1])


    title('Rover')
    set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

    infX = min(terrainProfileTime(:,2));
    supX = max(terrainProfileTime(:,2));

    infY = min(terrainProfileTime(:,3))-1;
    supY = max(rocker(:,3))+1;

    xlim([infX supX])
    ylim([infY supY])
    %         xlim([-20 20])
    %         ylim([-10 30])

    %subplot(1,2,2) % right subplot
    subplot(2,1,2) % lower subplot
    hold on
    plot(terrainProfileTime(:,2),terrainProfileTime(:,3),'Color',RGB_mars);
    hold on
    plotCircle(WheelPoints1(i,2),WheelPoints1(i,3),r,'r',1);
    hold on
    %     plotVectorArrow([WheelPoints1(i,4),WheelPoints1(i,5)],[WheelPoints1(i,2),WheelPoints1(i,3)]);
    %     hold on
    %     scatter(WheelPoints1(i,4),WheelPoints1(i,5),'blue','+');
    %     hold on
    plotCircle(WheelPoints2(i,2),WheelPoints2(i,3),r,'r',1);
    hold on
    %         plotVectorArrow([WheelPoints2(i,4),WheelPoints2(i,5)],[WheelPoints3(i,2),WheelPoints3(i,3)]);
    %         hold on
    %         scatter(WheelPoints2(i,4),WheelPoints2(i,5),'blue','+');
    %         hold on
    plotCircle(WheelPoints3(i,2),WheelPoints3(i,3),r,'r',1);
    hold on
    %         scatter(WheelPoints3(i,4),WheelPoints3(i,5),'blue','+');
    %         hold on
    %         plotVectorArrow([WheelPoints3(i,4),WheelPoints3(i,5)],[WheelPoints3(i,2),WheelPoints3(i,3)]);
    %         hold on

    % draw bogie
    draw_link([WheelPoints2(i,2),WheelPoints2(i,3)],[bogie(i,2),bogie(i,3)]);
    hold on
    draw_link([WheelPoints3(i,2),WheelPoints3(i,3)],[bogie(i,2),bogie(i,3)]);
    hold on
    draw_joint(bogie(i,2),bogie(i,3));
    hold on
    draw_axis(bogie(i,2),bogie(i,3),bogie(i,4));
    hold on

    % draw rocker
    draw_link([rocker(i,2),rocker(i,3)],[bogie(i,2),bogie(i,3)]);
    hold on
    draw_link([WheelPoints1(i,2),WheelPoints1(i,3)],[rocker(i,2),rocker(i,3)]);
    hold on
    draw_joint(rocker(i,2),rocker(i,3));
    hold on
    draw_axis(rocker(i,2),rocker(i,3),rocker(i,4));
    hold on

    grid on
    daspect([1 1 1])

    infX = min([WheelPoints1(i,2),WheelPoints2(i,2),WheelPoints3(i,2)])-5;
    supX = max([WheelPoints1(i,2),WheelPoints2(i,2),WheelPoints3(i,2)])+5;

    infY = min([WheelPoints1(i,3),WheelPoints2(i,3),WheelPoints3(i,3)])-5;
    supY = max([WheelPoints1(i,3),WheelPoints2(i,3),WheelPoints3(i,3)])+5;

    xlim([infX supX])
    ylim([infY supY])


    % force Matlab to draw the image at this point (use drawnow or pause)
    % drawnow
    %pause(0.2)
    movieVector(i) = getframe(figh);

    i = i+1;

end


%% Save the movie

videoName = sprintf('rover_%s', datestr(now,'dd-mm-yyyy HH-MM'));
%myWriter = VideoWriter('curve'); % generate the file curve.avi
myWriter = VideoWriter(videoName, 'MPEG-4'); % generate the file curve.mp4

% If you want only one frame to appear per second, then you just need to
% set this rate in myWriter
%myWriter.FrameRate = 1/(totalTime/length(CP));
myWriter.FrameRate = fps;

% Open the VideoWriter object, write the movie, and close the file
open(myWriter);
writeVideo(myWriter, movieVector);
close(myWriter);

end