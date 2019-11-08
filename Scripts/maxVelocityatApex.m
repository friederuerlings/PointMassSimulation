function [apexData] = maxVelocityatApex(course)

[apexData.radius, apexData.locs] = findpeaks(course(:,3)*-1);
apexData.radius = apexData.peaks * -1;

%punkte ohne simulink interpolieren (schneller)
