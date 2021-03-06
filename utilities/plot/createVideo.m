function videoName = createVideo(terrainProfileTime,W1,W2,W3,r,Bogie,Rocker,u_input_vec,vel_vec,v_ref_ts_vec,vel_error_vec,speed,maxTorque,pos_ref_ts_vec,pos_vec,pos_error_vec,taskDuration,distanceTraveled)

%% Draw/Render the Scenario
%figh = figure; % figure handle
%figure(3);
figh = figureFullScreen(100);
txt = "Rocker-Bogie Live Telemetry  \rightarrow   [ Task duration [hh:mm:ss.SSS]: " + string(taskDuration) +...
    "   -   Distance traveled [m]: " + num2str(distanceTraveled) + " ]";

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

% u_input = interparc(totCameraPic,u_input_vec(:,1),u_input_vec(:,2),'linear');
% u_input = sortrows(u_input,1);
% u_input = deleteNaN(u_input);

vel = interparc(totCameraPic,vel_vec(:,1),vel_vec(:,2),'linear');
vel = sortrows(vel,1);
vel = deleteNaN(vel);

sliderTelemetry = vel(:,1); 

% v_ref = interparc(totCameraPic,v_ref_ts_vec(:,1),v_ref_ts_vec(:,2),'linear');
% v_ref = sortrows(v_ref,1);
% v_ref = deleteNaN(v_ref);

% vel_error = interparc(totCameraPic,vel_error_vec(:,1),vel_error_vec(:,2),'linear');
% vel_error = sortrows(vel_error,1);
% vel_error = deleteNaN(vel_error);

RGB_mars = '#934838';

i=1;
while i<=length(WheelPoints2)

    % Wipe the slate clean so we are plotting with a blank figure
    clf % clear figure
    
    sgtitle(txt)
    
    %% Whole terrain profile  

    subplot(5,2,[2,4]) % left subplot
    %subplot(2,1,1) % upper subplot
    hold on
    plot(terrainProfileTime(:,2),terrainProfileTime(:,3),'Color',RGB_mars);
    hold on
    drawRover(i,r,WheelPoints1,WheelPoints2,WheelPoints3,bogie,rocker);
    xline(WheelPoints2(i,2));
    hold on

    grid on
    daspect([1 1 1])


    title('Terrain profile')
    %set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

    infX = min(terrainProfileTime(:,2));
    supX = max(terrainProfileTime(:,2));

    infY = min(terrainProfileTime(:,3))-1;
    supY = max(rocker(:,3))+1;

    xlim([infX supX])
    ylim([infY supY])

    %% Rover in motion

    %subplot(1,2,2) % right subplot
    subplot(5,2,[6,8,10]) % lower subplot
    hold on
    plot(terrainProfileTime(:,2),terrainProfileTime(:,3),'Color',RGB_mars);
    hold on
    drawRover(i,r,WheelPoints1,WheelPoints2,WheelPoints3,bogie,rocker);
    grid on
    daspect([1 1 1])

    infX = min([WheelPoints1(i,2),WheelPoints2(i,2),WheelPoints3(i,2)])-5;
    supX = max([WheelPoints1(i,2),WheelPoints2(i,2),WheelPoints3(i,2)])+5;

    infY = min([WheelPoints1(i,3),WheelPoints2(i,3),WheelPoints3(i,3)])-5;
    supY = max([WheelPoints1(i,3),WheelPoints2(i,3),WheelPoints3(i,3)])+5;

    xlim([infX supX])
    ylim([infY supY])

    title('Rover in motion')
    %set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')

    %% Control effort
    
    subplot(5,2,1) % left subplot
    
    title('Control effort')
    %set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
    hold on
    plot(u_input_vec(1:end,1),u_input_vec(1:end,2),'Color','b');
    hold on
    yline([-maxTorque,maxTorque]);
    hold on
    xline(sliderTelemetry(i));
    
    grid on
    infY = -maxTorque-0.1*maxTorque;
    supY = maxTorque+0.1*maxTorque;

    xlim([u_input_vec(1:1) u_input_vec(end,1)])
    ylim([infY supY])

    legend({'control input','control bounds'},'Location', 'Best','Orientation','horizontal')
    

    %% Velocity tracking

    subplot(5,2,3) % left subplot
    
    title('Velocity tracking')
    %set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
    hold on
    plot(v_ref_ts_vec(1:end,1),v_ref_ts_vec(1:end,2),'Color','r');
    hold on
    plot(vel(1:end,1),vel(1:end,2),'Color','b');
    hold on
    xline(sliderTelemetry(i));
    hold on
    
    grid on

    infY = speed-speed*0.5;
    supY = speed+speed*0.5;
    xlim([vel(1:1) vel(end,1)])
    ylim([infY supY])

    legend({'velocity reference','actual velocity'},'Location', 'Best','Orientation','horizontal')
    

    %% Tracking error velocity

    subplot(5,2,5) % left subplot
    
    title('Velocity tracking error')
    %set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
    hold on
    plot(vel_error_vec(1:end,1),vel_error_vec(1:end,2),'Color','b');
    hold on
    xline(sliderTelemetry(i));
    hold on
    
    grid on


    infY = -speed;
    supY = speed;
    xlim([vel_error_vec(1:1) vel_error_vec(end,1)])
    ylim([infY supY])

    legend({'velocity error'},'Location', 'Best','Orientation','horizontal')
    
    %% Position tracking

    subplot(5,2,7) % left subplot
    
    title('Position tracking')
    %set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
    hold on
    plot(pos_ref_ts_vec(1:end,1),pos_ref_ts_vec(1:end,2),'Color','r');
    hold on
    plot(pos_vec(1:end,1),pos_vec(1:end,2),'Color','b');
    hold on
    xline(sliderTelemetry(i));
    hold on
    
    grid on

%     infX = min(pos_ref_ts_vec(:,1));
%     supX = max(pos_ref_ts_vec(:,1));

    infY = min(pos_ref_ts_vec(:,2))-1;
    supY = max(pos_ref_ts_vec(:,2))+1;

    xlim([vel(1:1) vel(end,1)])
    ylim([infY supY])

    legend({'position reference','actual position'},'Location', 'Best','Orientation','horizontal')
    

    %% Tracking error position

    subplot(5,2,9) % left subplot
    
    title('Position tracking error')
    %set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
    hold on
    plot(pos_error_vec(1:end,1),pos_error_vec(1:end,2),'Color','b');
    hold on
    xline(sliderTelemetry(i));
    hold on
    
    grid on


    infY = -speed;
    supY = speed;
    xlim([vel(1:1) vel(end,1)])
    ylim([infY supY])

    legend({'position error'},'Location', 'Best','Orientation','horizontal')

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