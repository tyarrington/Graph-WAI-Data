% ------------------------------------------------------------------------
% MATLAB Code to Create the Graphs for a Subset of the Data
% Author: Tinli Yarrington
% Current Editor: ______________ (insert your name here)
% Date: 22 June 2016
% ------------------------------------------------------------------------

% makes sure that the screen is cleared (begins fresh every time)
clear all
close all
clc

% prompts user to select a file
% display('Please select the file needed for graphing.');
% opens screen for user to input file for graphing
file = 'test_measurements.csv';
file2 = 'test_subjects.csv';

% reads the file into a table for easy access to the measurements
M = readtable(file);
S = readtable(file2);

% determines the number of rows(W) and columns(H) in the table
[W, H] = size(M);
[R, C] = size(S);

% retrieves the subject number, session number, ear location (right/left), frequency,
% absorbance, and impedance magnitude and direction columns from the table
sub_num = M{:, 2};
session_num = M{:, 3};
ear_loc = M{:, 4};
freq = M{:, 8};
absorbance = M{:, 9};
Zmag = M{:, 10};
Zang = M{:, 11};

% creates empty arrays that will hold the frequencies,
% absorbance, and impedance magnitude and direction for the subject number
% requested in the left and right corresponding arrays
left_freq = [];
right_freq = [];
left_A = [];
right_A = [];
left_Zmag = [];
right_Zmag = [];
left_Zang = [];
right_Zang = [];

% retrieves the identifiers, subject number, age, gender, race, and ethnicity from
% subjects table
identifiers = S{:, 1};
subject_nums = S{:, 2};
sessions = S{:, 3};
ages = S{:, 4};
genders = S{:, 5};
races = S{:, 6};
ethnicities = S{:, 7};

% keeps track of the indicies for the left and right ear frequencies,
% absorbance, and impedance magnitude and direction
left_index = 1;
right_index = 1;

% setting the x and y limits for the graphs
fax=([100 10000]);
fay_A=[0 1.1];
fay_mag = [1e6 1e9];
fay_ang = [-0.3 0.3];

% keeps track of the identifiers, age range, gender, race, and ethnicity the user
% wants to graph
identifier = input('Enter desired identifier. If you do not want to take the identifier into account, enter NA: ', 's');
ageLower = input('Enter lower end of age range. If you do not want to take age into account, enter -1: ');
ageUpper = input('Enter upper end of age range. If you do not want to take age into account, enter -1: ');
gender = input('Enter gender (0 for male, 1 for female, 2 for not available). If you do not want to take gender into account, enter -1: ');
race = input('Enter race (0 for not available, 1 for American Indian or Alaska Native, 2 for Asian or Asian American, 3 for Black or African American, 4 for Native Hawaiian or other Pacific Islander, 5 for White, 6 for Other). If you do not want to take race into account, enter -1: ');
ethnicity = input('Enter ethnicity (0 for not available, 1 for Hispanic, 2 for Not Hispanic). If you do not want to take ethnicity into account, enter -1: ');

% keeps track of subject numbers and how many there are for graphing
ids = [];
nums = 0;
sess_nums = [];

% adding the subject numbers to ids that fit the requirements
for part=1:R
    if strcmp(identifier, identifiers(part)) || strcmp(identifier, 'NA')
        if (round(ages(part)) >= round(ageLower) && round(ages(part)) <= round(ageUpper)) || (ageLower == -1 && ageUpper == -1)
            if round(genders(part)) == round(gender) || gender == -1
                if round(races(part)) == round(race) || race == -1
                    if round(ethnicities(part)) == round(ethnicity) || ethnicity == -1
                        nums = nums + 1;
                        ids(nums) = subject_nums(part);
                        sess_nums(nums) = sessions(part);
                    end
                end
            end
        end
    end
end

% creates a single figure for the graphs to go on
set(figure, 'Name', 'Subset of Subjects');
orient tall;

% loops through all of the rows to obtain the necessary information
for eachID=1:nums
    for index=1:W
        % checks if the subject number is the same as the user selected
        if round(sub_num(index)) == round(ids(eachID))
            for part=1:sess_nums(eachID)
                % setting up the graphs for the left ear
                [WL, HL] = size(left_freq);
                if WL > 0 && index > 1 && freq(index-1) > freq(index)
                    % graph for absorbance
                    subplot(321);
                    semilogx(left_freq(1,:), left_A(1,:), 'k');
                    xlim(fax);
                    ylim(fay_A);
                    xlabel('Frequency (Hz)');
                    ylabel('Absorbance');
                    title(sprintf('%d Subjects for Left Ear', nums));
                    hold on;

                    % graph for impedance magnitude
                    subplot(323);
                    loglog(left_freq(1,:), left_Zmag(1,:), 'r');
                    xlim(fax);
                    ylim(fay_mag);
                    xlabel('Frequency (Hz)');
                    ylabel('Z mag (mks Ohms)');
                    hold on;

                    % graph for impedance direction
                    subplot(325);
                    semilogx(left_freq(1,:), left_Zang(1,:), 'g');
                    xlim(fax);
                    ylim(fay_ang);
                    xlabel('Frequency (Hz)');
                    ylabel('Z ang (cycles)');
                    hold on;
                    
                    % reset the vectors to make room for new values to be graphed
                    left_freq = [];
                    left_A = [];
                    left_Zmag = [];
                    left_Zang = [];
                    left_index = 1;
                end

                % setting up the graphs for the right ear
                [WR, HR] = size(right_freq);
                if WR > 0 && index > 1 && freq(index-1) > freq(index)
                    % graph for absorbance
                    subplot(322);
                    semilogx(right_freq(1,:), right_A(1,:), 'b');
                    xlim(fax);
                    ylim(fay_A);
                    xlabel('Frequency (Hz)');
                    ylabel('Absorbance');
                    title(sprintf('%d Subjects for Right Ear', nums));
                    hold on;

                    % graph for impedance magnitude
                    subplot(324);
                    loglog(right_freq(1,:), right_Zmag(1,:), 'm');
                    xlim(fax);
                    ylim(fay_mag);
                    xlabel('Frequency (Hz)');
                    ylabel('Z mag (mks Ohms)');
                    hold on;

                    % graph for impedance direction
                    subplot(326);
                    semilogx(right_freq(1,:), right_Zang(1,:), 'c');
                    xlim(fax);
                    ylim(fay_ang);
                    xlabel('Frequency (Hz)');
                    ylabel('Z ang (cycles)');
                    hold on;
                    
                    % reset the vectors to make room for new values to be graphed
                    right_freq = [];
                    right_A = [];
                    right_Zmag = [];
                    right_Zang = [];
                    right_index = 1;
                end
                
                 % 0 is for right ear, 1 is for left
                 if ear_loc(index) == 1
                     % adds the current frequency, absorbance, and impedance magnitude and direction to the
                     % arrays holding the left ear values
                     left_freq(left_index) = freq(index);
                     left_A(left_index) = absorbance(index);
                     left_Zmag(left_index) = Zmag(index);
                     left_Zang(left_index) = Zang(index);
                     left_index = left_index + 1;
                 elseif ear_loc(index) == 0
                     % adds the current frequency, absorbance, and impedance magnitude and direction to the
                     % arrays holding the right ear values
                     right_freq(right_index) = freq(index);
                     right_A(right_index) = absorbance(index);
                     right_Zmag(right_index) = Zmag(index);
                     right_Zang(right_index) = Zang(index);
                     right_index = right_index + 1;
                 % case to check if something is off in the code
                 else
                     display('Something is wrong');
                 end 
            end
        end 
    end
end
