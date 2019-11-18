%Apex Velocity Backup 
apexData.velocity(:,2) = apexData.velocity(:,1);

% max Apex Velocity über Braking 
for n = length(apexData.locs)-1:-1:1
    
% currentDistance = apexData.locs(n);
% apexVelocity = apexData.velocity(n,2);
% stoppingDistance = apexData.locs(n+1);
% 
% load_system ('segmentCalcNeg');
% segmentData{n,1} = sim('segmentCalcNeg');
% 
% if max(segmentData{n,1}.velocity) < apexData.velocity(n+1,2)
%     apexData.velocity(n+1,2) = max(segmentData{n,1}.velocity);
end

end

% max Apex Velocity über Acceleration
for n = 1:1:length(apexData.locs)-1
    
currentDistance = apexData.locs(n);
apexVelocity = apexData.velocity(n,2);
stoppingDistance = apexData.locs(n+1);

load_system ('segmentCalcPos');
segmentData{n,2} = sim('segmentCalcPos');

if max(segmentData{n,2}.velocity) < apexData.velocity(n+1,2)
    apexData.velocity(n+1,2) = max(segmentData{n,2}.velocity);
end

end

clear currentDistance;
clear apexVelocity;
clear stoppingDistance;
