function [resultData] = evaluateSegment(resultData, segmentData_accel, segmentData_brake)

%% Berechnet Bremspunkt

brakePt = intersection(segmentData_accel.distance, segmentData_accel.velocity, ...
    segmentData_brake.distance, segmentData_brake.velocity);

% Rundet Brake Point auf die initialisierte Schrittweite
brakePt = round(brakePt*(1/evalin('base', 'init.deltaS')))/(1/evalin('base', 'init.deltaS'));


%% Segment in dem nur gebremst wird
% Übernimmt das Segment vom Bremsvorgang

if segmentData_brake.velocity(1) <= segmentData_accel.velocity(1) ...
        | brakePt == segmentData_accel.distance(1)
    resultData.velocity = vertcat(resultData.velocity, segmentData_brake.velocity);
    resultData.distance = vertcat(resultData.distance, segmentData_brake.distance);
    resultData.tout = resultData.tout + max(segmentData_brake.tout);
    
    resultData.velocity(end) = [];
    resultData.distance(end) = [];
    
    return
end

%% Segment in dem nur beschleunigt wird
% Übernimmt das Segment vom Beschleunigungsvorgang

if max(segmentData_accel.velocity) <= min(segmentData_brake.velocity) ...
        | brakePt == segmentData_accel.distance(end)
    resultData.velocity = vertcat(resultData.velocity, segmentData_accel.velocity);
    resultData.distance = vertcat(resultData.distance, segmentData_accel.distance);
    resultData.tout = resultData.tout + max(segmentData_accel.tout);
    
    resultData.velocity(end) = [];
    resultData.distance(end) = [];
 
    return
end

%% Segment mit Bremspunkt
% Erzeugt einen Vektor mit interpolierten Werten von apex1 zu Bremspunkt
% und von Bremspunkt zu apex2

% Interpoliert Accel-Vektoren von Apex1 zu Brake Point und Brake-Vektoren von Brake Point zu
% Apex2
logicAccel = segmentData_accel.distance < brakePt;
logicBrake = segmentData_brake.distance >= brakePt;

resultData.velocity = vertcat(resultData.velocity, segmentData_accel.velocity(logicAccel), ...
    segmentData_brake.velocity(logicBrake));
resultData.tout = resultData.tout + max(segmentData_accel.tout(logicAccel)) ...
    + max(segmentData_brake.tout(logicBrake));
resultData.distance = vertcat(resultData.distance, segmentData_accel.distance);

resultData.velocity(end) = [];
resultData.distance(end) = [];

%% temp section





    