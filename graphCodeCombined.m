% ------------------------------------------------------------------------
% MATLAB Code to Create the Graphs for a Specified Subject Number
% Author: Tinli Yarrington
% Current Editor: ______________ (insert your name here)
% Date: 26 May 2016
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

% prompts user to select an option for graphing
display('Would you like to ');
display('(1) Graph a single subject number'); 
display('(2) Graph multiple subjects'); 
display('(3) Graph all subjects in the database');
option = input('Enter the number of your choice. ');

% option for single subject
if option == 1
    display(' ');
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

% option for multiple subjects
elseif option == 2
    display(' ');
    display('Would you like to (1) Input subject numbers, or (2) Choose the number of subjects to appear on the graphs. ');
    choice = input('Enter the number of your choice. ');

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
        for index=1:nums
            check = 1;
            [WC,HC] = size(ids);
            if WC == 0
                addNum = randi([1 W], 1, 1);
                ids(index) = sub_num(addNum);
            else
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

        subPlotNum = 1;
        % setting the x and y limits of the upcoming graphs
        fax=([100 6100]);
        fay_PR=[0 1.1];

        % setting up the graph for the left ear (frequency = x, power reflectance = y)

        [WL, HL] = size(left_freq);
        if WL > 0
            subplot(220 + subPlotNum);
            semilogx(left_freq(1,:), left_PR(1,:), 'b');
            xlim(fax);
            ylim(fay_PR);
            xlabel('Frequency (Hz)');
            ylabel('Power Reflectance');
            title(sprintf('%d Subjects for Left Ear', nums));
        end
        hold on;

        % setting up the graph for the right ear (frequency = x, power reflectance = y)
        [WR, HR] = size(right_freq);
        if WR > 0
            subplot(220 + subPlotNum+1);
            semilogx(right_freq(1,:), right_PR(1,:), 'k');
            xlim(fax);
            ylim(fay_PR);
            xlabel('Frequency (Hz)');
            ylabel('Power Reflectance');
            title(sprintf('%d Subjects for Right Ear', nums));
        end
        hold on;

        left_freq = [];
        right_freq = [];
        left_PR = [];
        right_PR = [];
        left_index = 1;
        right_index = 1;
        subPlotNum = subPlotNum + 2;
    end

% option for all subjects
elseif option == 3
    display('Loading all the subjects onto the graph...');
    
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
    set(figure, 'Name', 'All Subjects');
    orient tall;

    % setting the x and y limits of the upcoming graphs
    fax=([100 6100]);
    fay_PR=[0 1.1];

    % loops through all of the rows to obtain the necessary information
    for index=1:W
        [WR, HR] = size(right_freq); 
        % will graph the first set of right ear data if the next set of data
        % has come up (switched to left ear or previous frequency is greater than current frequency)
        if index > 1 && (freq(index-1) > freq(index)) && WR > 0
            % setting up the graph for the left ear (frequency = x, power reflectance = y)
            subplot(222);
            semilogx(right_freq(1,:), right_PR(1,:), 'b');
            xlim(fax);
            ylim(fay_PR);
            xlabel('Frequency (Hz)');
            ylabel('Power Reflectance');
            title('Right Ear');
            hold on;
            right_freq = [];
            right_PR = [];
            right_index = 1;
            left_freq = [];
            left_PR = [];
            left_index = 1;
         end
         [WL, HL] = size(left_freq);
          % will graph the first set of left ear data if the next set of data
        % has come up (switched to right ear or previous frequency is greater than current frequency)
         if index > 1 && (freq(index-1) > freq(index)) && WL > 0
            % setting up the graph for the left ear (frequency = x, power reflectance = y)
            subplot(221);
            semilogx(left_freq(1,:), left_PR(1,:), 'k');
            xlim(fax);
            ylim(fay_PR);
            xlabel('Frequency (Hz)');
            ylabel('Power Reflectance');
            title('Left Ear');
            hold on;
            left_freq = [];
            left_PR = [];
            left_index = 1;
            right_freq = [];
            right_PR = [];
            right_index = 1;
         end
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
        end
    end

% in case the wrong choice was selected
else
    display('That was not one of the options. ');
end
