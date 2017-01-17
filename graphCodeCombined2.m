% ------------------------------------------------------------------------
% MATLAB Code to Create the Graphs for WAI Measurements
% Author: Tinli Yarrington
% Current Editor: ______________ (insert your name here)
% Date: 14 June 2016
% ------------------------------------------------------------------------

% makes sure that the screen is cleared (begins fresh every time)
clear all
close all
clc

% type in the files (in the same directory as this program) that contains
% the measurements and subjects
file = 'test_subjects.csv';
file2 = 'Shahnaz_Subject_Info.csv';

% reads the file into a table for easy access to the measurements and
% subjects tables
M = readtable(file);
S = readtable(file2);

% determines the number of rows(W, R) and columns(H, C) in the table
[W, H] = size(M);
[R, C] = size(S);

% retrieves the subject number, ear location (right/left), frequency,
% absorbance, and impedance magnitude and direction columns from the table
sub_num = M{:, 2};
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

% keeps track of the indicies for the left and right ear frequencies,
% absorbance, and impedance magnitude and direction
left_index = 1;
right_index = 1;

% setting the x and y limits for the graphs
fax=([100 10000]);
fay_A=[0 1.1];
fay_ang = [-1.1 1.1];

% prompts user to select an option for graphing
display('Would you like to ');
display('(1) Graph a single subject number'); 
display('(2) Graph multiple subjects'); 
display('(3) Graph all subjects in the database');
display('(4) Choose a subset of subjects to graph');
option = input('Enter the number of your choice. ');

% option for single subject
if option == 1
    display(' ');
    % prompts user for a subject number whose graph you'd like to view
    id = input('Enter subject number whose graph you would like to view: ');

    % creates a single figure for the graphs to go on
    set(figure, 'Name', sprintf('Subject %d', id));
    orient tall;

    % loops through all of the rows to obtain the necessary information
    for index=1:W
        % checks if the subject number is the same as the user selected
        if round(sub_num(index)) == round(id)
             % 0 is for right ear, 1 is for left
             if ear_loc(index) == 1
                 % adds the current frequency and power reflectance to the
                 % arrays holding the left ear values
                 left_freq(left_index) = freq(index);
                 left_A(left_index) = absorbance(index);
                 left_Zmag(left_index) = Zmag(index);
                 left_Zang(left_index) = Zang(index);
                 left_index = left_index + 1;
             elseif ear_loc(index) == 0
                 % adds the current frequency and power reflectance to the
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

    % setting up the graph for the left ear (frequency = x, absorbance = y)
    subplot(321);
    semilogx(left_freq(1,:), left_A(1,:), 'b');
    xlim(fax);
    ylim(fay_A);
    xlabel('Frequency (Hz)');
    ylabel('Absorbance');
    title(sprintf('Left Ear for Subject %d', id));
    ax = gca;
    ax.XTick = [100 1000 10000];

    % setting up the graph for the right ear (frequency = x, absorbance = y)
    subplot(322);
    semilogx(right_freq(1,:), right_A(1,:), 'k');
    xlim(fax);
    ylim(fay_A);
    xlabel('Frequency (Hz)');
    ylabel('Absorbance');
    title(sprintf('Right Ear for Subject %d', id));
    
    % setting up the graph for the left ear (frequency = x, impedance magnitude = y)
    subplot(323);
    semilogx(left_freq(1,:), left_Zmag(1,:), 'r');
    xlim(fax);
    %ylim(fay_A);
    xlabel('Frequency (Hz)');
    ylabel('Z mag (mks Ohms)');

    % setting up the graph for the right ear (frequency = x, impedance magnitude = y)
    subplot(324);
    semilogx(right_freq(1,:), right_Zmag(1,:), 'm');
    xlim(fax);
    %ylim(fay_A);
    xlabel('Frequency (Hz)');
    ylabel('Z mag (mks Ohms)');
    
    % setting up the graph for the left ear (frequency = x, impedance angle = y)
    subplot(325);
    semilogx(left_freq(1,:), left_Zang(1,:), 'g');
    xlim(fax);
    ylim(fay_ang);
    xlabel('Frequency (Hz)');
    ylabel('Z angle (cycles)');

    % setting up the graph for the right ear (frequency = x, impedance angle = y)
    subplot(326);
    semilogx(right_freq(1,:), right_Zang(1,:), 'c');
    xlim(fax);
    ylim(fay_ang);
    xlabel('Frequency (Hz)');
    ylabel('Z angle (cycles)');

% option for multiple subjects
elseif option == 2
    display(' ');
    display('Would you like to (1) Input subject numbers, or (2) Choose the number of subjects to appear on the graphs. ');
    choice = input('Enter the number of your choice. ');

    % keeps track of subject numbers and how many there are for graphing
    ids = [];
    nums = 0;

    % creates a list of subjects entered by the user to be graphed
    if choice == 1
        % prompts user for a subject number whose graph you'd like to view
        nums = input('How many subjects would you like listed? ');
        for index=1:nums
           numChoice = input(sprintf('Choice %d: Enter a subject number. ', index));
           ids(end+1) = numChoice;
        end
    % generates the random number of subjects as requested by the user
    elseif choice == 2
        nums = input('How many random subjects would you like listed? ');
        % loops through as many times as requested numbers by the user
        for index=1:nums
            check = 1; % will help check to see if a subject number has already been included
            [WC,HC] = size(ids); % holds the current size of the subject numbers to be graphed
            
            % if no subject numbers have been added yet, generate a random
            % subject number
            if WC == 0
                addNum = randi([1 W], 1, 1);
                ids(index) = sub_num(addNum);
            else
                % loops while the random number has already been added to
                % the list to be graphed
                while check == 1 
                    addNum = randi([1 W], 1, 1);
                    for index=1:WC
                        check = 0;
                        if sub_num(addNum) == ids(index)
                            check = 1;
                            break
                        end  
                    end

                    if check == 0
                        ids(index) = sub_num(addNum);
                    end
                end
            end
        end
    % in case the wrong option was entered
    else
        display('That was not one of the choices.');
    end

    % creates a single figure for the graphs to go on
    set(figure, 'Name', 'Multiple Subjects');
    orient tall;

    % loops through all of the rows to obtain the necessary information
    for eachID=1:nums
        for index=1:W
            % checks if the subject number is the same as the user selected
            if round(sub_num(index)) == round(eachID)
                 % 0 is for right ear, 1 is for left
                 if ear_loc(index) == 1
                     % adds the current frequency and power reflectance to the
                     % arrays holding the left ear values
                     left_freq(left_index) = freq(index);
                     left_A(left_index) = absorbance(index);
                     left_Zmag(left_index) = Zmag(index);
                     left_Zang(left_index) = Zang(index);
                     left_index = left_index + 1;
                 elseif ear_loc(index) == 0
                     % adds the current frequency and power reflectance to the
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

        % setting up the graphs for the left ear if there are values already
        % recorded
        [WL, HL] = size(left_freq);
        if WL > 0
            % graph for Absorbance
            subplot(321);
            semilogx(left_freq(1,:), left_A(1,:), 'b');
            xlim(fax);
            ylim(fay_A);
            xlabel('Frequency (Hz)');
            ylabel('Absorbance');
            title(sprintf('%d Subjects for Left Ear', nums));
            hold on;
            
            % graph for impedance magnitude
            subplot(323);
            semilogx(left_freq(1,:), left_Zmag(1,:), 'r');
            xlim(fax);
            %ylim(fay_A);
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
        end
        hold on;

        % setting up the graphs for the right ear if there are values already
        % recorded
        [WR, HR] = size(right_freq);
        if WR > 0
            % graph of absorbance
            subplot(322);
            semilogx(right_freq(1,:), right_A(1,:), 'k');
            xlim(fax);
            ylim(fay_A);
            xlabel('Frequency (Hz)');
            ylabel('Absorbance');
            title(sprintf('%d Subjects for Right Ear', nums));
            hold on;
            
            % graph of impedance magnitude
            subplot(324);
            semilogx(right_freq(1,:), right_Zmag(1,:), 'm');
            xlim(fax);
            %ylim(fay_A);
            xlabel('Frequency (Hz)');
            ylabel('Z mag (mks Ohms)');
            hold on;
            
            % graph of impedance direction
            subplot(326);
            semilogx(right_freq(1,:), right_Zang(1,:), 'c');
            xlim(fax);
            ylim(fay_ang);
            xlabel('Frequency (Hz)');
            ylabel('Z ang (cycles)');  
            hold on;
        end

        % clear the current values to make room for new ones
        left_freq = [];
        right_freq = [];
        left_A = [];
        right_A = [];
        left_index = 1;
        right_index = 1;
        left_Zmag = [];
        right_Zmag = [];
        left_Zang = [];
        right_Zang = [];
    end

% option for all subjects
elseif option == 3
    display('Loading all the subjects onto the graph...');
 
    % creates a single figure for the graphs to go on
    set(figure, 'Name', 'All Subjects');
    orient tall;

    % loops through all of the rows to obtain the necessary information
    for index=1:W
        [WR, HR] = size(right_freq); 
        % will graph the first set of right ear data if the next set of data
        % has come up (switched to left ear or previous frequency is greater than current frequency)
        if index > 1 && (freq(index-1) > freq(index)) && WR > 0
            % graph for absorbance
            subplot(322);
            semilogx(right_freq(1,:), right_A(1,:), 'b');
            xlim(fax);
            ylim(fay_A);
            xlabel('Frequency (Hz)');
            ylabel('Absorbance');
            title('Right Ear');
            hold on;
            
            % graph for impedance magnitude
            subplot(324);
            semilogx(right_freq(1,:), right_Zmag(1,:), 'm');
            xlim(fax);
            %ylim(fay_A);
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
            
            % reset everything to add new values on the next loop
            right_freq = [];
            right_A = [];
            right_index = 1;
            left_freq = [];
            left_A = [];
            left_index = 1;
            left_Zmag = [];
            right_Zmag = [];
            left_Zang = [];
            right_Zang = [];
        end
         
         [WL, HL] = size(left_freq);
         % will graph the first set of left ear data if the next set of data
         % has come up (switched to right ear or previous frequency is greater than current frequency)
         if index > 1 && (freq(index-1) > freq(index)) && WL > 0
            % graph of absorbance
            subplot(321);
            semilogx(left_freq(1,:), left_A(1,:), 'k');
            xlim(fax);
            ylim(fay_A);
            xlabel('Frequency (Hz)');
            ylabel('Absorbance');
            title('Left Ear');
            hold on;
            
            % graph of impedance magnitude
            subplot(323);
            semilogx(left_freq(1,:), left_Zmag(1,:), 'r');
            xlim(fax);
            %ylim(fay_A);
            xlabel('Frequency (Hz)');
            ylabel('Z mag (mks Ohms)');
            hold on;
            
            % graph of impedance direction
            subplot(325);
            semilogx(left_freq(1,:), left_Zang(1,:), 'g');
            xlim(fax);
            ylim(fay_ang);
            xlabel('Frequency (Hz)');
            ylabel('Z ang (cycles)');  
            hold on;
            
            % reset the arrays to make room for new ones on next loop
            left_freq = [];
            left_A = [];
            left_index = 1;
            right_freq = [];
            right_A = [];
            right_index = 1;
            left_Zmag = [];
            right_Zmag = [];
            left_Zang = [];
            right_Zang = [];
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
        end
    end

elseif option == 4
    % retrieves the subject number, age, gender, race, and ethnicity from
    % subjects table
    subject_nums = S{:, 2};
    ages = S{:, 4};
    genders = S{:, 5};
    races = S{:, 6};
    ethnicities = S{:, 7};

    % keeps track of the age range, gender, race, and ethnicity the user
    % wants to graph
    ageLower = input('Enter lower end of age range. If you do not want to take age into account, enter -1: ');
    ageUpper = input('Enter upper end of age range. If you do not want to take age into account, enter -1: ');
    gender = input('Enter gender (0 for male, 1 for female, 2 for not available). If you do not want to take gender into account, enter -1: ');
    race = input('Enter race (0 for not available, 1 for American Indian or Alaska Native, 2 fro Asian or Asian American, 3 for Black or African American, 4 for Native Hawaiian or other Pacific Islander, 5 for White, 6 for Other). If you do not want to take race into account, enter -1: ');
    ethnicity = input('Enter ethnicity (0 for not available, 1 for Hispanic, 2 for Not Hispanic). If you do not want to take ethnicity into account, enter -1: ');

    % keeps track of subject numbers and how many there are for graphing
    ids = [];
    nums = 0;
    
    % adding the subject numbers to ids that fit the requirements
    for part=1:R
        if (round(ages(part)) >= round(ageLower) && round(ages(part)) <= round(ageUpper)) || (ageLower == -1 && ageUpper == -1)
            if round(genders(part)) == round(gender) || gender == -1
                if round(races(part)) == round(race) || race == -1
                    if round(ethnicities(part)) == round(ethnicity) || ethnicity == -1
                        nums = nums + 1;
                        ids(nums) = subject_nums(part);
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
            if round(sub_num(index)) == round(eachID)
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

        % setting up the graphs for the left ear
        [WL, HL] = size(left_freq);
        if WL > 0
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
            semilogx(left_freq(1,:), left_Zmag(1,:), 'r');
            xlim(fax);
            %ylim(fay_A);
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
            
        end

        % setting up the graphs for the right ear
        [WR, HR] = size(right_freq);
        if WR > 0
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
            semilogx(right_freq(1,:), right_Zmag(1,:), 'm');
            xlim(fax);
            %ylim(fay_A);
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
            
        end

        % reset the vectors to make room for new values to be graphed
        left_freq = [];
        right_freq = [];
        left_A = [];
        right_A = [];
        left_Zmag = [];
        right_Zmag = [];
        left_Zang = [];
        right_Zang = [];
        left_index = 1;
        right_index = 1;
    end
% in case the wrong choice was selected
else
    display('That was not one of the options. ');
end
