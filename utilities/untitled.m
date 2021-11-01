if CREATE_VIDEO == 1
    
    %% Draw/Render the Scenario
    %figh = figure; % figure handle
    %figure(3);
    figh = figureFullScreen(3);
    
    i=1;
    while i<=totCameraPic
        
        % Wipe the slate clean so we are plotting with a blank figure
        clf % clear figure
        
        subplot(1,2,1)
        
        %    quiverDim = 2; % diminuire o aumentare per regolare la lunghezza delle frecce nel grafico
        
        scatter(vehicle_pos(1,end),vehicle_pos(2,end),50,'r o', 'filled', 'MarkerEdgeColor','k')
        hold on
        %     rho=quiverDim;
        %     [a,b] = pol2cart(angle(end)+pi/2,rho);
        %     quiver(vehicle_pos(1,end),vehicle_pos(2,end),a, b,0,'r','linewidth',1)
        
        plotTrack(outer{i},inner{i},bl_cones{i},ye_cones{i},or_cones{i})
        flagCones = [];
        flagMesh = [];
        flagSeg = [];
        flagGates = [];
        flagMid = [];
        plotSpotsView(spotsAll{i},spotsView{i},mesh{i},gates{i},nSpotsView{i},nSeg{i},flagCones,flagMesh,flagSeg,flagGates,flagMid)
        plot(x{i},z{i},'b','linewidth',2);                    %plot optimal trajectory
        %plot(x_fg{i},z_fg{i},'red')                           %plot the first guess
        % scatter(cpx,cpz,'filled','r')                   %plot control points
        
        plot(leftLimit{i}(:,1),leftLimit{i}(:,2),'--b')       %plot left roadway
        plot(rightLimit{i}(:,1),rightLimit{i}(:,2),'--b')     %plot right roadway
        
        %Plot car's view limits
        plot([0,arc_x(1)],[0,arc_y(1)],'k','color',[0.7,0.7,0.7]);
        plot([0,arc_x(end)],[0,arc_y(end)],'k','color',[0.7,0.7,0.7]);
        plot(arc_x,arc_y,'k','color',[0.7,0.7,0.7])
        
        title('Track in the ''new'' coordinates (Advancing frame algorithm)')
        set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
        xlim([-20 20])
        ylim([-10 30])
        
        subplot(1,2,2)
        hold on;
        title('Car''s view')
        flagCones = 1;
        flagMesh = [];
        flagSeg = 1;
        flagGates = 1;
        flagMid = [];
        plotSpotsView(spotsAll{i},spotsView{i},mesh{i},gates{i},nSpotsView{i},nSeg{i},flagCones,flagMesh,flagSeg,flagGates,flagMid)
        plot(x{i},z{i},'b','linewidth',2);                    %plot optimal trajectory
        plot(x_fg{i},z_fg{i},'red')                           %plot the first guess
        % scatter(cpx,cpz,'filled','r')                   %plot control points
        
        plot(leftLimit{i}(:,1),leftLimit{i}(:,2),'--b')       %plot left roadway
        plot(rightLimit{i}(:,1),rightLimit{i}(:,2),'--b')     %plot right roadway
        
        %     %Plot car's view limits
        %     plot([0,arc_x(1)],[0,arc_y(1)],'k','color',[0.7,0.7,0.7]);
        %     plot([0,arc_x(end)],[0,arc_y(end)],'k','color',[0.7,0.7,0.7]);
        %     plot(arc_x,arc_y,'k','color',[0.7,0.7,0.7])
        
        xlim([-15 15])
        ylim([-5 25])
        
        
        % force Matlab to draw the image at this point (use drawnow or pause)
        % drawnow
        %pause(0.2)
        movieVector(i) = getframe(figh);
        
        i = i+1;
        
    end
    
    
    %% Save the movie
    
    videoName = sprintf('battlefield_%s.avi', datestr(now,'mm-dd-yyyy HH-MM'));
    %myWriter = VideoWriter('curve'); % generate the file curve.avi
    myWriter = VideoWriter(videoName, 'MPEG-4'); % generate the file curve.mp4
    
    % If you want only one frame to appear per second, then you just need to
    % set this rate in myWriter
    myWriter.FrameRate = 1/t_comp;
    
    % Open the VideoWriter object, write the movie, and close the file
    open(myWriter);
    writeVideo(myWriter, movieVector);
    close(myWriter);
end