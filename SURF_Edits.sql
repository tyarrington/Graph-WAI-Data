use wai;

select * from PI_Info;
select * from Subject;
delete from Subject where Age = NULL;

select * from Measurements;
select * from Measurements where Identifier = 'Voss_ASA14' AND Instrument = 2;

select * from Measurements where Sub_Number = 209 and Instrument = 2;

insert into PI_Info values ('Voss_ASA14','2014','Susan E. Voss; Defne Abur; Hiwot Kassaye; Nicholas J. Horton','Smith College','svoss@smith.edu','Comparisons of reflectance measurements across measurements sessions, instruments, and ages','Acoustical Society of America','2014','http://dx.doi.org/10.1121/1.4877464','NaN');
select * from PI_Info;

load data local infile 'Users/vosslab/Desktop/Tinli_SURF_2016/Voss_ASA14 Subject_Info.csv' into table Subject fields terminated by ',' enclosed by '"' lines terminated by '\r';

select * from Subject;
delete from Subject where Identifier = 'Voss_ASA29';
alter table Subject add column ID serial;

update Measurements set Sub_Number = 10 where Identifier = 'Voss_2014' AND Sub_Number = 1.00E+01;
select * from Measurements;
update Measurements set MEP = 0 where Identifier = 'Voss_2014' AND MEP = 0.00E+00;

load data local infile 'Users/vosslab/Desktop/Tinli_SURF_2016/Voss_R15_Subject.csv' into table Subject fields terminated by ',' enclosed by '"' lines terminated by '\r';
load data local infile 'Users/vosslab/Desktop/Tinli_SURF_2016/Voss_R15_Measurements.csv' into table Measurements fields terminated by ',' enclosed by '"' lines terminated by '\r';

update PI_Info set PI = 'Susan E. Voss, Defne Abur, Nicholas J. Horton' where Identifier = 'Voss_2014';
update PI_Info set PI = 'John J. Rosowski' where Identifier = 'Rosowski_2012';
update PI_Info set PI = 'Susan E. Voss, Defne Abur, Hiwot Kassaye, Nicholas J. Horton' where Identifier = 'Voss_ASA14';

insert into PI_Info values ('Voss_R15','2015','Susan E. Voss','Smith College','svoss@smith.edu','NaN','NaN','NaN','NaN','NaN');

delete from Measurements where Identifier = 'Identifier';

select * from Measurements where Identifier = 'Voss_2014';
delete from Measurements where Identifier = 'Voss_2014';

select * from Subject where Identifier = 'Voss_2014';
delete from Subject where Identifier = 'Voss_2014';

select * from PI_Info where Identifier = 'Voss_2014';
delete from PI_Info where Identifier = 'Voss_2014';