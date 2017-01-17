/* Grants access to the database*/
use wai;
/* View all data points in Measurements (no parameters)*/
select * from Measurements;
/* Grants access to the database*/
use wai;
/* View all data points/values/Strings in Subject (no parameters)*/
select * from Subject;
/* */
delete from Subject;
load data local infile 'Users/vosslab/Documents/Pontes/CSV Files/All_SUB.csv' into table Subject fields terminated by ',' enclosed by '"' lines terminated by '\r';
select * from Subject;
alter table Subject drop column ID;
alter table Subject add column ID serial;
select * from Subject;
use wai;
select * from Measurements where Sub_Number = 5;
use wai;
use wai;
insert into PI_Info values ('Voss_2014','2014','Susan Voss;Abur;Horton','Smith College','svoss@smith.edu','Intrasubject Variability in Power Reflectance','J Am Acad Audiol','10/04/2014','http://www.ncbi.nlm.nih.gov/pubmed/?term=abur+voss+2014','Three position, position 1(deppest) accepted','2');
select * from PI_Info;
delete from PI_Info where Title = 'Paper Title';
use wai;
select * from PI_Info;
use wai;
alter table PI_Info drop column ID;
alter table Measurements drop column ID;
update Measurements set Identifier = 'Voss_ASA14' where Identifier='Voss_2014';
select * from Measurements;
delete from Measurements where Identifier = 'Abur_2014';
load data local infile 'Users/vosslab/Documents/Abur_2014_data/Voss_2014_data.csv' into table Measurements fields terminated by ',' enclosed by '"' lines terminated by '\r';
select * from Measurements where Identifier = 'Voss_2014';
alter table Measurements change Ear_Area Ear_Area varchar(20);
update Measurements set Ear_Area = 'NaN' where Identifier = 'Voss_2014';
select * from Measurements;
use wai;
select * from Measurements;
use wai;
load data local infile 'Users/vosslab/Documents/Pontes/CSV Files/Data_Mimosa_Sub11to17.csv' into table Measurements fields terminated by ',' enclosed by '"' lines terminated by '\r';
select * from Measurements where Sub_Number = 15;
select * from Measurements where (Identifier,Sub_Number) = ('Voss_ASA14',4);
load data local infile 'Users/vosslab/Documents/Pontes/CSV Files/Data_Titan_Sub1to9.csv' into table Measurements fields terminated by ',' enclosed by '"' lines terminated by '\r';
load data local infile 'Users/vosslab/Documents/Pontes/CSV Files/Data_Titan_Sub11to17.csv' into table Measurements fields terminated by ',' enclosed by '"' lines terminated by '\r';
select * from Measurements where (Identifier,instrument)=('Voss_ASA14',2);
select * from Measurements where Identifier = 'Voss_2014';
use wai;
delete from Measurements where (Identifier,Sub_Number)=('Voss_ASA14',17);
select * from Measurements where (Identifier,Sub_Number)=('Voss_ASA14',11);
load data local infile 'Users/vosslab/Documents/Pontes/CSV Files/Data_Mimosa_Sub11to17.csv' into table Measurements fields terminated by ',' enclosed by '"' lines terminated by '\r';
select * from Measurements where Identifier=11;
delete from Measurements where Identifier=11;
select * from Measurements where (Identifier,Sub_Number)=('Voss_ASA14',11);
select * from Measurements where Identifier=11;
load data local infile 'Users/vosslab/Documents/Pontes/CSV Files/Data_Titan_Sub11to17.csv' into table Measurements fields terminated by ',' enclosed by '"' lines terminated by '\r';
use wai;
delete from Measurements where (Identifier,Sub_Number,LEFT_Ear)=('Voss_ASA14',15,0);
select * from Measurements where (Identifier,Sub_Number)=('Voss_ASA14',15);
use wai;
select * from Measurements;
use wai;
select * from Measurements;
use wai;
select *  from Measurements;
load data local infile 'Users/vosslab/Desktop/Gabrielle Merchant/Data.csv' into table Measurements fields terminated by ',' enclosed by '"' lines terminated by '\r';
select * from Measurements where Identifier = 'Rosowski_2012';
select * from Subject;
load data local infile 'Users/vosslab/Desktop/Gabrielle Merchant/Subject Info.csv' into table Subject fields terminated by ',' enclosed by '"' lines terminated by '\r';
select * from Subject;
select * from PI_Info;
insert into PI_Info values ('Rosowski_2012','2012','Rosowski, J.J.','NaN','John_Rosowski@meei.harvard.edu','Ear-Canal Reflectance, Umbo Velocity, and Tympanometry in Normal-Hearing Adults','Ear & Hearing','11/06/2015','http://www.ncbi.nlm.nih.gov/pubmed/21857517','NaN');
select * from PI_Info;
alter table PI_Info change Affiliation Affiliation varchar(500);
select * from PI_info;
use wai;
select * from PI_Info;
update PI_Info set Affiliation = 'Eaton-Peabody Laboratory, Massachusetts Eye and Ear Infirmary, Boston; Department of Otology and Laryngology, Harvard Medical School, Boston; Speech and Hearing Bioscience and Technology Program, Harvard-MIT Division of Health Sciences and Technology, Cambridge.' where Identifier = 'Rosowski_2012';
select * from PI_Info;
alter table PI_Info change PI_Notes PI_Notes varchar(1500);
update PI_Info set PI_Notes = 'HearID (Mimosa Acoustics); 
Normal Criteria as follows: 
(1) There was no history of significant middle ear disease (e.g., otitis media or effusion 2 or more years previously were not considered significant if there were no known residual consequences).
(2) There was no history of otologic surgery, with the exception of myringotomy or tympanostomy tube placement over 2 yr prior. 
(3) The external ear and TM revealed no abnormalities on otoscopic examination. 
(4) Audiometric measurements had pure-tone thresholds of 20 dB HL or better at octave frequen- cies between 0.250 and 8 kHz. 
(5) Air-bone gaps were no greater than 15 dB at 0.25 kHz and 10 dB between frequencies of 0.5 to 4 kHz. Most subjects had air and bone thresholds between 0 and 10 dB HL with an average near 8 to 9 dB HL at the highest frequencies. 
(6) Tympanograms were Type-A peaked, with peak pressures of 100 to 50 daPa, static compliance of 0.3 to 2.0 cc, total tympanometric volumes (static compliance ear canal volume) between 0.7 and 2.7 cc, and normal-appearing shape that is neither rounded nor sharp. 
(7) All subjects included in the “normal hearing” population were required to have two “normal” ears (as defined by criteria described earlier).' where Identifier = 'Rosowski_2012';
select * from PI_Info;
 
