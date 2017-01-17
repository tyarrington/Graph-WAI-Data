% ------------------------------------------------------------------------
% MATLAB Code to Create the Graphs for WAI Measurements
% Author: Tinli Yarrington
% Current Editor: ______________ (insert your name here)
% Date: 7 July 2016
% ------------------------------------------------------------------------

% makes sure that the screen is cleared (begins fresh every time)
close all
clc

% type in the files (in the same directory as this program) that contains
% the measurements and subjects
file = 'test_measurements.csv';
file2 = 'test_subjects.xlsx';

% reads the file into a table for easy access to the measurements and
% subjects tables
M = readtable(file);
S = readtable(file2);

% determines the number of rows(W, R) and columns(H, C) in the table
[W, H] = size(M);
[R, C] = size(S);

% retrieves the subject number, session number, ear location (right/left), instrument, frequency,
% absorbance, and impedance magnitude and direction columns from the table
identifiers = M.Identifier;
S_Identifiers = S.Identifier;
sub_num = M.Sub_Number;
sub_num_subjects = S.Sub_Number;
session_num = S.Session_Total;
ear_loc = M.Left_Ear;
instrument = M.Instrument;
freq = M.Freq;
absorbance = M.Absorbance;
Zmag = M.Zmag;
Zang = M.Zang;

% creates empty arrays that will hold the frequencies,
% absorbance, and impedance magnitude and direction for the subject number
% requested in the left and right corresponding arrays
left_freq_Mimosa = [];
left_freq_Titan = [];
left_freq_Other = [];

right_freq_Mimosa = [];
right_freq_Titan = [];
right_freq_Other = [];

left_A_Other = [];
left_A_Mimosa = [];
left_A_Titan = [];

right_A_Other = [];
right_A_Mimosa = [];
right_A_Titan = [];

left_Zmag_Other = [];
left_Zmag_Mimosa = [];
left_Zmag_Titan = [];

right_Zmag_Other = [];
right_Zmag_Mimosa = [];
right_Zmag_Titan = [];

left_Zang_Other = [];
left_Zang_Mimosa = [];
left_Zang_Titan = [];

right_Zang_Other = [];
right_Zang_Mimosa = [];
right_Zang_Titan = [];

% keeps track of the indicies for the left and right ear frequencies,
% absorbance, and impedance magnitude and direction
left_index = 1;
right_index = 1;

% setting the x and y limits for the graphs
fax=([100 10000]);
fay_A=[0 1.1];
fay_mag = [1e6 1e9];
fay_ang = [-0.3 0.3];

% prompts user to select an option for graphing
display('Would you like to ');
display('(1) Graph a single subject number');  
display('(2) Graph all subjects in the database');
display('(3) Choose a subset of subjects to graph');
option = input('Enter the number of your choice. ');

% option for single subject
if option == 1
    display(' ');
    % prompts user for a subject number whose graph you'd like to view
    id = input('Enter subject number whose graph you would like to view: ');
    identifier = input('Enter an identifier name. If you do not wish to take this into account, enter NA: ', 's');
    
    % creates a single figure for the graphs to go on
    set(figure, 'Name', sprintf('Subject %d', id));
    orient tall;
    
    % confirms how many sessions the subject has tested so that each
    % measurement from the sessions is included
    session_total = 0;
    for part=1:R
        if round(sub_num_subjects(part)) == round(id) && (strcmp(identifier, S_Identifiers(part)) || strcmp('NA', identifier))
            session_total = session_num(part);
            break;
        end
    end
    
    % loops through all of the rows to obtain the necessary information
    for index=1:W
        % checks if the subject number is the same as the user selected
        if round(sub_num(index)) == round(id) && (strcmp(identifier, identifiers(index)) || strcmp('NA', identifier))
            % runs through each session to add the data
            for piece=1:session_total
                % if there are measurements in the arrays, add them to the
                % graph
                if index > 1 && freq(index-1) > freq(index)
                    % if the measurements were made by Mimosa for the left
                    % ear
                    if not(isempty(left_freq_Mimosa))
                        % setting up the graph for the left ear (frequency = x, absorbance = y)
                        subplot(321);
                        semilogx(left_freq_Mimosa(1,:), left_A_Mimosa(1,:), 'b');                      
                        xlim(fax);
                        ylim(fay_A);
                        xlabel('Frequency (Hz)');
                        ylabel('Absorbance');
                        title(sprintf('Left Ear for Subject %d', id));
                        ax = gca;
                        ax.XTick = [100 1000 10000];
                        hold on;

                        % setting up the graph for the left ear (frequency = x, impedance magnitude = y)
                        subplot(323);
                        loglog(left_freq_Mimosa(1,:), left_Zmag_Mimosa(1,:), 'b');
                        xlim(fax);
                        ylim(fay_mag);
                        xlabel('Frequency (Hz)');
                        ylabel('Z mag (mks Ohms)');
                        hold on;

                        % setting up the graph for the left ear (frequency = x, impedance angle = y)
                        subplot(325);
                        semilogx(left_freq_Mimosa(1,:), left_Zang_Mimosa(1,:), 'b');
                        xlim(fax);
                        ylim(fay_ang);
                        xlabel('Frequency (Hz)');
                        ylabel('Z angle (cycles)');
                        hold on;
                    
                        left_freq_Mimosa = [];
                        left_A_Mimosa = [];
                        left_Zmag_Mimosa = [];
                        left_Zang_Mimosa = [];
                        left_index = 1;
                    
                    % if the measurements were made by Titan for the left
                    % ear
                    elseif not(isempty(left_freq_Titan))
                        % setting up the graph for the left ear (frequency = x, absorbance = y)
                        subplot(321);
                        semilogx(left_freq_Titan(1,:), left_A_Titan(1,:),'color', [252/255,146/255,114/255]);
                        xlim(fax);
                        ylim(fay_A);
                        xlabel('Frequency (Hz)');
                        ylabel('Absorbance');
                        title(sprintf('Left Ear for Subject %d', id));
                        ax = gca;
                        ax.XTick = [100 1000 10000];
                        hold on;
                        
                        % setting up the graph for the left ear (frequency = x, impedance magnitude = y)
                        subplot(323);
                        loglog(left_freq_Titan(1,:), left_Zmag_Titan(1,:), 'color', [252/255,146/255,114/255]);
                        xlim(fax);
                        ylim(fay_mag);
                        xlabel('Frequency (Hz)');
                        ylabel('Z mag (mks Ohms)');
                        hold on;
                        
                        % setting up the graph for the left ear (frequency = x, impedance angle = y)
                        subplot(325);
                        semilogx(left_freq_Titan(1,:), left_Zang_Titan(1,:),'color', [252/255,146/255,114/255]);
                        xlim(fax);
                        ylim(fay_ang);
                        xlabel('Frequency (Hz)');
                        ylabel('Z angle (cycles)');
                        hold on;

                        left_freq_Titan = [];
                        left_A_Titan = [];
                        left_Zmag_Titan = [];
                        left_Zang_Titan = [];
                        left_index = 1;
                    
                    % if the measurements were made by a different machine
                    % than the first two for the left ear
                    elseif not(isempty(left_freq_Other))
                        % setting up the graph for the left ear (frequency = x, absorbance = y)
                        subplot(321);
                        semilogx(left_freq_Other(1,:), left_A_Other(1,:), 'k');
                        xlim(fax);
                        ylim(fay_A);
                        xlabel('Frequency (Hz)');
                        ylabel('Absorbance');
                        title(sprintf('Left Ear for Subject %d', id));
                        ax = gca;
                        ax.XTick = [100 1000 10000];
                        hold on;
                        
                        % setting up the graph for the left ear (frequency = x, impedance magnitude = y)
                        subplot(323);
                        loglog(left_freq_Other(1,:), left_Zmag_Other(1,:), 'k');
                        xlim(fax);
                        ylim(fay_mag);
                        xlabel('Frequency (Hz)');
                        ylabel('Z mag (mks Ohms)');
                        hold on;
                        
                        % setting up the graph for the left ear (frequency = x, impedance angle = y)
                        subplot(325);
                        semilogx(left_freq_Other(1,:), left_Zang_Other(1,:), 'k');
                        xlim(fax);
                        ylim(fay_ang);
                        xlabel('Frequency (Hz)');
                        ylabel('Z angle (cycles)');
                        hold on;

                        left_freq_Other = [];
                        left_A_Other = [];
                        left_Zmag_Other = [];
                        left_Zang_Other = [];
                        left_index = 1;
                    end
                    
                    % if the measurements were made by Mimosa for the right
                    % ear
                    if not(isempty(right_freq_Mimosa))
                        % setting up the graph for the right ear (frequency = x, absorbance = y)
                        subplot(322);
                        semilogx(right_freq_Mimosa(1,:), right_A_Mimosa(1,:), 'r');                     
                        xlim(fax);
                        ylim(fay_A);
                        xlabel('Frequency (Hz)');
                        ylabel('Absorbance');
                        title(sprintf('Right Ear for Subject %d', id));
                        ax = gca;
                        ax.XTick = [100 1000 10000];
                        hold on;

                        % setting up the graph for the right ear (frequency = x, impedance magnitude = y)
                        subplot(324);
                        loglog(right_freq_Mimosa(1,:), right_Zmag_Mimosa(1,:), 'r');
                        xlim(fax);
                        ylim(fay_mag);
                        xlabel('Frequency (Hz)');
                        ylabel('Z mag (mks Ohms)');
                        hold on;

                        % setting up the graph for the right ear (frequency = x, impedance angle = y)
                        subplot(326);
                        semilogx(right_freq_Mimosa(1,:), right_Zang_Mimosa(1,:), 'r');
                        xlim(fax);
                        ylim(fay_ang);
                        xlabel('Frequency (Hz)');
                        ylabel('Z angle (cycles)');
                        hold on;

                        right_freq_Mimosa = [];
                        right_A_Mimosa = [];
                        right_Zmag_Mimosa = [];
                        right_Zang_Mimosa = [];
                        right_index = 1;
                    
                    % if the measurements were made by Titan for the right
                    % ear
                    elseif not(isempty(right_freq_Titan))
                        % setting up the graph for the right ear (frequency = x, absorbance = y)
                        subplot(322);
                        semilogx(right_freq_Titan(1,:), right_A_Titan(1,:), 'm');
                        xlim(fax);
                        ylim(fay_A);
                        xlabel('Frequency (Hz)');
                        ylabel('Absorbance');
                        title(sprintf('Right Ear for Subject %d', id));
                        ax = gca;
                        ax.XTick = [100 1000 10000];
                        hold on;
                        
                        % setting up the graph for the right ear (frequency = x, impedance magnitude = y)
                        subplot(324);
                        loglog(right_freq_Titan(1,:), right_Zmag_Titan(1,:), 'm');
                        xlim(fax);
                        ylim(fay_mag);
                        xlabel('Frequency (Hz)');
                        ylabel('Z mag (mks Ohms)');
                        hold on;
                        
                        % setting up the graph for the right ear (frequency = x, impedance angle = y)
                        subplot(326);
                        semilogx(right_freq_Titan(1,:), right_Zang_Titan(1,:), 'm');
                        xlim(fax);
                        ylim(fay_ang);
                        xlabel('Frequency (Hz)');
                        ylabel('Z angle (cycles)');
                        hold on;

                        right_freq_Titan = [];
                        right_A_Titan = [];
                        right_Zmag_Titan = [];
                        right_Zang_Titan = [];
                        right_index = 1;
                        
                    % if the measurements were made by a different machine than the first two for the right
                    % ear
                    elseif not(isempty(right_freq_Other))
                        % setting up the graph for the right ear (frequency = x, absorbance = y)
                        subplot(322);
                        semilogx(right_freq_Other(1,:), right_A_Other(1,:),'color',[49/255,163/255,84/255]);
                        xlim(fax);
                        ylim(fay_A);
                        xlabel('Frequency (Hz)');
                        ylabel('Absorbance');
                        title(sprintf('Right Ear for Subject %d', id));
                        ax = gca;
                        ax.XTick = [100 1000 10000];
                        hold on;
                        
                        % setting up the graph for the right ear (frequency = x, impedance magnitude = y)
                        subplot(324);
                        loglog(right_freq_Other(1,:), right_Zmag_Other(1,:),'color',[49/255,163/255,84/255]);
                        xlim(fax);
                        ylim(fay_mag);
                        xlabel('Frequency (Hz)');
                        ylabel('Z mag (mks Ohms)');
                        hold on;
                        
                        % setting up the graph for the right ear (frequency = x, impedance angle = y)
                        subplot(326);
                        semilogx(right_freq_Other(1,:), right_Zang_Other(1,:), 'color',[49/255,163/255,84/255]);
                        xlim(fax);
                        ylim(fay_ang);
                        xlabel('Frequency (Hz)');
                        ylabel('Z angle (cycles)');
                        hold on;

                        right_freq_Other = [];
                        right_A_Other = [];
                        right_Zmag_Other = [];
                        right_Zang_Other = [];
                        right_index = 1;
                    end
                end
            end
            
             % 0 is for right ear, 1 is for left
             if ear_loc(index) == 1
                 % adds the current frequency, power reflectance, impedance magnitude and angle to the
                 % arrays holding the left ear values
                 if instrument(index) == 0 
                     left_freq_Other(left_index) = freq(index);
                     left_A_Other(left_index) = absorbance(index);
                     left_Zmag_Other(left_index) = Zmag(index);
                     left_Zang_Other(left_index) = Zang(index);
                     left_index = left_index + 1;
                 elseif instrument(index) == 1
                     left_freq_Mimosa(left_index) = freq(index);
                     left_A_Mimosa(left_index) = absorbance(index);
                     left_Zmag_Mimosa(left_index) = Zmag(index);
                     left_Zang_Mimosa(left_index) = Zang(index);
                     left_index = left_index + 1;
                 elseif instrument(index) == 2
                     left_freq_Titan(left_index) = freq(index);
                     left_A_Titan(left_index) = absorbance(index);
                     left_Zmag_Titan(left_index) = Zmag(index);
                     left_Zang_Titan(left_index) = Zang(index);
                     left_index = left_index + 1;
                 end
             elseif ear_loc(index) == 0
                 % adds the current frequency, power reflectance, impedance magnitude and angle to the
                 % arrays holding the right ear values
                 if instrument(index) == 0 
                     right_freq_Other(right_index) = freq(index);
                     right_A_Other(right_index) = absorbance(index);
                     right_Zmag_Other(right_index) = Zmag(index);
                     right_Zang_Other(right_index) = Zang(index);
                     right_index = right_index + 1;
                 elseif instrument(index) == 1
                     right_freq_Mimosa(right_index) = freq(index);
                     right_A_Mimosa(right_index) = absorbance(index);
                     right_Zmag_Mimosa(right_index) = Zmag(index);
                     right_Zang_Mimosa(right_index) = Zang(index);
                     right_index = right_index + 1;
                 elseif instrument(index) == 2
                     right_freq_Titan(right_index) = freq(index);
                     right_A_Titan(right_index) = absorbance(index);
                     right_Zmag_Titan(right_index) = Zmag(index);
                     right_Zang_Titan(right_index) = Zang(index);
                     right_index = right_index + 1;
                 end
             % case to check if something is off in the code
             else
                 display('Something is wrong');
             end 
        end
    end
    
% option for all subjects
elseif option == 2
    identifier = input('Would you like to specify an Identifier for the data? If not, enter NA: ', 's');
    display('Loading all the subjects onto the graph...');
 
    % creates a single figure for the graphs to go on
    set(figure, 'Name', 'All Subjects');
    orient tall;

    % loops through all of the rows to obtain the necessary information
    for index=1:W
        % if there are measurements in the arrays, add them to the graph
        if index > 1 && freq(index-1) > freq(index)
            % if the measurements were made by Mimosa for the left ear
            if not(isempty(left_freq_Mimosa))
                % setting up the graph for the left ear (frequency = x, absorbance = y)
                subplot(321);
                semilogx(left_freq_Mimosa(1,:), left_A_Mimosa(1,:), 'b');                      
                xlim(fax);
                ylim(fay_A);
                xlabel('Frequency (Hz)');
                ylabel('Absorbance');
                ax = gca;
                ax.XTick = [100 1000 10000];
                hold on;

                % setting up the graph for the left ear (frequency = x, impedance magnitude = y)
                subplot(323);
                loglog(left_freq_Mimosa(1,:), left_Zmag_Mimosa(1,:), 'b');
                xlim(fax);
                ylim(fay_mag);
                xlabel('Frequency (Hz)');
                ylabel('Z mag (mks Ohms)');
                hold on;

                % setting up the graph for the left ear (frequency = x, impedance angle = y)
                subplot(325);
                semilogx(left_freq_Mimosa(1,:), left_Zang_Mimosa(1,:), 'b');
                xlim(fax);
                ylim(fay_ang);
                xlabel('Frequency (Hz)');
                ylabel('Z angle (cycles)');
                hold on;

                left_freq_Mimosa = [];
                left_A_Mimosa = [];
                left_Zmag_Mimosa = [];
                left_Zang_Mimosa = [];
                left_index = 1;

            % if the measurements were made by Titan for the left ear
            elseif not(isempty(left_freq_Titan))
                % setting up the graph for the left ear (frequency = x, absorbance = y)
                subplot(321);
                semilogx(left_freq_Titan(1,:), left_A_Titan(1,:),'color', [252/255,146/255,114/255]);
                xlim(fax);
                ylim(fay_A);
                xlabel('Frequency (Hz)');
                ylabel('Absorbance');
                ax = gca;
                ax.XTick = [100 1000 10000];
                hold on;

                % setting up the graph for the left ear (frequency = x, impedance magnitude = y)
                subplot(323);
                loglog(left_freq_Titan(1,:), left_Zmag_Titan(1,:), 'color', [252/255,146/255,114/255]);
                xlim(fax);
                ylim(fay_mag);
                xlabel('Frequency (Hz)');
                ylabel('Z mag (mks Ohms)');
                hold on;

                % setting up the graph for the left ear (frequency = x, impedance angle = y)
                subplot(325);
                semilogx(left_freq_Titan(1,:), left_Zang_Titan(1,:),'color', [252/255,146/255,114/255]);
                xlim(fax);
                ylim(fay_ang);
                xlabel('Frequency (Hz)');
                ylabel('Z angle (cycles)');
                hold on;

                left_freq_Titan = [];
                left_A_Titan = [];
                left_Zmag_Titan = [];
                left_Zang_Titan = [];
                left_index = 1;

            % if the measurements were made by a different machine than the other two for the left ear
            elseif not(isempty(left_freq_Other))
                % setting up the graph for the left ear (frequency = x, absorbance = y)
                subplot(321);
                semilogx(left_freq_Other(1,:), left_A_Other(1,:), 'k');
                xlim(fax);
                ylim(fay_A);
                xlabel('Frequency (Hz)');
                ylabel('Absorbance');
                ax = gca;
                ax.XTick = [100 1000 10000];
                hold on;

                % setting up the graph for the left ear (frequency = x, impedance magnitude = y)
                subplot(323);
                loglog(left_freq_Other(1,:), left_Zmag_Other(1,:), 'k');
                xlim(fax);
                ylim(fay_mag);
                xlabel('Frequency (Hz)');
                ylabel('Z mag (mks Ohms)');
                hold on;

                % setting up the graph for the left ear (frequency = x, impedance angle = y)
                subplot(325);
                semilogx(left_freq_Other(1,:), left_Zang_Other(1,:), 'k');
                xlim(fax);
                ylim(fay_ang);
                xlabel('Frequency (Hz)');
                ylabel('Z angle (cycles)');
                hold on;

                left_freq_Other = [];
                left_A_Other = [];
                left_Zmag_Other = [];
                left_Zang_Other = [];
                left_index = 1;
            end
            
            % if the measurements were made by Mimosa for the right ear
            if not(isempty(right_freq_Mimosa))
                % setting up the graph for the right ear (frequency = x, absorbance = y)
                subplot(322);
                semilogx(right_freq_Mimosa(1,:), right_A_Mimosa(1,:), 'r');                     
                xlim(fax);
                ylim(fay_A);
                xlabel('Frequency (Hz)');
                ylabel('Absorbance');
                ax = gca;
                ax.XTick = [100 1000 10000];
                hold on;

                % setting up the graph for the right ear (frequency = x, impedance magnitude = y)
                subplot(324);
                loglog(right_freq_Mimosa(1,:), right_Zmag_Mimosa(1,:), 'r');
                xlim(fax);
                ylim(fay_mag);
                xlabel('Frequency (Hz)');
                ylabel('Z mag (mks Ohms)');
                hold on;

                % setting up the graph for the right ear (frequency = x, impedance angle = y)
                subplot(326);
                semilogx(right_freq_Mimosa(1,:), right_Zang_Mimosa(1,:), 'r');
                xlim(fax);
                ylim(fay_ang);
                xlabel('Frequency (Hz)');
                ylabel('Z angle (cycles)');
                hold on;

                right_freq_Mimosa = [];
                right_A_Mimosa = [];
                right_Zmag_Mimosa = [];
                right_Zang_Mimosa = [];
                right_index = 1;
                
            % if the measurements were made by Titan for the right ear
            elseif not(isempty(right_freq_Titan))
                % setting up the graph for the right ear (frequency = x, absorbance = y)
                subplot(322);
                semilogx(right_freq_Titan(1,:), right_A_Titan(1,:), 'm');
                xlim(fax);
                ylim(fay_A);
                xlabel('Frequency (Hz)');
                ylabel('Absorbance');
                ax = gca;
                ax.XTick = [100 1000 10000];
                hold on;

                % setting up the graph for the right ear (frequency = x, impedance magnitude = y)
                subplot(324);
                loglog(right_freq_Titan(1,:), right_Zmag_Titan(1,:), 'm');
                xlim(fax);
                ylim(fay_mag);
                xlabel('Frequency (Hz)');
                ylabel('Z mag (mks Ohms)');
                hold on;

                % setting up the graph for the right ear (frequency = x, impedance angle = y)
                subplot(326);
                semilogx(right_freq_Titan(1,:), right_Zang_Titan(1,:), 'm');
                xlim(fax);
                ylim(fay_ang);
                xlabel('Frequency (Hz)');
                ylabel('Z angle (cycles)');
                hold on;

                right_freq_Titan = [];
                right_A_Titan = [];
                right_Zmag_Titan = [];
                right_Zang_Titan = [];
                right_index = 1;
                
            % if the measurements were made by a different machine than the other two for the right ear    
            elseif not(isempty(right_freq_Other))
                % setting up the graph for the right ear (frequency = x, absorbance = y)
                subplot(322);
                semilogx(right_freq_Other(1,:), right_A_Other(1,:),'color',[49/255,163/255,84/255]);
                xlim(fax);
                ylim(fay_A);
                xlabel('Frequency (Hz)');
                ylabel('Absorbance');
                ax = gca;
                ax.XTick = [100 1000 10000];
                hold on;

                % setting up the graph for the right ear (frequency = x, impedance magnitude = y)
                subplot(324);
                loglog(right_freq_Other(1,:), right_Zmag_Other(1,:),'color',[49/255,163/255,84/255]);
                xlim(fax);
                ylim(fay_mag);
                xlabel('Frequency (Hz)');
                ylabel('Z mag (mks Ohms)');
                hold on;

                % setting up the graph for the right ear (frequency = x, impedance angle = y)
                subplot(326);
                semilogx(right_freq_Other(1,:), right_Zang_Other(1,:), 'color',[49/255,163/255,84/255]);
                xlim(fax);
                ylim(fay_ang);
                xlabel('Frequency (Hz)');
                ylabel('Z angle (cycles)');
                hold on;

                right_freq_Other = [];
                right_A_Other = [];
                right_Zmag_Other = [];
                right_Zang_Other = [];
                right_index = 1;
            end
        end
        
        % adding the measurements that match the identifier 
        if strcmp(identifiers(index), identifier) || strcmp(identifier, 'NA')
        % 0 is for right ear, 1 is for left
             if ear_loc(index) == 1 
                 % adds the current frequency, power reflectance, impedance magnitude and angle to the
                 % arrays holding the left ear values
                 if instrument(index) == 0 
                     left_freq_Other(left_index) = freq(index);
                     left_A_Other(left_index) = absorbance(index);
                     left_Zmag_Other(left_index) = Zmag(index);
                     left_Zang_Other(left_index) = Zang(index);
                     left_index = left_index + 1;
                 elseif instrument(index) == 1
                     left_freq_Mimosa(left_index) = freq(index);
                     left_A_Mimosa(left_index) = absorbance(index);
                     left_Zmag_Mimosa(left_index) = Zmag(index);
                     left_Zang_Mimosa(left_index) = Zang(index);
                     left_index = left_index + 1;
                 elseif instrument(index) == 2
                     left_freq_Titan(left_index) = freq(index);
                     left_A_Titan(left_index) = absorbance(index);
                     left_Zmag_Titan(left_index) = Zmag(index);
                     left_Zang_Titan(left_index) = Zang(index);
                     left_index = left_index + 1;
                 end
             elseif ear_loc(index) == 0
                 % adds the current frequency, power reflectance, impedance magnitude and angle to the
                 % arrays holding the right ear values
                 if instrument(index) == 0 
                     right_freq_Other(right_index) = freq(index);
                     right_A_Other(right_index) = absorbance(index);
                     right_Zmag_Other(right_index) = Zmag(index);
                     right_Zang_Other(right_index) = Zang(index);
                     right_index = right_index + 1;
                 elseif instrument(index) == 1
                     right_freq_Mimosa(right_index) = freq(index);
                     right_A_Mimosa(right_index) = absorbance(index);
                     right_Zmag_Mimosa(right_index) = Zmag(index);
                     right_Zang_Mimosa(right_index) = Zang(index);
                     right_index = right_index + 1;
                 elseif instrument(index) == 2
                     right_freq_Titan(right_index) = freq(index);
                     right_A_Titan(right_index) = absorbance(index);
                     right_Zmag_Titan(right_index) = Zmag(index);
                     right_Zang_Titan(right_index) = Zang(index);
                     right_index = right_index + 1;
                 end
             % case to check if something is off in the code
             else
                 display('Something is wrong');
             end 
        end
    end

% if the user asks to create graphs of a subset of the subjects
elseif option == 3
    % retrieves the identifiers, subject number, age, gender, race, and ethnicity from
    % subjects table
    subject_nums = S.Sub_Number;
    ages = S.Age;
    genders = S.Female;
    races = S.Race;
    ethnicities = S.Ethnicity;

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
        if strcmp(identifier, S_Identifiers(part)) || strcmp(identifier, 'NA')
            if (round(ages(part)) >= round(ageLower) && round(ages(part)) <= round(ageUpper)) || (ageLower == -1 && ageUpper == -1)
                if round(genders(part)) == round(gender) || gender == -1
                    if round(races(part)) == round(race) || race == -1
                        if round(ethnicities(part)) == round(ethnicity) || ethnicity == -1
                            nums = nums + 1;
                            ids(nums) = subject_nums(part);
                            sess_nums(nums) = session_num(part);
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
        % running through each value in the database
            for index=1:W
                % checks if the subject number is the same as the user selected
                if round(sub_num(index)) == round(ids(eachID)) && (strcmp(identifier, identifiers(index)) || strcmp('NA', identifier))
                    % running through each session for the subjects
                    for part=1:sess_nums(eachID)
                        % if there are measurements in the arrays
                        if index > 1 && freq(index-1) > freq(index)
                            % if the measurements were made by Mimosa for the left ear
                            if not(isempty(left_freq_Mimosa))
                                % setting up the graph for the left ear (frequency = x, absorbance = y)
                                subplot(321);
                                semilogx(left_freq_Mimosa(1,:), left_A_Mimosa(1,:), 'b');                      
                                xlim(fax);
                                ylim(fay_A);
                                xlabel('Frequency (Hz)');
                                ylabel('Absorbance');
                                title(sprintf('%d Subjects for Left Ear', nums));
                                ax = gca;
                                ax.XTick = [100 1000 10000];
                                hold on;

                                % setting up the graph for the left ear (frequency = x, impedance magnitude = y)
                                subplot(323);
                                loglog(left_freq_Mimosa(1,:), left_Zmag_Mimosa(1,:), 'b');
                                xlim(fax);
                                ylim(fay_mag);
                                xlabel('Frequency (Hz)');
                                ylabel('Z mag (mks Ohms)');
                                hold on;

                                % setting up the graph for the left ear (frequency = x, impedance angle = y)
                                subplot(325);
                                semilogx(left_freq_Mimosa(1,:), left_Zang_Mimosa(1,:), 'b');
                                xlim(fax);
                                ylim(fay_ang);
                                xlabel('Frequency (Hz)');
                                ylabel('Z angle (cycles)');
                                hold on;

                                left_freq_Mimosa = [];
                                left_A_Mimosa = [];
                                left_Zmag_Mimosa = [];
                                left_Zang_Mimosa = [];
                                left_index = 1;
                                
                            % if the measurements were made by Titan for the left ear
                            elseif not(isempty(left_freq_Titan))
                                % setting up the graph for the left ear (frequency = x, absorbance = y)
                                subplot(321);
                                semilogx(left_freq_Titan(1,:), left_A_Titan(1,:),'color', [252/255,146/255,114/255]);
                                xlim(fax);
                                ylim(fay_A);
                                xlabel('Frequency (Hz)');
                                ylabel('Absorbance');
                                title(sprintf('%d Subjects for Left Ear', nums));
                                ax = gca;
                                ax.XTick = [100 1000 10000];
                                hold on;

                                % setting up the graph for the left ear (frequency = x, impedance magnitude = y)
                                subplot(323);
                                loglog(left_freq_Titan(1,:), left_Zmag_Titan(1,:), 'color', [252/255,146/255,114/255]);
                                xlim(fax);
                                ylim(fay_mag);
                                xlabel('Frequency (Hz)');
                                ylabel('Z mag (mks Ohms)');
                                hold on;

                                % setting up the graph for the left ear (frequency = x, impedance angle = y)
                                subplot(325);
                                semilogx(left_freq_Titan(1,:), left_Zang_Titan(1,:),'color', [252/255,146/255,114/255]);
                                xlim(fax);
                                ylim(fay_ang);
                                xlabel('Frequency (Hz)');
                                ylabel('Z angle (cycles)');
                                hold on;

                                left_freq_Titan = [];
                                left_A_Titan = [];
                                left_Zmag_Titan = [];
                                left_Zang_Titan = [];
                                left_index = 1;

                            % if the measurements were made by a different machine than the other two for the left ear
                            elseif not(isempty(left_freq_Other))
                                % setting up the graph for the left ear (frequency = x, absorbance = y)
                                subplot(321);
                                semilogx(left_freq_Other(1,:), left_A_Other(1,:), 'k');
                                xlim(fax);
                                ylim(fay_A);
                                xlabel('Frequency (Hz)');
                                ylabel('Absorbance');
                                title(sprintf('%d Subjects for Left Ear', nums));
                                ax = gca;
                                ax.XTick = [100 1000 10000];
                                hold on;

                                % setting up the graph for the left ear (frequency = x, impedance magnitude = y)
                                subplot(323);
                                loglog(left_freq_Other(1,:), left_Zmag_Other(1,:), 'k');
                                xlim(fax);
                                ylim(fay_mag);
                                xlabel('Frequency (Hz)');
                                ylabel('Z mag (mks Ohms)');
                                hold on;

                                % setting up the graph for the left ear (frequency = x, impedance angle = y)
                                subplot(325);
                                semilogx(left_freq_Other(1,:), left_Zang_Other(1,:), 'k');
                                xlim(fax);
                                ylim(fay_ang);
                                xlabel('Frequency (Hz)');
                                ylabel('Z angle (cycles)');
                                hold on;

                                left_freq_Other = [];
                                left_A_Other = [];
                                left_Zmag_Other = [];
                                left_Zang_Other = [];
                                left_index = 1;
                            end
                            
                            % if the measurements were made by Mimosa for the right ear
                            if not(isempty(right_freq_Mimosa))
                                % setting up the graph for the right ear (frequency = x, absorbance = y)
                                subplot(322);
                                semilogx(right_freq_Mimosa(1,:), right_A_Mimosa(1,:), 'r');                     
                                xlim(fax);
                                ylim(fay_A);
                                xlabel('Frequency (Hz)');
                                ylabel('Absorbance');
                                title(sprintf('%d Subjects for Right Ear', nums));
                                ax = gca;
                                ax.XTick = [100 1000 10000];
                                hold on;

                                % setting up the graph for the right ear (frequency = x, impedance magnitude = y)
                                subplot(324);
                                loglog(right_freq_Mimosa(1,:), right_Zmag_Mimosa(1,:), 'r');
                                xlim(fax);
                                ylim(fay_mag);
                                xlabel('Frequency (Hz)');
                                ylabel('Z mag (mks Ohms)');
                                hold on;

                                % setting up the graph for the right ear (frequency = x, impedance angle = y)
                                subplot(326);
                                semilogx(right_freq_Mimosa(1,:), right_Zang_Mimosa(1,:), 'r');
                                xlim(fax);
                                ylim(fay_ang);
                                xlabel('Frequency (Hz)');
                                ylabel('Z angle (cycles)');
                                hold on;

                                right_freq_Mimosa = [];
                                right_A_Mimosa = [];
                                right_Zmag_Mimosa = [];
                                right_Zang_Mimosa = [];
                                right_index = 1;
                                
                            % if the measurements were made by Titan for the right ear
                            elseif not(isempty(right_freq_Titan))
                                % setting up the graph for the right ear (frequency = x, absorbance = y)
                                subplot(322);
                                semilogx(right_freq_Titan(1,:), right_A_Titan(1,:), 'm');
                                xlim(fax);
                                ylim(fay_A);
                                xlabel('Frequency (Hz)');
                                ylabel('Absorbance');
                                title(sprintf('%d Subjects for Right Ear', nums));
                                ax = gca;
                                ax.XTick = [100 1000 10000];
                                hold on;

                                % setting up the graph for the right ear (frequency = x, impedance magnitude = y)
                                subplot(324);
                                loglog(right_freq_Titan(1,:), right_Zmag_Titan(1,:), 'm');
                                xlim(fax);
                                ylim(fay_mag);
                                xlabel('Frequency (Hz)');
                                ylabel('Z mag (mks Ohms)');
                                hold on;

                                % setting up the graph for the right ear (frequency = x, impedance angle = y)
                                subplot(326);
                                semilogx(right_freq_Titan(1,:), right_Zang_Titan(1,:), 'm');
                                xlim(fax);
                                ylim(fay_ang);
                                xlabel('Frequency (Hz)');
                                ylabel('Z angle (cycles)');
                                hold on;

                                right_freq_Titan = [];
                                right_A_Titan = [];
                                right_Zmag_Titan = [];
                                right_Zang_Titan = [];
                                right_index = 1;
                            
                            % if the measurements were made by a different machine than the other two for the right ear
                            elseif not(isempty(right_freq_Other))
                                % setting up the graph for the right ear (frequency = x, absorbance = y)
                                subplot(322);
                                semilogx(right_freq_Other(1,:), right_A_Other(1,:),'color',[49/255,163/255,84/255]);
                                xlim(fax);
                                ylim(fay_A);
                                xlabel('Frequency (Hz)');
                                ylabel('Absorbance');
                                title(sprintf('%d Subjects for Right Ear', nums));
                                ax = gca;
                                ax.XTick = [100 1000 10000];
                                hold on;

                                % setting up the graph for the right ear (frequency = x, impedance magnitude = y)
                                subplot(324);
                                loglog(right_freq_Other(1,:), right_Zmag_Other(1,:),'color',[49/255,163/255,84/255]);
                                xlim(fax);
                                ylim(fay_mag);
                                xlabel('Frequency (Hz)');
                                ylabel('Z mag (mks Ohms)');
                                hold on;

                                % setting up the graph for the right ear (frequency = x, impedance angle = y)
                                subplot(326);
                                semilogx(right_freq_Other(1,:), right_Zang_Other(1,:), 'color',[49/255,163/255,84/255]);
                                xlim(fax);
                                ylim(fay_ang);
                                xlabel('Frequency (Hz)');
                                ylabel('Z angle (cycles)');
                                hold on;

                                right_freq_Other = [];
                                right_A_Other = [];
                                right_Zmag_Other = [];
                                right_Zang_Other = [];
                                right_index = 1;
                            end
                        end
                        
                        % 0 is for right ear, 1 is for left
                         if ear_loc(index) == 1
                             % adds the current frequency, power reflectance, impedance magnitude and angle to the
                             % arrays holding the left ear values
                             if instrument(index) == 0 
                                 left_freq_Other(left_index) = freq(index);
                                 left_A_Other(left_index) = absorbance(index);
                                 left_Zmag_Other(left_index) = Zmag(index);
                                 left_Zang_Other(left_index) = Zang(index);
                                 left_index = left_index + 1;
                             elseif instrument(index) == 1
                                 left_freq_Mimosa(left_index) = freq(index);
                                 left_A_Mimosa(left_index) = absorbance(index);
                                 left_Zmag_Mimosa(left_index) = Zmag(index);
                                 left_Zang_Mimosa(left_index) = Zang(index);
                                 left_index = left_index + 1;
                             elseif instrument(index) == 2
                                 left_freq_Titan(left_index) = freq(index);
                                 left_A_Titan(left_index) = absorbance(index);
                                 left_Zmag_Titan(left_index) = Zmag(index);
                                 left_Zang_Titan(left_index) = Zang(index);
                                 left_index = left_index + 1;
                             end
                             elseif ear_loc(index) == 0
                                 % adds the current frequency, power reflectance, impedance magnitude and angle to the
                                 % arrays holding the right ear values
                                 if instrument(index) == 0 
                                     right_freq_Other(right_index) = freq(index);
                                     right_A_Other(right_index) = absorbance(index);
                                     right_Zmag_Other(right_index) = Zmag(index);
                                     right_Zang_Other(right_index) = Zang(index);
                                     right_index = right_index + 1;
                                 elseif instrument(index) == 1
                                     right_freq_Mimosa(right_index) = freq(index);
                                     right_A_Mimosa(right_index) = absorbance(index);
                                     right_Zmag_Mimosa(right_index) = Zmag(index);
                                     right_Zang_Mimosa(right_index) = Zang(index);
                                     right_index = right_index + 1;
                                 elseif instrument(index) == 2
                                     right_freq_Titan(right_index) = freq(index);
                                     right_A_Titan(right_index) = absorbance(index);
                                     right_Zmag_Titan(right_index) = Zmag(index);
                                     right_Zang_Titan(right_index) = Zang(index);
                                     right_index = right_index + 1;
                                 end
                             % case to check if something is off in the code
                             else
                                 display('Something is wrong');
                            end 
                end
            end
        end
    end
        
% in case the wrong choice was selected
else
    display('That was not one of the options. ');
end
