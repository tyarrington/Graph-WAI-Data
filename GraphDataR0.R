# Make sure the data file is in the same directory as
# your current working directory

t <- read.csv("./Shahnaz_Measurements.csv")
              
t$Power.Reflectance <- 1.0 - t$Absorbance 
              
JustPlotIt <- function() {
    require(ggplot2)
    index <- readline("Enter Subject Number: ")
    g <- ggplot(subset(t, Subject.Number == index))
    g <- g + aes(x=Frequency, y=Power.Reflectance)
    g <- g + geom_line(aes(color=factor(Ear.Location)))
    g
}
