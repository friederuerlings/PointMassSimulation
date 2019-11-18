%Apex Velocity Backup 
apexData.velocity(:,2) = apexData.velocity(:,1);

%Track umdrehen für Braking Simulation
flippedLocs = (TrackLength + 2) - flip(apexData.locs(:,1));
flippedCourse = flip(course);
flippedVel = flip(apexData.velocity(:,1));

% max Apex Velocity über Braking 
for n = 1:1:length(flippedLocs)-1
    
    currentDistance = flippedLocs(n);
    apexVelocity = flippedVel(n);
    stoppingDistance = flippedLocs(n+1);
    
    load_system ('segmentCalcNeg');
    set_param('segmentCalcNeg','FastRestart','on')
    segmentData{length(apexData.locs)-n,1} = sim('segmentCalcNeg');
    
    % Velocity überschreiben
    if max(segmentData{length(apexData.locs)-n,1}.velocity) < flippedVel(n+1)
        flippedVel(n+1) = max(segmentData{length(apexData.locs)-n,1}.velocity);
    end
    
    % Distance, Velocity und a_x umdrehen
    segmentData{length(apexData.locs)-n,1}.distance = flip((TrackLength + 2) - segmentData{length(apexData.locs)-n,1}.distance);
    segmentData{length(apexData.locs)-n,1}.velocity = flip(segmentData{length(apexData.locs)-n,1}.velocity);
    segmentData{length(apexData.locs)-n,1}.a_x = flip(segmentData{length(apexData.locs)-n,1}.a_x);
    
end

% Apex Velocity anpassen für den Fall, dass Bremspunkt vor Apex liegt
apexData.velocity(:,2) = flip(flippedVel);

% max Apex Velocity über Acceleration
for n = 1:1:length(apexData.locs)-1
    
    currentDistance = apexData.locs(n,1);
    apexVelocity = apexData.velocity(n,2);
    stoppingDistance = apexData.locs(n+1,1);
    
    load_system ('segmentCalcPos');
    set_param('segmentCalcPos','FastRestart','on')
    segmentData{n,2} = sim('segmentCalcPos');
    
    if max(segmentData{n,2}.velocity) < apexData.velocity(n+1,2)
        apexData.velocity(n+1,2) = max(segmentData{n,2}.velocity);
    end
    
end

clear currentDistance apexVelocity stoppingDistance n 
clear flippedCourse flippedLocs flippedVel

% Plot Segments 
for n = 7:1:10
    
    figure
    plot(segmentData{n,2}.distance, segmentData{n,2}.velocity)
    hold on
    grid
    %     plot(segmentData{n,2}.distance, segmentData{n,2}.a_x)
    plot(segmentData{n,1}.distance, segmentData{n,1}.velocity)
    %     plot(segmentData{n,1}.distance, segmentData{n,1}.a_x)
    
end
