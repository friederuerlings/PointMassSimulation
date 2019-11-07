function [radian] = calcRadian(pt1,pt2,pt3)

warning off MATLAB:nearlySingularMatrix

M = [1 -1*pt1(1,1) -1*pt1(1,2); 1 -1*pt2(1,1) -1*pt2(1,2); 1 -1*pt3(1,1) -1*pt3(1,2) ];
v = [-1*((pt1(1,1)^2) + (pt1(1,2)^2)); -1*((pt2(1,1)^2) + (pt2(1,2)^2)); -1*((pt3(1,1)^2) + (pt3(1,2)^2))];

L = M\v;

x_m = L(2)/2;
y_m = L(3)/2;
radian = sqrt((x_m^2) + (y_m^2) - L(1));

if radian > simErg.maxRadius(1,1)
    radian = simErg.maxRadius(1,1);
end


