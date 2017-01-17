% ------------------------------------------------------------------------
% MATLAB Code to Create the Graphs for a Specified Subject Number
% Author: Tinli Yarrington
% Current Editor: ______________ (insert your name here)
% Date: 25 May 2016
% ------------------------------------------------------------------------

% makes sure that the screen is cleared (begins fresh every time)
clear all
close all
clc

% prompts user to select a file
display('Please select the file needed for graphing.');
% opens screen for user to input file for graphing
file = uigetfile();

% reads the file into a table for easy access to the measurements
M = readtable(file);

% determines the number of rows(W) and columns(H) in the table
[W, H] = size(M);

% retrieves the subject number, ear location (right/left), frequency, and
% power reflectance columns from the table
sub_num = M{:, 2};
ear_loc = M{:, 4};
freq = M{:, 8};
power_R = 1-M{:, 9};

% prompts user for a subject number whose graph you'd like to view
id = input('Enter subject number whose graph you would like to view: ');

% creates empty arrays that will hold the frequencies and power
% reflectances for the subject number requested
left_freq = [];
right_freq = [];
left_PR = [];
right_PR = [];

% keeps track of the indicies for the left and right ear frequencies and
% power reflectances
left_index = 1;
right_index = 1;

% creates a single figure for the graphs to go on
%figure(sprintf('Subject %d', id));
set(figure, 'Name', sprintf('Subject %d', id));
orient tall;

% loops through all of the rows to obtain the necessary information
for index=1:W
    % checks if the subject number is the same as the user selected
    %if sub_num(index) >= id -1 && sub_num(index) <= id +1
    if round(sub_num(index)) == round(id)
         % 0 is for right ear, 1 is for left
         if ear_loc(index) == 1
             % adds the current frequency and power reflectance to the
             % arrays holding the left ear values
             left_freq(left_index) = freq(index);
             left_PR(left_index) = power_R(index);
             left_index = left_index + 1;
         elseif ear_loc(index) == 0
             % adds the current frequency and power reflectance to the
             % arrays holding the right ear values
             right_freq(right_index) = freq(index);
             right_PR(right_index) = power_R(index);
             right_index = right_index + 1;
         % case to check if something is off in the code
         else
             display('Something is wrong');
         end 
    end
end

% setting the x and y limits of the upcoming graphs
fax=([100 6100]);
fay_PR=[0 1.1];

% setting up the graph for the left ear (frequency = x, power reflectance = y)
subplot(321);
semilogx(left_freq(1,:), left_PR(1,:), 'b');
xlim(fax);
ylim(fay_PR);
xlabel('Frequency (Hz)');
ylabel('Power Reflectance');
title('Left Ear');

% setting up the graph for the right ear (frequency = x, power reflectance = y)
subplot(322);
semilogx(right_freq(1,:), right_PR(1,:), 'k');
xlim(fax);
ylim(fay_PR);
xlabel('Frequency (Hz)');
ylabel('Power Reflectance');
title('Right Ear');
