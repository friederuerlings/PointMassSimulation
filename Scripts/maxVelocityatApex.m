function [apexData, segments] = maxVelocityatApex(course, vRLookUp)
%Berechnung der Peaks (Apex)
[apexData.radius, apexData.locs] = findpeaks(course(:,3)*-1);
apexData.radius = apexData.radius * -1;

apexData.velocity = interp1(vRLookUp(:,1),vRLookUp(:,2),apexData.radius);
apexData.velocity(isnan(apexData.velocity)) = evalin('base', 'init.maxV');

%Segements enth�lt die Radien der Segmente
for n = 1:(size(apexData.locs)-1)
    
    segments(:,n) = {course(apexData.locs(n):apexData.locs(n+1),3)};
    
end

for n = 1:length(apexData.locs)
    apexData.xy(n,:) = course(apexData.locs(n),:);
end



