%% Einfluss von Masse auf Lap Time

LapTime = [];

for m = 120:20:260
    init.m = m;
    
    calcggV
    calcSegments
    
    LapTime = [LapTime; resultData.tout];
    
end

%% Plotten

figure()
plot([120-70:20:260-70], LapTime, 'LineWidth', 2)
grid
title('Mass - LapTime (Driver Weight 70kg)')
xlabel('Mass [kg]')
ylabel('LapTime [sec]')
    
    
