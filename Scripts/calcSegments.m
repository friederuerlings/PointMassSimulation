clear segmentData
Bremspunkt = [];

%Apex Velocity Backup 
apexData.velocity(:,2) = apexData.velocity(:,1);

%Track umdrehen für Braking Simulation
flippedLocs = (TrackLength + 2) - flip(apexData.locs(:,1));
flippedCourse = flip(course);
flippedVel = flip(apexData.velocity(:,1));

load_system ('segmentCalcNeg');

% max Apex Velocity über Braking 
for n = 1:1:length(flippedLocs)-1
    
    currentDistance = flippedLocs(n) - 1;
    apexVelocity = flippedVel(n);
    stoppingDistance = flippedLocs(n+1) - 1;
    
    set_param('segmentCalcNeg','FastRestart','on')
    segmentData{length(apexData.locs)-n,1} = sim('segmentCalcNeg');
    
    % Velocity überschreiben
    if max(segmentData{length(apexData.locs)-n,1}.velocity) < flippedVel(n+1)
        flippedVel(n+1) = max(segmentData{length(apexData.locs)-n,1}.velocity);
    end
    
    % Distance, Velocity und a_x umdrehen
    segmentData{length(apexData.locs)-n,1}.distance = flip((TrackLength) - segmentData{length(apexData.locs)-n,1}.distance);
    segmentData{length(apexData.locs)-n,1}.velocity = flip(segmentData{length(apexData.locs)-n,1}.velocity);
    segmentData{length(apexData.locs)-n,1}.a_x = flip(segmentData{length(apexData.locs)-n,1}.a_x);
    
    %Polynom anlegen
    segmentData{length(apexData.locs)-n,1}.vPoly = polyfit(segmentData{length(apexData.locs)-n,1}.distance, segmentData{length(apexData.locs)-n,1}.velocity, 9);
    segmentData{length(apexData.locs)-n,1}.vPoly = polyval(segmentData{length(apexData.locs)-n,1}.vPoly, segmentData{length(apexData.locs)-n,1}.distance);
    
    
end

% Apex Velocity anpassen für den Fall, dass Bremspunkt vor Apex liegt
apexData.velocity(:,2) = flip(flippedVel);

load_system ('segmentCalcPos');

% max Apex Velocity über Acceleration
for n = 1:1:length(apexData.locs)-1
    
    currentDistance = apexData.locs(n,1) - 1;
    apexVelocity = apexData.velocity(n,2);
    stoppingDistance = apexData.locs(n+1,1) - 1;
    
    set_param('segmentCalcPos','FastRestart','on')
    segmentData{n,2} = sim('segmentCalcPos');
    
    %Polynom anlegen
    segmentData{n,2}.vPoly = polyfit(segmentData{n,2}.distance, segmentData{n,2}.velocity, 9);
    segmentData{n,2}.vPoly = polyval(segmentData{n,2}.vPoly, segmentData{n,2}.distance);
    
    Bremspunkt = round(vertcat(Bremspunkt, polyxpoly(segmentData{n,1}.distance, segmentData{n,1}.velocity, segmentData{n,2}.distance, segmentData{n,2}.velocity)));
    
    if max(segmentData{n,2}.velocity) < apexData.velocity(n+1,2)
        apexData.velocity(n+1,2) = max(segmentData{n,2}.velocity);
    end
    
end

clear currentDistance apexVelocity stoppingDistance n 
clear flippedCourse flippedLocs flippedVel

%% Plot Segments

for n = 1:1:10
    
    figure(n)
    plot(segmentData{n,2}.distance, segmentData{n,2}.velocity)
    hold on
    grid
    %     plot(segmentData{n,2}.distance, segmentData{n,2}.a_x)
    plot(segmentData{n,1}.distance, segmentData{n,1}.velocity)
    %     plot(segmentData{n,1}.distance, segmentData{n,1}.a_x)
    
    
    polynom_accel = polyfit(segmentData{n,2}.distance, segmentData{n,2}.velocity, 9);
    polynom_accel = polyval(polynom_accel, segmentData{n,2}.distance);
    plot(segmentData{n,2}.distance, polynom_accel, 'LineWidth', 2)
    
    polynom_brake = polyfit(segmentData{n,1}.distance, segmentData{n,1}.velocity, 9);
    polynom_brake = polyval(polynom_brake, segmentData{n,1}.distance);
    plot(segmentData{n,1}.distance, polynom_brake, 'LineWidth', 2)
    
end

%% temp section

% figure()
% interpoliert = interp1(segmentData{49,1}.distance, segmentData{49,1}.velocity, segmentData{49,2}.distance);
% plot(segmentData{49,2}.distance, segmentData{49,2}.velocity - interpoliert)
% grid
% hold on
% 
% polynom_accel = polyfit(segmentData{49,2}.distance, segmentData{49,2}.velocity - interpoliert, 5);
% polynom_accel = polyval(polynom_accel, segmentData{49,2}.distance);
% plot(segmentData{49,2}.distance,polynom_accel)

% polynom_accel = polyfit(segmentData{49,2}.distance, segmentData{49,2}.velocity, 5);
% polynom_accel = polyval(polynom_accel, segmentData{49,2}.distance);
% plot(segmentData{49,2}.distance, polynom_accel)




