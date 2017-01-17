% ------------------------------------------------------------------------
% MATLAB Code to Connect WAI Database to Matlab to Create Graphs
% Author: Tinli Yarrington
% Date: 6 July 2016
% ------------------------------------------------------------------------

% allow the JDBC driver to connect Matlab and MySQL
javaaddpath '/Users/vosslab/Desktop/mysql-connector-java-5.1.39/mysql-connector-java-5.1.39-bin.jar';
% establish the connection with the WAI database
conn = database('wai', 'waiuser', 'smith_waiDB', 'Vendor', 'MySQL', 'Server', 'scidb.smith.edu');

% commands for the database to access all of the subject and measurement
% values for graphing
commforM = 'select * from Measurements';
commforS = 'select * from Subjects';

% set the format of the incoming data to a table for easy access
setdbprefs('DataReturnFormat', 'table');

% fetching the data itself from the database using the commands
M = fetch(conn, commforM);
S = fetch(conn, commforS);