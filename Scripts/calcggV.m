ggVData_pos = [];
ggVData_neg = [];
ggVLookUp_pos = [];
ggVLookUp_neg = []; 
vRLookUp = [];
temp = [];

load_system ('ggV_simu')


    for ggV_v = 0:deltaV:maxV
        ggVsim = sim('ggV_simu');
        ggVLookUp_pos = horzcat(ggVLookUp_pos, interp1(ggVsim.a_y,ggVsim.a_x_pos,[0:1:30]'));
        ggVLookUp_neg = horzcat(ggVLookUp_neg, interp1(ggVsim.a_y,ggVsim.a_x_neg,[0:1:30]'));
        ggVData_pos = vertcat(ggVData_pos, [ggVsim.a_x_pos, ggVsim.a_y, ggVsim.velocity]);
        ggVData_neg = vertcat(ggVData_neg, [ggVsim.a_x_neg ggVsim.a_y ggVsim.velocity]);
        vRLookUp = [vRLookUp; ggVsim.maxRadiusForVelocity(1:1)];
    end

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

figure (6)
plot(0:10:110,vRLookUp')
grid
