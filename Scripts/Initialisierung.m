clear apexData ggV interpVel resultData segmentData segments vRLookUp

%Gesamtfahrzeug
init.m            = 165 + 70;  % in kg
init.ae_A         = 1;  % in m²

%Aerodynamics
init.c_L          = 3.16;
init.c_D          = 1.5;

    %DRS
    init.DRS_active   = 0;
    init.DRS_radius   = 29;
    init.c_L_DRS      = 2.35;
    init.c_D_DRS      = 0.99;

%Suspension
init.my           = 1.3;

%Powertrain
init.P_engine     = 40; % in kW

%Physikalische Größen
init.g = 9.81;
init.rhoAir = 1.2;

%Simulation
init.deltaV       = 5;    % in m/s
init.ptDistance   = 0.5;  % in Meter
init.deltaS       = 0.01; % in Meter

%% Lap Time Simulation durchführen

calcAeroMap
calcggV
calcSegments






