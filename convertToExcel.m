%sub_table = struct2table(DatabaseSubInfo);
measurement_table = struct2table(DatabaseMeasurement);

%filename = 'Subject_table_Voss_R15.csv';
filename2 = 'Measurements_table_Voss_R15.csv';

%writetable(sub_table, filename);
writetable(measurement_table, filename2);