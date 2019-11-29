warning off 'MATLAB:singularMatrix'

ggV.Data_pos = [];
ggV.Data_neg = [];
ggV.LookUp_pos = [];
ggV.LookUp_neg = []; 
vRLookUp = [];

%Maximale Geschwindigkeit berechnen
load_system ('maxVelocity')
maxVsimu = sim('maxVelocity');
init.maxV = max(maxVsimu.maxV);
clear maxVsimu

%Initialisierung um max Beschleunigung zu ermitteln
%für obere Interpolationsgrenze
ggV.simu_stopTime = 0;
ggV.simu_stepSize = 1;
ggV_v = init.maxV;

load_system ('ggV_simu')

ggVsim = sim('ggV_simu');
ggV.interpMax = ceil(ggVsim.a_x_neg) * -1;

%Initialisierung für ggV Simulation
ggV.simu_stopTime = pi/2;
ggV.simu_stepSize = (pi/2)/10;

%% Erstellt das ggV Diagramm

%Erstellt die Look Up Tables für a_x, a_y bei jeweiliger Geschwindigkeit
    for ggV_v = 0:init.deltaV:init.maxV
        ggVsim = sim('ggV_simu');
        ggV.LookUp_pos = horzcat(ggV.LookUp_pos, interp1(ggVsim.a_y,ggVsim.a_x_pos,[0:1:ggV.interpMax]'));
        ggV.LookUp_neg = horzcat(ggV.LookUp_neg, interp1(ggVsim.a_y,ggVsim.a_x_neg,[0:1:ggV.interpMax]'));
        ggV.Data_pos = vertcat(ggV.Data_pos, [ggVsim.a_x_pos, ggVsim.a_y, ggVsim.velocity]);
        ggV.Data_neg = vertcat(ggV.Data_neg, [ggVsim.a_x_neg ggVsim.a_y ggVsim.velocity]);
        vRLookUp = [vRLookUp; ggVsim.maxRadiusForVelocity(1:1)];
    end

clear ggV_v


%Erstellt LookUp für velocity und radius
%Benötigt um maximale Geschwindigkeit am Apex zu ermitteln
vRLookUp = [vRLookUp, [0:init.deltaV:init.maxV]'];

%Fügt dem Kurs den Radius zu jedem Punkt hinzu
%Alles über minimalem Radius bei vmax wird zu minimalem Radius bei vmax
course = addRadius(course);

%apexData enthält die Position und maximale Geschwindigkeit an allen Apex
[apexData, segments] = maxVelocityatApex(course, vRLookUp);

%% Plottet das ggV-Diagramm
figure()
plot3(ggV.Data_pos(:,1),ggV.Data_pos(:,2),ggV.Data_pos(:,3)*3.6,'*')
hold on
plot3(ggV.Data_neg(:,1),ggV.Data_neg(:,2),ggV.Data_neg(:,3)*3.6,'*')
hold off
grid
title('ggV-Diagram')
xlabel('a_x [m/s²]')
ylabel('a_y [m/s²]')
zlabel('velocity [km/h]')

