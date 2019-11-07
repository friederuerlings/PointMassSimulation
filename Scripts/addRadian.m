function  [xyrad] = addRadian(input)

%Input ist x und y Coordinaten des Tracks
%Fügt Kurvenradien als 3. Spaltenvektor hinzu

%input(:,1) = input(:,1).*(-1);
input(:,3) = 0;
distance = 0;
xyrad=input;

for n = 2:1:length(input)-1
    [rad] = calcRadian(input(n-1,:),input(n,:),input(n+1,:));
    xyrad(n,3) = rad;        
end

[xyrad(1,3)] = calcRadian(input(length(input),:),input(1,:),input(2,:));
[xyrad(length(input),3)] = calcRadian(input(length(input)-1,:),input(length(input),:),input(1,:));

