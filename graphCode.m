% type the name of the Measurements file below
% filename = 'practicecsvfile.csv';
% M = csvread(filename);

display('Please select the file needed for graphing.');
% opens screen for user to input file for graphing
file = uigetfile();

% please comment out one of the lines below depending on the type of file
% your data is stored in (if data is in csv file, comment out the xlsxread 
% line using % )
M = csvread(file);
%M = xlsread(file);

%filename = 'Jingping_Mimosa20.csv'
%M = csvread(filename);

% creates the two columns from the info given
% for the other files I'll be importing, I need to get the corresponding
% column numbers for the frequency and absorbance
sub_num = M(:, 1);
ear_loc = M(:, 2);
freq = M(:, 3);
powerR = 1 - M(:, 4);

% want to be able to check if excel, csv, or matlab data file here
% for now, create separate files for each one (should mostly be copy and paste)

% need to be able to access the frequency and absorbance columns in the
% data as well as the subject number
% need to also create graphs for left ear vs right ear
% do I need to graph with the impedances too?

% Frequency = <column with frequencies>
% Power_Absorbance = 1 - <column with absorbance>
% Sub_Number = <column with subject numbers>

% plot (should be a total of six graphs)
%plot(freq, powerR);

length = 1;
index = 2;
ear = ear_loc(1);
frequencies = {};
power_reflectance = {};

while length <= size(sub_num)
    left_freq = {};
    right_freq = {};
    left_PR = {};
    right_PR = {};
    while sub_num(index) == sub_num(index-1)
        % 0 is for right ear, 1 is for left
        if ear_loc == 0
            left_freq = [left_freq, freq(index)];
            left_PR = [left_PR, powerR(index)];
        else
            right_freq = [right_freq, freq(index)];
            right_PR = [right_PR, powerR(index)];
        end   
    end
    length = length + 1;
end


plot(left_freq, left_PR);
plot(right_freq, right_PR);









