%%Convert Subject Information and Measured Data
%Jingping Nie, June/22/2016
clear all
close all
clc

load('Processed_Data.mat');


[x, rows] = size(Database);
numSub=1; % Number of Subjects
index=1; 
next_index=1;

for index=1:rows
    %%Add the subject information
    if not(isequal(Database(index).id,[])) && Database(index).id > 200;
            DatabaseSubInfo(numSub).Identifier = 'Voss_R15';
            DatabaseSubInfo(numSub).Sub_Number = Database(index).id;
            DatabaseSubInfo(numSub).Session_Total = 1;
            DatabaseSubInfo(numSub).Age = Database(index).age;
            DatabaseSubInfo(numSub).Gender = Database(index).gender;
            DatabaseSubInfo(numSub).Race = Database(index).race;
            DatabaseSubInfo(numSub).Ethnicity = Database(index).ethnicity;
            DatabaseSubInfo(numSub).Left_Ear_Status = 0;
            DatabaseSubInfo(numSub).Right_Ear_Status = 0;
            DatabaseSubInfo(numSub).Sub_Notes = Database(index).Comments;
            % adding necessary values to Measurement arrays (Mimosa Left)
           if Database(index).Z_M_L_Valid == 1 %&& isequal(Database(index).Z_M_L_Valid, [])
                [numR, numC] = size(Database(index).Zvector_Mimosa_left);
                for part=1:numR
                    DatabaseMeasurement(next_index).Identifier = 'Voss_R15';
                    DatabaseMeasurement(next_index).Sub_Number = Database(index).id;
                    DatabaseMeasurement(next_index).Session = 1;
                    DatabaseMeasurement(next_index).Left_ear = 1;
                    DatabaseMeasurement(next_index).MEP = 'NaN';
                    DatabaseMeasurement(next_index).Instrument = 1;
                    DatabaseMeasurement(next_index).Ear_Area = 'NaN';%Database(index).CS_Area_L;
                    DatabaseMeasurement(next_index).Frequency = Database(index).Zvector_Mimosa_left(part,1);
                    DatabaseMeasurement(next_index).Absorbance = Database(index).Zvector_Mimosa_left(part,2);
                    DatabaseMeasurement(next_index).Zmag = Database(index).Zvector_Mimosa_left(part,3);
                    DatabaseMeasurement(next_index).Zang = Database(index).Zvector_Mimosa_left(part,4);
                    next_index = next_index + 1;
                end
            end
            % adding necessary values to Measurement arrays (Mimosa right)
            if Database(index).Z_M_R_Valid == 1
                [numR, numC] = size(Database(index).Zvector_Mimosa_right);
                for part=1:numR
                    DatabaseMeasurement(next_index).Identifier = 'Voss_R15';
                    DatabaseMeasurement(next_index).Sub_Number = Database(index).id;
                    DatabaseMeasurement(next_index).Session = 1;
                    DatabaseMeasurement(next_index).Left_ear = 0;
                    DatabaseMeasurement(next_index).MEP = 'NaN';
                    DatabaseMeasurement(next_index).Instrument = 1;
                    DatabaseMeasurement(next_index).Ear_Area = 'NaN';%Database(index).CS_Area_R;
                    DatabaseMeasurement(next_index).Frequency = Database(index).Zvector_Mimosa_right(part,1);
                    DatabaseMeasurement(next_index).Absorbance = Database(index).Zvector_Mimosa_right(part,2);
                    DatabaseMeasurement(next_index).Zmag = Database(index).Zvector_Mimosa_right(part,3);
                    DatabaseMeasurement(next_index).Zang = Database(index).Zvector_Mimosa_right(part,4);
                    next_index = next_index + 1;
                end
            end
            % adding necessary values to Measurement arrays (Titan left)
            if Database(index).Z_T_L_Valid == 1
                [numR, numC] = size(Database(index).Zvector_Titan_left);
                for part=1:numR
                    DatabaseMeasurement(next_index).Identifier = 'Voss_R15';
                    DatabaseMeasurement(next_index).Sub_Number = Database(index).id;
                    DatabaseMeasurement(next_index).Session = 1;
                    DatabaseMeasurement(next_index).Left_ear = 1;
                    DatabaseMeasurement(next_index).MEP = 'NaN';
                    DatabaseMeasurement(next_index).Instrument = 2;
                    DatabaseMeasurement(next_index).Ear_Area = 'NaN';%Database(index).CS_Area_L;
                    DatabaseMeasurement(next_index).Frequency = Database(index).Zvector_Titan_left(part,1);
                    DatabaseMeasurement(next_index).Absorbance = Database(index).Zvector_Titan_left(part,2);
                    DatabaseMeasurement(next_index).Zmag = Database(index).Zvector_Titan_left(part,3);
                    DatabaseMeasurement(next_index).Zang = Database(index).Zvector_Titan_left(part,4);
                    next_index = next_index + 1;
                end
            end
            % adding necessary values to Measurement arrays (Titan right)
            if Database(index).Z_T_L_Valid == 1
                [numR, numC] = size(Database(index).Zvector_Titan_right);
                for part=1:numR
                    DatabaseMeasurement(next_index).Identifier = 'Voss_R15';
                    DatabaseMeasurement(next_index).Sub_Number = Database(index).id;
                    DatabaseMeasurement(next_index).Session = 1;
                    DatabaseMeasurement(next_index).Left_ear = 0;
                    DatabaseMeasurement(next_index).MEP = 'NaN';
                    DatabaseMeasurement(next_index).Instrument = 2;
                    DatabaseMeasurement(next_index).Ear_Area = 'NaN';%Database(index).CS_Area_R;
                    DatabaseMeasurement(next_index).Frequency = Database(index).Zvector_Titan_right(part,1);
                    DatabaseMeasurement(next_index).Absorbance = Database(index).Zvector_Titan_right(part,2);
                    DatabaseMeasurement(next_index).Zmag = Database(index).Zvector_Titan_right(part,3);
                    DatabaseMeasurement(next_index).Zang = Database(index).Zvector_Titan_right(part,4);
                    next_index = next_index + 1;
                end
            end
            % adding necessary values to Measurement arrays (ER10x left)
            if Database(index).Z_ER10x_L_Valid == 1
                [numR, numC] = size(Database(index).Zvector_ER10x_left);
                for part=1:numR
                    DatabaseMeasurement(next_index).Identifier = 'Voss_R15';
                    DatabaseMeasurement(next_index).Sub_Number = Database(index).id;
                    DatabaseMeasurement(next_index).Session = 1;
                    DatabaseMeasurement(next_index).Left_ear = 1;
                    DatabaseMeasurement(next_index).MEP = 'NaN';
                    DatabaseMeasurement(next_index).Instrument = 0;
                    DatabaseMeasurement(next_index).Ear_Area = 'NaN';%Database(index).CS_Area_L;
                    DatabaseMeasurement(next_index).Frequency = Database(index).Zvector_ER10x_left(part,1);
                    DatabaseMeasurement(next_index).Absorbance = Database(index).Zvector_ER10x_left(part,2);
                    DatabaseMeasurement(next_index).Zmag = Database(index).Zvector_ER10x_left(part,3);
                    DatabaseMeasurement(next_index).Zang = Database(index).Zvector_ER10x_left(part,4);
                    next_index = next_index + 1;
                end
            end
            % adding necessary values to Measurement arrays (ER10x right)
            if Database(index).Z_ER10x_R_Valid == 1
                [numR, numC] = size(Database(index).Zvector_ER10x_right);
                for part=1:numR
                    DatabaseMeasurement(next_index).Identifier = 'Voss_R15';
                    DatabaseMeasurement(next_index).Sub_Number = Database(index).id;
                    DatabaseMeasurement(next_index).Session = 1;
                    DatabaseMeasurement(next_index).Left_ear = 0;
                    DatabaseMeasurement(next_index).MEP = 'NaN';
                    DatabaseMeasurement(next_index).Instrument = 0;
                    DatabaseMeasurement(next_index).Ear_Area = 'NaN';%Database(index).CS_Area_R;
                    DatabaseMeasurement(next_index).Frequency = Database(index).Zvector_ER10x_right(part,1);
                    DatabaseMeasurement(next_index).Absorbance = Database(index).Zvector_ER10x_right(part,2);
                    DatabaseMeasurement(next_index).Zmag = Database(index).Zvector_ER10x_right(part,3);
                    DatabaseMeasurement(next_index).Zang = Database(index).Zvector_ER10x_right(part,4);
                    next_index = next_index + 1;
                end
            end
            numSub=numSub+1;
    end
end
