function [resultData] = evaluateSegment(resultData, segmentData_accel, segmentData_brake, brakePt)

errorcount = 0;
%% Segment in dem nur gebremst wird

if segmentData_brake.velocity(1) <= segmentData_accel.velocity(1)
    resultData.velocity = vertcat(resultData.velocity, segmentData_brake.velocity);
    resultData.distance = vertcat(resultData.distance, segmentData_brake.distance);
    return
    errorcount = errorcount + 1;
    if1 = 1;
end

%% Segment in dem nur beschleunigt wird

if max(segmentData_accel.velocity) < min(segmentData_brake.velocity)
    resultData.velocity = vertcat(resultData.velocity, segmentData_accel.velocity);
    resultData.distance = vertcat(resultData.distance, segmentData_accel.distance);
    return
    errorcount = errorcount + 1;
    if2 = 1;
end

%% Segment mit Bremspunkt

% resultData.velocity = []; resultData.distance = [];
% segmentData_accel = segmentData{27,2};
% segmentData_brake = segmentData{27,1};
% brakePt = 429.4;

if isempty(brakePt) == 0
    
    AccelInterpVel = (interp1(segmentData_accel.distance, segmentData_accel.velocity, [segmentData_accel.distance(1):0.1:brakePt]))';
    BrakeInterpVel = (interp1(segmentData_brake.distance, segmentData_brake.velocity, [brakePt:0.1:segmentData_brake.distance(end)]))';
    
    resultData.velocity = vertcat(resultData.velocity, AccelInterpVel, BrakeInterpVel);
    resultData.distance = vertcat(resultData.distance, [segmentData_accel.distance(1):0.1:brakePt]', [brakePt:0.1:segmentData_brake.distance(end)]');
    return
    errorcount = errorcount + 1;
    if3 = 1;
end

if errorcount > 1
    error('fail')
end
%% temp section





    