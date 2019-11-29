function [segmentData] = clearDouble(segmentData)

% entfernt alle doppelten Werte aus den Vektoren
% mit doppelten x Werten kann nicht interpoliert werden

deltad = diff(segmentData.distance);
logicDiff = deltad ~= 0;

logicDiff = logical(logicDiff);

segmentData.tout = segmentData.tout(logicDiff);
segmentData.velocity = segmentData.velocity(logicDiff);
segmentData.distance = segmentData.distance(logicDiff);
segmentData.a_x = segmentData.a_x(logicDiff);
segmentData.a_y = segmentData.a_y(logicDiff);
segmentData.radius = segmentData.radius(logicDiff);