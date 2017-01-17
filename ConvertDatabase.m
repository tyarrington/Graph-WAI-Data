clear all
close all
clc

load('Processed_Data.mat');

% for subjects csv file
identifier_S = {};
subject_numbers_S = [];
session_total = [];
ages = [];
genders = [];
races = [];
ethnicities = [];
left_ear_status = [];
right_ear_status = [];
sub_notes = {};

% for measurements csv file
identifier_M = {};
subject_numbers_M = [];
session = [];
left_ear = [];
MEP = {};
instrument = [];
ear_area = {};
frequency = [];
absorbance = [];
Zmag = [];
Zang = [];

[x, rows] = size(Database);

each_index = 1;
next_index = 1;

for index=1:rows
    if not(isequal(Database(index).id, [])) && Database(index).id > 200
        % adding necessary values to Subject arrays
        identifier_S{each_index} = 'Voss_R15';
        subject_numbers_S(each_index) = Database(index).id;
        genders(each_index) = Database(index).gender;
        ages(each_index) = Database(index).age;
        ethnicities(each_index) = Database(index).ethnicity;
        races(each_index) = Database(index).race;
        session_total(each_index) = 1;
        left_ear_status(each_index) = 0;
        right_ear_status(each_index) = 0;
        sub_notes{each_index} = Database(index).Comments;
        
        if not(Database(index).Z_M_L_Valid == 0)
            % adding necessary values to Measurement arrays (Mimosa Left)
            [numR, numC] = size(Database(index).Zvector_Mimosa_left);
            for part=1:numR
                identifier_M{next_index} = 'Voss_R15';
                subject_numbers_M(next_index) = Database(index).id;
                session(next_index) = 1;
                left_ear(next_index) = 1;
                MEP{next_index} = 'NaN';
                instrument(next_index) = 1;
                ear_area{next_index} = 'NaN';
                frequency(next_index) = Database(index).Zvector_Mimosa_left(part,1);
                absorbance(next_index) = Database(index).Zvector_Mimosa_left(part,2);
                Zmag(next_index) = Database(index).Zvector_Mimosa_left(part,3);
                Zang(next_index) = Database(index).Zvector_Mimosa_left(part,4);
                next_index = next_index + 1;
            end
        end
        
        if not(Database(index).Z_M_R_Valid == 0)
            % adding necessary values to Measurement arrays (Mimosa Right)
            [numR, numC] = size(Database(index).Zvector_Mimosa_right);
            for part=1:numR
                identifier_M{next_index} = 'Voss_R15';
                subject_numbers_M(next_index) = Database(index).id;
                session(next_index) = 1;
                left_ear(next_index) = 0;
                MEP{next_index} = 'NaN';
                instrument(next_index) = 1;
                ear_area{next_index} = 'NaN';
                frequency(next_index) = Database(index).Zvector_Mimosa_right(part,1);
                absorbance(next_index) = Database(index).Zvector_Mimosa_right(part,2);
                Zmag(next_index) = Database(index).Zvector_Mimosa_right(part,3);
                Zang(next_index) = Database(index).Zvector_Mimosa_right(part,4);
                next_index = next_index + 1;
            end
        end
        
        if not(Database(index).Z_T_L_Valid == 0)
            % adding necessary values to Measurement arrays (Titan Left)
            [numR, numC] = size(Database(index).Zvector_Titan_left);
            for part=1:numR
                identifier_M{next_index} = 'Voss_R15';
                subject_numbers_M(next_index) = Database(index).id;
                session(next_index) = 1;
                left_ear(next_index) = 1;
                MEP{next_index} = 'NaN';
                instrument(next_index) = 2;
                ear_area{next_index} = 'NaN';
                frequency(next_index) = Database(index).Zvector_Titan_left(part,1);
                absorbance(next_index) = Database(index).Zvector_Titan_left(part,2);
                Zmag(next_index) = Database(index).Zvector_Titan_left(part,3);
                Zang(next_index) = Database(index).Zvector_Titan_left(part,4);
                next_index = next_index + 1;
            end
        end
        
        if not(Database(index).Z_T_R_Valid == 0)
            % adding necessary values to Measurement arrays (Titan Right)
            [numR, numC] = size(Database(index).Zvector_Titan_right);
            for part=1:numR
                identifier_M{next_index} = 'Voss_R15';
                subject_numbers_M(next_index) = Database(index).id;
                session(next_index) = 1;
                left_ear(next_index) = 0;
                MEP{next_index} = 'NaN';
                instrument(next_index) = 2;
                ear_area{next_index} = 'NaN';
                frequency(next_index) = Database(index).Zvector_Titan_right(part,1);
                absorbance(next_index) = Database(index).Zvector_Titan_right(part,2);
                Zmag(next_index) = Database(index).Zvector_Titan_right(part,3);
                Zang(next_index) = Database(index).Zvector_Titan_right(part,4);
                next_index = next_index + 1;
            end
        end
        
        if not(Database(index).Z_ER10x_L_Valid == 0)
            % adding necessary values to Measurement arrays (ER10x Left)
            [numR, numC] = size(Database(index).Zvector_ER10x_left);
            for part=1:numR
                identifier_M{next_index} = 'Voss_R15';
                subject_numbers_M(next_index) = Database(index).id;
                session(next_index) = 1;
                left_ear(next_index) = 1;
                MEP{next_index} = 'NaN';
                instrument(next_index) = 0;
                ear_area{next_index} = 'NaN';
                frequency(next_index) = Database(index).Zvector_ER10x_left(part,1);
                absorbance(next_index) = Database(index).Zvector_ER10x_left(part,2);
                Zmag(next_index) = Database(index).Zvector_ER10x_left(part,3);
                Zang(next_index) = Database(index).Zvector_ER10x_left(part,4);
                next_index = next_index + 1;
            end
        end
        
        if not(Database(index).Z_ER10x_R_Valid == 0)
            % adding necessary values to Measurement arrays (ER10x right)
            [numR, numC] = size(Database(index).Zvector_ER10x_right);
            for part=1:numR
                identifier_M{next_index} = 'Voss_R15';
                subject_numbers_M(next_index) = Database(index).id;
                session(next_index) = 1;
                left_ear(next_index) = 0;
                MEP{next_index} = 'NaN';
                instrument(next_index) = 0;
                ear_area{next_index} = 'NaN';
                frequency(next_index) = Database(index).Zvector_ER10x_right(part,1);
                absorbance(next_index) = Database(index).Zvector_ER10x_right(part,2);
                Zmag(next_index) = Database(index).Zvector_ER10x_right(part,3);
                Zang(next_index) = Database(index).Zvector_ER10x_right(part,4);
                next_index = next_index + 1;
            end
        end
        each_index = each_index + 1;
    end 
end

subjects_table = table(identifier_S', subject_numbers_S', session_total', ages', genders', races', ethnicities', left_ear_status', right_ear_status', sub_notes');
%filename = 'Voss_R15_Subject.csv';
%writetable(subjects_table, filename);

subjects = table2struct(subjects_table);

measurements_table = table(identifier_M', subject_numbers_M', session', left_ear', MEP', instrument', ear_area', frequency', absorbance', Zmag', Zang');
%filename = 'Voss_R15_Measurements.csv';
%writetable(measurements_table, filename);

measurements = table2struct(measurements_table);





