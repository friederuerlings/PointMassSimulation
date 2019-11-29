function [segmentData] = interpolSegments(segmentData, currentDistance, stoppingDistance)
% Interpoliert velocity,tout und a_x auf distance mit Schrittweite
% init.deltaS

interpD = [currentDistance:evalin('base', 'init.deltaS'):stoppingDistance]';

segmentData.velocity = interp1(segmentData.distance, segmentData.velocity, interpD, 'linear', 'extrap');
segmentData.tout = interp1(segmentData.distance, segmentData.tout, interpD, 'linear', 'extrap');
segmentData.a_x = interp1(segmentData.distance, segmentData.a_x, interpD, 'linear', 'extrap');
segmentData.a_y = interp1(segmentData.distance, segmentData.a_y, interpD, 'linear', 'extrap');
segmentData.radius = interp1(segmentData.distance, segmentData.radius, interpD, 'linear', 'extrap');
segmentData.distance = interpD;