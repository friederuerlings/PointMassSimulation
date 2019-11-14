pos = sim('segmentCalcPos');
neg = sim('segmentCalcNeg');

% figure(3)
% plot((length(segments{1,3})-1)-neg.distance, neg.velocity)
% title('Braking')
% xlabel('distance')
% grid
% hold on
% plot((length(segments{1,3})-1)-neg.distance, neg.a_x)
% legend('velocity','acceleration')
% hold off

% figure(4)
% plot(pos.distance, pos.velocity)
% title('Accelerating')
% xlabel('distance')
% grid
% hold on
% plot(pos.distance, pos.a_x)
% legend('velocity','acceleration')
% hold off

figure(5)
line((length(segments{1,5})-1)-neg.distance, neg.velocity)
hold on
line(pos.distance, pos.velocity)
grid

