opts = delimitedTextImportOptions("NumVariables", 2);
opts.DataLines = [3, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["VarName1", "Bohrtabelle"];
opts.VariableTypes = ["double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

course = readtable("C:\Users\Frieder Uerlings\Desktop\PointMassSimulation\Kurs\fsg_track_1m_fixedlength.csv.1", opts);
% course = readtable("C:\Users\fried\Desktop\PointMassSimulation\Kurs\fsg_track_1m_fixedlength.csv.1", opts);
course = table2array(course);
clear opts

%Sortiert die Punkte aus der Bohrtabelle
[course,distance,TrackLength] = sortingPoints(course);



