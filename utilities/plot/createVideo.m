function createVideo(terrainProfileTime,W1,W2,W3,r,Bogie)

    %% Draw/Render the Scenario
    %figh = figure; % figure handle
    %figure(3);
    figh = figureFullScreen(10);
    
    fps = 25;
    videoLength = 30; %[s]
    totCameraPic = fps*videoLength;
    
    WheelPoints1 = interparc(totCameraPic,W1(:,1),W1(:,2),W1(:,3),'linear');
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
   

    RGB_mars = '#934838';

    i=1;
    while i<=length(WheelPoints2)
        
        % Wipe the slate clean so we are plotting with a blank figure
        clf % clear figure
        
        subplot(1,2,1)
        hold on
        plot(terrainProfileTime(:,2),terrainProfileTime(:,3),'Color',RGB_mars);
        hold on
        %plotCircle(WheelPoints1(i,2),WheelPoints1(i,3),r,'r',1);
        hold on
        plotCircle(WheelPoints2(i,2),WheelPoints2(i,3),r,'r',1);
        hold on
        plotCircle(WheelPoints3(i,2),WheelPoints3(i,3),r,'b',1);
        hold on
        grid on
        daspect([1 1 1])

        
        title('Rover')
        set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
%         xlim([-20 20])
%         ylim([-10 30])
        
        subplot(1,2,2)
        hold on
        plot(terrainProfileTime(:,2),terrainProfileTime(:,3),'Color',RGB_mars);
        hold on
        %plotCircle(WheelPoints1(i,2),WheelPoints1(i,3),r,'r',1);
        hold on
        plotCircle(WheelPoints2(i,2),WheelPoints2(i,3),r,'r',1);
        hold on
%         plotVectorArrow([WheelPoints2(i,4),WheelPoints2(i,5)],[WheelPoints3(i,2),WheelPoints3(i,3)]);
%         hold on
%         scatter(WheelPoints2(i,4),WheelPoints2(i,5),'blue','+');
%         hold on
        plotCircle(WheelPoints3(i,2),WheelPoints3(i,3),r,'b',1);
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
        grid on
        daspect([1 1 1])
        
        infX = min([WheelPoints1(i,2),WheelPoints2(i,2),WheelPoints3(i,2)])-10;
        supX = max([WheelPoints1(i,2),WheelPoints2(i,2),WheelPoints3(i,2)])+10;
        
        infY = min([WheelPoints1(i,3),WheelPoints2(i,3),WheelPoints3(i,3)])-10;
        supY = max([WheelPoints1(i,3),WheelPoints2(i,3),WheelPoints3(i,3)])+10;

        xlim([infX supX])
        ylim([infY supY])
        
        
        % force Matlab to draw the image at this point (use drawnow or pause)
        % drawnow
        %pause(0.2)
        movieVector(i) = getframe(figh);
        
        i = i+1;
        
    end
    
    
    %% Save the movie
  
    videoName = sprintf('rover_%s', datestr(now,'mm-dd-yyyy HH-MM'));
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