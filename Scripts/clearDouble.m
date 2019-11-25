function [segmentDataClear] = clearDouble(segmentData)

% entfernt alle doppelten Werte aus den Vektoren
% mit doppelten x Werten kann nicht interpoliert werden

deltad = diff(segmentData.distance);
deltav = diff(segmentData.velocity);
logicDiff = deltad ~= 0 & deltav ~= 0;

if logicDiff(1) == 0 && logicDiff(end) ~= 0
    logicDiff = [logicDiff; 1];
    logicDiff(1) = [];
end

if logicDiff(end) == 0 && logicDiff(1) ~= 0
    logicDiff = [1; logicDiff];
    logicDiff(end) = [];
end

logicDiff = logical(logicDiff);

segmentDataClear.tout = segmentData.tout(logicDiff);
segmentDataClear.velocity = segmentData.velocity(logicDiff);
segmentDataClear.distance = segmentData.distance(logicDiff);
segmentDataClear.a_x = segmentData.a_x(logicDiff);