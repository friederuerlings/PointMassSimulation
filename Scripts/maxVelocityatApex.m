function [apexData] = maxVelocityatApex(course, vRLookUp)

[apexData.radius, apexData.locs] = findpeaks(course(:,3)*-1);
apexData.radius = apexData.radius * -1;

apexData.velocity = interp1(vRLookUp(:,1),vRLookUp(:,2),apexData.radius);

