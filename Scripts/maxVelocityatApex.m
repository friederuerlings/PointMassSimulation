function [apexData, segments] = maxVelocityatApex(course, vRLookUp)
% Berechnung der Peaks (Apex)
[apexData.radius, apexData.locs] = findpeaks(course(:,3)*-1);
apexData.radius = apexData.radius * -1;

% Fügt ersten und letzten Punkt als Apex hinzu
apexData.locs = vertcat(1, apexData.locs, length(course));
apexData.radius = vertcat(course(1,3), apexData.radius, course(end,3));

apexData.velocity = interp1(vRLookUp(:,1),vRLookUp(:,2),apexData.radius);
apexData.velocity(isnan(apexData.velocity)) = evalin('base', 'init.maxV');

% Startgeschwindigkeit
% apexData.velocity(1) = 0;

for n = 1:length(apexData.locs)
    apexData.xy(n,:) = course(apexData.locs(n),:);
end

% filtert apexData, entfernt alle apex mit v > vmax
[apexData] = filterCourse(apexData);

% Segements enthält die Radien der Segmente
for n = 1:(size(apexData.locs)-1)
    
    segments(:,n) = {course(apexData.locs(n):apexData.locs(n+1),3)};
    
end





