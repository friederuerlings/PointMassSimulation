pos = sim('segmentCalcPos');
neg = sim('segmentCalcNeg');

figure(3)
plot(neg.distance, neg.velocity)
title('Braking')
xlabel('distance')
grid
hold on
plot(neg.distance, neg.a_x)
legend('velocity','acceleration')
hold off

figure(4)
plot(pos.distance, pos.velocity)
title('Accelerating')
xlabel('distance')
grid
hold on
plot(pos.distance, pos.a_x)
legend('velocity','acceleration')
