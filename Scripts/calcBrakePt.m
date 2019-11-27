% function [brakePt] = calcBrakePt(segmentData_accel, segmentData_brake)

segmentData_accel = segmentData{n,2};
segmentData_brake = segmentData{n,1};

xtrastep = 0.2;

%% Trimmt Vektoren auf Schnittbereich
logicMat = segmentData_accel.distance <= max(segmentData_accel.distance) ...
    & segmentData_accel.distance >= min(segmentData_brake.distance);

cut_accelDistance = segmentData_accel.distance(logicMat);
cut_accelVelocity = segmentData_accel.velocity(logicMat);

logicMat = segmentData_brake.distance <= max(segmentData_accel.distance) ...
    & segmentData_brake.distance >= min(segmentData_brake.distance);

cut_brakeDistance = segmentData_brake.distance(logicMat);
cut_brakeVelocity = segmentData_brake.velocity(logicMat);

%% erzeugt Polynom in dem geschnittenen Segment

segmentData_accel.vPolyFit = polyfit(cut_accelDistance, cut_accelVelocity, 4);
segmentData_brake.vPolyFit = polyfit(cut_brakeDistance, cut_brakeVelocity, 4);


segmentData_accel.vPolyVal = polyval(segmentData_accel.vPolyFit, ...
    [(segmentData_brake.distance(1)-xtrastep):0.1:(segmentData_accel.distance(end)+xtrastep)]);
segmentData_brake.vPolyVal = polyval(segmentData_brake.vPolyFit, ...
    [(segmentData_brake.distance(1)-xtrastep):0.1:(segmentData_accel.distance(end)+xtrastep)]);

%% berechnet Schnittpunkt (Bremspunkt)

brakePtFit = segmentData_accel.vPolyFit - segmentData_brake.vPolyFit;
brakePtMat = roots(brakePtFit);
logicMat = angle(brakePtMat) == 0 & brakePtMat < segmentData_accel.distance(end)+xtrastep & brakePtMat > segmentData_brake.distance(1)-xtrastep;
brakePt = round(brakePtMat(logicMat)*10)/10;

disp(brakePt)

%% temp plot

figure(n)
plot([(segmentData_brake.distance(1)-xtrastep):0.1:(segmentData_accel.distance(end)+xtrastep)], segmentData_accel.vPolyVal, 'LineWidth', 2)
grid
hold on
plot([(segmentData_brake.distance(1)-xtrastep):0.1:(segmentData_accel.distance(end)+xtrastep)], segmentData_brake.vPolyVal, 'LineWidth', 2)

plot(segmentData_accel.distance, segmentData_accel.velocity)
plot(segmentData_brake.distance, segmentData_brake.velocity)

