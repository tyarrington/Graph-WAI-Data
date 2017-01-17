# Make sure the data file is in the same directory as
# your current working directory
library(RMySQL)
db <- dbConnect(MySQL(), user='waiuser', password='smith_waiDB', host='scidb.smith.edu', dbname='wai')

m <- dbGetQuery(db, "select * from Measurements;")
s <- dbGetQuery(db, "select * from Subject;")
              
JustPlotIt <- function() {
    require(ggplot2)
  
    ageLower <- readline("Enter lower range of ages: ")
    ageUpper <- readline("Enter upper range of ages: ")
    gender <- readline("Enter gender: ")
    race <- readline("Enter race: ")
    ethnicity <- readline("Enter ethnicity: ")
    
    #ages <- subset(s, Age >= ageLower & Age <= ageUpper)
    #genders <- subset(s, Female == gender)
    #races <- subset(s, Race == race)
    #ethnicities <- subset(s, Ethnicity == ethnicity)
    
    subject.numbers <- subset(s, Age >= ageLower & Age <= ageUpper & Female == gender & Race == race & Ethnicity == ethnicity)
    frequencies <- subset(t, Sub_Number == subject.numbers)
    Power.Reflectance <- 1.0 - t[[9]]
    g <- ggplot(subject.numbers)
    g <- g + aes(x=frequencies, y=Power.Reflectance)
    Left_Ear <- t[[4]]
    g <- g + geom_line(aes(color=factor(Left_Ear)))
    g
}
