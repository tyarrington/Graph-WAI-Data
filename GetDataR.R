# Access the package RMySQL
library(RMySQL)

# Establish connection between R and MySQL
db <- dbConnect(MySQL(), user='waiuser', password='smith_waiDB', host='scidb.smith.edu', dbname='wai')

# Import measurements and subject tables into R
measurements <- dbGetQuery(db, "select * from Measurements;")
subject_table <- dbGetQuery(db, "select * from Subject;")