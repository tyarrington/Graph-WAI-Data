%--------------------------------------------------------------------------------------
% PlotDatabaseData.m plots data from WAI database
%
% Description:
% Code below makes a plot of the data from the Rosowski_2012 part of the database
% Code can be modified to plot any aspect of data in the entire database
%
% Written by Susan Voss on September 2, 2016
% Edited by Tinli Yarrington on September 22, 2016
%----------------------------------------------------------------------------------------

clear all
close all
home

% Commands read the tables for Measurements and Subject that are downloaded
% August 2016 and named Measurements_August2016.csv and Subject_August2016.csv
Measurements=readtable('Measurements_Sept16.csv');
Subject_Info=readtable('Subject_Sept16.csv');

%Select data within Measurements-August2016 from the PI labelled 'Rosowski_2012' and rename subtable
%Selected_data (has all data from Rosowski_2012)
%Could keep all data if you prefer
PI='Rosowski_2012';
SelectedPI_binary= strcmp(PI,Measurements.Identifier);
SelectedPI_rows=find(SelectedPI_binary==1);
Selected_Data=Measurements(SelectedPI_rows,:);


Instrument_indices=find(Selected_Data.Instrument==1);  %Keep only indicies from instrument 1.  Mimosa here
Selected_Data=Selected_Data(Instrument_indices,:);  %Keep only data with desired instrument

%if you want to select a specific race, ethnicity, etc you would use the
%same approach but with the appropriate Table Column to select what you
%want.  Similarly, use this approach to group by age

%this code assumes all measurements have same frequencies
Freq_Vector=unique(Selected_Data.Freq);
Sub_Vector=unique(Selected_Data.Sub_Number);
Number_Subjects=length(Sub_Vector)

%make vectors for left and right ear for desired quantities and plot them
Absorbance_Left=[];
Absorbance_Right=[];
Absorbance_Diff=[];
Zmag_Left=[];
Zmag_Right=[];
Zmag_Ratio=[];
Zang_Left=[];
Zang_Right=[];
Zang_Diff=[];

Session=1; %could add loop here for multiple sessions if they exist;  here only 1 session per subject
for Subject_Index=1:Number_Subjects
   
    Subject_Data_indices=find(Selected_Data.Sub_Number==Sub_Vector(Subject_Index) & Selected_Data.Session==Session); 
    Subject_Data=Selected_Data(Subject_Data_indices,:);
       Left_ear_indices=find(Subject_Data.Left_Ear==1);  
       Right_ear_indices=find(Subject_Data.Left_Ear==0);  
            if isempty(Left_ear_indices)==0
                Left_data=Subject_Data(Left_ear_indices,:);
            else
                    Left_Data=nan(size(Freq_Vector));
            end
            if isempty(Right_ear_indices)==0
                Right_data=Subject_Data(Right_ear_indices,:);
            else
                Right_Data=nan(size(Freq_Vector));
            end
    Absorbance_Left=[Absorbance_Left Left_data.Absorbance];
    Absorbance_Right=[Absorbance_Right Right_data.Absorbance];
    Absorbance_Diff=[Absorbance_Diff Left_data.Absorbance-Right_data.Absorbance];
    Zmag_Left=[Zmag_Left Left_data.Zmag];
    Zmag_Right=[Zmag_Right Right_data.Zmag];
    Zmag_Ratio=[Zmag_Ratio Left_data.Zmag./Right_data.Zmag];
    Zang_Left=[Zang_Left Left_data.Zang];
    Zang_Right=[Zang_Right Right_data.Zang];
    Zang_Diff=[Zang_Diff Left_data.Zang-Right_data.Zang];
end
figure(1)
    subplot(331)
        semilogx(Freq_Vector,Absorbance_Left,'b')
        ylim([0 1])
        title('Left Ear')
        ylabel('Absorbance')
    subplot(332)
        semilogx(Freq_Vector,Absorbance_Right,'r')
        ylim([0 1])
        title('Right Ear')
    subplot(333)
        semilogx(Freq_Vector,Absorbance_Diff,'g')
        hold on
        semilogx(Freq_Vector,mean(Absorbance_Diff.').','k','LineWidth',3)
        title('Difference:  Left-right')
        ylim([-.5 .5])
    subplot(334)
        loglog(Freq_Vector,Zmag_Left,'b')
        ylim([1e6 1e8])
        ylabel('Impedance Magnitude (mks)')
    subplot(335)
        loglog(Freq_Vector,Zmag_Right,'r')
        ylim([1e6 1e8])
    subplot(336)
        loglog(Freq_Vector,Zmag_Ratio,'g')
        hold on
        loglog(Freq_Vector,mean(Zmag_Ratio.').','k','LineWidth',3)
        title('Ratio: Left/Right')
        
    subplot(337)
        semilogx(Freq_Vector,Zang_Left,'b')
        ylim([-.3 .3])
        xlabel('Frequency (Hz)')
        ylabel('Impedance Angle (cycles)')
    subplot(338)
        semilogx(Freq_Vector,Zang_Right,'r')
        ylim([-.3 .3])
        xlabel('Frequency (Hz)')
    subplot(339)
        semilogx(Freq_Vector,Zang_Diff,'g')
        hold on
        semilogx(Freq_Vector,mean(Zang_Diff.').','k','LineWidth',3)
        xlabel('Frequency (Hz)')
        title('Difference:  Left-right')
        
suptitle('Data from Rosowski 2012 entries in WAI database')


