%% Einfluss von Masse auf Lap Time

LapTime = [];

for r = 28:1:32
    init.DRS_radius   = r;
    
    Initialisierung
    
    LapTime = [LapTime; resultData.tout];
    
end

%% Plotten

figure()
plot([28:1:32], LapTime, 'LineWidth', 2)
grid
title('DRS Sensitivity')
xlabel('DRS Active Radius')
ylabel('LapTime [sec]')
    
    
