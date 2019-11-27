function [segmentData] = cutSegment(apex1,apex2,segmentData)

logicCut = segmentData.distance >= apex1 & segmentData.distance <= apex2;
segmentData.distance = segmentData.distance(logicCut);
segmentData.velocity = segmentData.velocity(logicCut);
segmentData.a_x = segmentData.a_x(logicCut);
segmentData.tout = segmentData.tout(logicCut);