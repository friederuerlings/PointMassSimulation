ggVData_pos = [];
ggVData_neg = [];
ggVLookUp_pos = [];
ggVLookUp_neg = []; 
vRLookUp = [];
temp = [];

%Initialisierung um max Beschleunigung zu ermitteln
%für obere Interpolationsgrenze
ggV_simu_stopTime = 0;
ggV_simu_stepSize = 1;
ggV_v = maxV;

load_system ('ggV_simu')

ggVsim = sim('ggV_simu');
interpMax = ceil(ggVsim.a_x_neg) * -1;

%Initialisierung für ggV Simulation
ggV_simu_stopTime = pi/2;
ggV_simu_stepSize = (pi/2)/10;

%Erstellt das ggV Diagramm
%Erstellt die Look Up Tables für a_x, a_y bei jeweiliger Geschwindigkeit
    for ggV_v = 0:deltaV:maxV
        ggVsim = sim('ggV_simu');
        ggVLookUp_pos = horzcat(ggVLookUp_pos, interp1(ggVsim.a_y,ggVsim.a_x_pos,[0:1:interpMax]'));
        ggVLookUp_neg = horzcat(ggVLookUp_neg, interp1(ggVsim.a_y,ggVsim.a_x_neg,[0:1:interpMax]'));
        ggVData_pos = vertcat(ggVData_pos, [ggVsim.a_x_pos, ggVsim.a_y, ggVsim.velocity]);
        ggVData_neg = vertcat(ggVData_neg, [ggVsim.a_x_neg ggVsim.a_y ggVsim.velocity]);
        vRLookUp = [vRLookUp; ggVsim.maxRadiusForVelocity(1:1)];
    end
    
%Erstellt LookUp für velocity und radius
%Benötigt um maximale Geschwindigkeit am Apex zu ermitteln
vRLookUp = [vRLookUp, [0:deltaV:maxV]'];

%Fügt dem Kurs den Radius zu jedem Punkt hinzu
%Alles über minimalem Radius bei vmax wird zu minimalem Radius bei vmax
course = addRadius(course,max(vRLookUp(:,1)));


%Plottet das ggV-Diagramm
figure(5)
plot3(ggVData_pos(:,1),ggVData_pos(:,2),ggVData_pos(:,3),'*')
hold on
plot3(ggVData_neg(:,1),ggVData_neg(:,2),ggVData_neg(:,3),'*')
hold off
grid
title('ggV-Diagram')
xlabel('a_x [m/s²]')
ylabel('a_y [m/s²]')
zlabel('velocity [m/s]')

