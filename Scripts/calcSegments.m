clear segmentData
warning off MATLAB:polyfit:RepeatedPointsOrRescale
brakePt = [];
brakePts = [];
resultData.velocity = []; resultData.distance = []; resultData.tout = [];


%Apex Velocity Backup 
apexData.velocity(:,2) = apexData.velocity(:,1);

%Track umdrehen für Braking Simulation
flippedLocs = (TrackLength + 2) - flip(apexData.locs(:,1));
flippedCourse = flip(course);
flippedVel = flip(apexData.velocity(:,1));


%% max Apex Velocity über Braking 

load_system ('segmentCalcNeg');
set_param('segmentCalcNeg','FastRestart','off')
% set_param('segmentCalcNeg','StartTime','0','StopTime','inf','FixedStep','1e-2');
set_param('segmentCalcNeg','StartTime','0','StopTime','inf','MinStep','auto','MaxStep','1e-3');
set_param('segmentCalcNeg','FastRestart','on');

for n = 1:1:length(flippedLocs)-1
    
    currentDistance = flippedLocs(n) - 1;
    apexVelocity = flippedVel(n);
    stoppingDistance = flippedLocs(n+1) - 1;
       
    segmentData{length(apexData.locs)-n,1} = sim('segmentCalcNeg');
    segmentData{length(apexData.locs)-n,1} = clearDouble(segmentData{length(apexData.locs)-n,1});
    segmentData{length(apexData.locs)-n,1} = cutSegment(currentDistance,stoppingDistance,segmentData{length(apexData.locs)-n,1});
    
    % Velocity überschreiben
    if max(segmentData{length(apexData.locs)-n,1}.velocity) < flippedVel(n+1)
        flippedVel(n+1) = max(segmentData{length(apexData.locs)-n,1}.velocity);
    end
    
    % Distance, Velocity und a_x umdrehen
    segmentData{length(apexData.locs)-n,1}.distance = flip((TrackLength) - segmentData{length(apexData.locs)-n,1}.distance);
    segmentData{length(apexData.locs)-n,1}.velocity = flip(segmentData{length(apexData.locs)-n,1}.velocity);
    segmentData{length(apexData.locs)-n,1}.a_x = flip(segmentData{length(apexData.locs)-n,1}.a_x);
    segmentData{length(apexData.locs)-n,1}.tout = flip(segmentData{length(apexData.locs)-n,1}.tout);
    
    %Polynom anlegen
%     segmentData{length(apexData.locs)-n,1}.vPolyFit = polyfit(segmentData{length(apexData.locs)-n,1}.distance, segmentData{length(apexData.locs)-n,1}.velocity, 7);
%     segmentData{length(apexData.locs)-n,1}.vPolyVal = polyval(segmentData{length(apexData.locs)-n,1}.vPolyFit, segmentData{length(apexData.locs)-n,1}.distance);
    
    
end

% Apex Velocity anpassen für den Fall, dass Bremspunkt vor Apex liegt
apexData.velocity(:,2) = flip(flippedVel);

%% max Apex Velocity über Acceleration

load_system ('segmentCalcPos');
set_param('segmentCalcPos','FastRestart','off');
% set_param('segmentCalcPos','StartTime','0','StopTime','inf','FixedStep','1e-2');
set_param('segmentCalcPos','StartTime','0','StopTime','inf','MinStep','auto','MaxStep','1e-3');
set_param('segmentCalcPos','FastRestart','on');

for n = 1:1:length(apexData.locs)-1
    
    currentDistance = apexData.locs(n,1) - 1;
    apexVelocity = apexData.velocity(n,2);
    stoppingDistance = apexData.locs(n+1,1) - 1;
    
    segmentData{n,2} = sim('segmentCalcPos');
%     segmentData{n,2} = clearDouble(segmentData{n,2});
%     segmentData{n,2} = cutSegment(currentDistance, stoppingDistance, segmentData{n,2});  
    
    % Polynom anlegen
    segmentData{n,2}.vPolyFit = polyfit(segmentData{n,2}.distance, segmentData{n,2}.velocity, 7);
    segmentData{n,2}.vPolyVal = polyval(segmentData{n,2}.vPolyFit, segmentData{n,2}.distance);
    
    segmentData{n,1}.vPolyFit = polyfit(segmentData{n,1}.distance, segmentData{n,1}.velocity, 7);
    segmentData{n,1}.vPolyVal = polyval(segmentData{n,1}.vPolyFit, segmentData{n,1}.distance);
    
    % Bremspunkte berechnen
    brakePtFit = segmentData{n,2}.vPolyFit - segmentData{n,1}.vPolyFit;
    brakePtMat = roots(brakePtFit);
    logicMat = angle(brakePtMat) == 0 & brakePtMat < stoppingDistance & brakePtMat > currentDistance;
    brakePt = round(brakePtMat(logicMat)*10)/10;
    brakePts = [brakePts; brakePt];
    
    segmentData{n,2} = clearDouble(segmentData{n,2});
    segmentData{n,2} = cutSegment(currentDistance, stoppingDistance, segmentData{n,2});

    
    
    % max velocity überschreiben, falls velocity an nächstem Apex nicht
    % erreicht werden kann
    if max(segmentData{n,2}.velocity) < apexData.velocity(n+1,2)
        apexData.velocity(n+1,2) = max(segmentData{n,2}.velocity);
    end
    
    
    % erzeugt velocity vektor über distance
    
    resultData = evaluateSegment(resultData, segmentData{n,2}, segmentData{n,1}, brakePt);
    
end

clear brakePtMat brakePt brakePtFit brakePts
clear currentDistance apexVelocity stoppingDistance n 
clear flippedCourse flippedLocs flippedVel

%% Plot Segments

for n = 39:1:39
    
    figure(n)
    plot(segmentData{n,2}.distance, segmentData{n,2}.velocity)
    hold on
    grid
    %         plot(segmentData{n,2}.distance, segmentData{n,2}.a_x)
    plot(segmentData{n,1}.distance, segmentData{n,1}.velocity)
    %         plot(segmentData{n,1}.distance, segmentData{n,1}.a_x)
    
%     plot(segmentData{n,2}.distance, segmentData{n,2}.vPolyVal, 'LineWidth', 2)
%     plot(segmentData{n,1}.distance, segmentData{n,1}.vPolyVal, 'LineWidth', 2)
    
    hold off
end

clear breakPtFit logicMat

%% Plot Lap
figure
plot(resultData.distance, resultData.velocity)
grid

%% temp section







