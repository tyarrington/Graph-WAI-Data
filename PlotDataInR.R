# ---
# title: "Access WAI database using R (Voss PI)"
# author: "Nicholas Horton (nhorton@amherst.edu)"
# date: "October 2, 2016"
# ---
  
# This loads the mosaic and dplyr packages
require(mosaic)

# This changes the default colors in lattice plots.
trellis.par.set(theme=theme.mosaic())  

# knitr settings to control how R chunks work.
require(knitr)
opts_chunk$set(
  tidy=FALSE,     # display code as typed
  size="small"    # slightly smaller font for code
)

# Load additional packages here.  Uncomment the line below to use Project MOSAIC data sets.
# require(mosaicData)   
library(mosaic)
library(RMySQL)
db <- src_mysql(dbname = "wai", host = "scidb.smith.edu", user = "waiuser", 
                password="smith_waiDB")
Measurements <- tbl(db, "Measurements")
PI_Info <- tbl(db, "PI_Info")
Subject <- tbl(db, "Subject")

#### Let's explore the `PI_Info` table.
PI_Info %>% collect() %>% data.frame()


#### Let's explore the `Subjects` table.
Subject %>% collect() %>% data.frame() %>% head()

#### Let's explore the `Measurements` table.
Measurements %>% summarise(total = n())

#### Let's download the data from a given subject
onesubj <- 
  Measurements %>% 
  filter(Identifier=="Abur_2014", Sub_Number==1) %>%
  collect %>%
  mutate(SessionNum = as.factor(Session))
onesubj <- onesubj %>%
  mutate(EarStatus = ifelse(Left_Ear==1, "Left", "Right"))
head(onesubj)

#### and plot the results
xyplot(Absorbance ~ Freq | Session, group=EarStatus, auto.key=TRUE,
       scales=list(x=list(log=TRUE)), data=onesubj)
