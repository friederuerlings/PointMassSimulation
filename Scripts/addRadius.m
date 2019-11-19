function  [xyrad] = addRadius(input)

%Input ist x und y Coordinaten des Tracks
%Fügt Kurvenradien als 3. Spaltenvektor hinzu

%input(:,1) = input(:,1).*(-1);
input(:,3) = 0;
xyrad = input;

for n = 2:1:length(input)-1
    rad = calcRadius(input(n-1,:),input(n,:),input(n+1,:));
    if rad > 200 || isnan(rad) == 1
        rad = 200;
    end
    xyrad(n,3) = rad;        
end

[xyrad(1,3)] = calcRadius(input(length(input),:),input(1,:),input(2,:));
[xyrad(length(input),3)] = calcRadius(input(length(input)-1,:),input(length(input),:),input(1,:));

