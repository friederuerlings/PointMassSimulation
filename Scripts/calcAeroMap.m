% function [aeroMap] = calcAeroMap(course)

logicMat = course(:,3) <= init.DRS_radius; %DRS offen ab Radius >=

aeroMap(:,1) = (evalin('base', 'distance') .* 0) + evalin('base', 'init.c_L');

if init.DRS_active == 1
    aeroMap(:,1) = aeroMap(:,1) .* logicMat;
    aeroMap(aeroMap(:,1) == 0,1) = evalin('base', 'init.c_L_DRS');
end

aeroMap(:,2) = (evalin('base', 'distance') * .0) + evalin('base', 'init.c_D');

if init.DRS_active == 1
    aeroMap(:,2) = aeroMap(:,2) .* logicMat;
    aeroMap(aeroMap(:,2) == 0,2) = evalin('base', 'init.c_D_DRS');
end

clear logicMat



