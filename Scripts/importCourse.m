%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: C:\Users\Frieder Uerlings\Desktop\Lap Time\Kurs\spline_test.csv.1
%
% Auto-generated by MATLAB on 29-Oct-2019 19:40:35

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 2);

% Specify range and delimiter
opts.DataLines = [3, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["VarName1", "Bohrtabelle"];
opts.VariableTypes = ["double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
course = readtable("C:\Users\Frieder Uerlings\Desktop\20191106_LapTime\Kurs\fsg_track_1m.csv.1", opts);

%% Convert to output type
course = table2array(course);

%% Clear temporary variables
clear opts

[course,distance,TrackLength] = sortingPoints(course);
course = addRadius(course);
