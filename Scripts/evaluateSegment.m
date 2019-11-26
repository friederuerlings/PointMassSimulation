function [resultData] = evaluateSegment(resultData, segmentData_accel, segmentData_brake, brakePt)
%% Segment in dem nur gebremst wird
% Übernimmt das Segment vom Bremsvorgang

if segmentData_brake.velocity(1) <= segmentData_accel.velocity(1)
    resultData.velocity = vertcat(resultData.velocity, segmentData_brake.velocity);
    resultData.distance = vertcat(resultData.distance, segmentData_brake.distance);
    resultData.tout = resultData.tout + max(segmentData_brake.tout);
    return
end

%% Segment in dem nur beschleunigt wird
% Übernimmt das Segment vom Beschleunigungsvorgang

if max(segmentData_accel.velocity) < min(segmentData_brake.velocity)
    resultData.velocity = vertcat(resultData.velocity, segmentData_accel.velocity);
    resultData.distance = vertcat(resultData.distance, segmentData_accel.distance);
    resultData.tout = resultData.tout + max(segmentData_accel.tout);
    return
end

%% Segment mit Bremspunkt
% Erzeugt einen Vektor mit interpolierten Werten von apex1 zu Bremspunkt
% und von Bremspunkt zu apex2

if isempty(brakePt) == 0
    
    AccelInterpVel = (interp1(segmentData_accel.distance, segmentData_accel.velocity, [segmentData_accel.distance(1):0.1:brakePt]))';
    BrakeInterpVel = (interp1(segmentData_brake.distance, segmentData_brake.velocity, [brakePt:0.1:segmentData_brake.distance(end)]))';
    
    resultData.velocity = vertcat(resultData.velocity, AccelInterpVel, BrakeInterpVel);
    resultData.distance = vertcat(resultData.distance, [segmentData_accel.distance(1):0.1:brakePt]', [brakePt:0.1:segmentData_brake.distance(end)]');
    return
end

error('no case')

%% temp section





    