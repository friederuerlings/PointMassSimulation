function [filteredapexData] = filterCourse(apexData)

% entfernt alle Apex deren Geschwindigkeit größer als init.vmax ist

logicMat = apexData.radius(:,1) < ceil(max(evalin('base','vRLookUp(:,1)')));
logicMat = horzcat(logicMat,logicMat,logicMat);

filteredapexData.radius = apexData.radius(logicMat(:,1));
filteredapexData.velocity = apexData.velocity(logicMat(:,1));
filteredapexData.locs = apexData.locs(logicMat(:,1));
filteredapexData.xy(:,1) = apexData.xy(logicMat);
filteredapexData.xy = horzcat(filteredapexData.xy(1:70,1), filteredapexData.xy(71:140,1), filteredapexData.xy(141:210,1));