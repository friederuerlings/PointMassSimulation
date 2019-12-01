function [courseSorted,distance,TrackLength] = sortingPoints(courseRaw)

% loops = size(courseRaw);
% courseSorted(1,:) = [courseRaw(1,:), 0];
% marker = [];

% for k = 2:loops
%     distance = inf;
%     
%     for n = 2:1:size(courseRaw)
%   
%     
%         if pdist2(courseRaw(1,:),courseRaw(n,:)) < distance 
%             distance = pdist2(courseRaw(1,:),courseRaw(n,:));
%             courseSorted(k,:) = [courseRaw(n,:), distance];
%             marker = n;
%         end
%     
%     end
%     
%     courseRaw(1,:) = courseRaw(marker,:);
%     courseRaw(marker,:) = [];
% end

% courseSorted(1,3) = pdist2(courseSorted(1,1:2),courseSorted(length(courseSorted),1:2));

%Tracklength berechnen

TrackLength = (length(courseSorted)-1) * evalin('base', 'init.ptDistance');
distance = [0:evalin('base', 'init.ptDistance'):(length(course)-1)*evalin('base', 'init.ptDistance')]';