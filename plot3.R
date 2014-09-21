#load data from a known directory
setwd("~/Downloads/Coursera/EDA/ExData_Plotting2-master/ExData_Plotting2-master/ExData_Plotting2/")
unzip("./data/exdata-data-NEI_data.zip", exdir = "./data/")
# Check if both the data files exist. If not, load them.
if (!"neiData" %in% ls()) {
  neiData <- readRDS("./data/summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
  sccData <- readRDS("./data/Source_Classification_Code.rds")
}


#load data for Baltimore whose fips is 24510

subset <- neiData[neiData$fips == "24510", ] 

##now, lets load ggplot for plotting onto screen and then copy to png file
library(ggplot2)
par("mar"=c(5.1, 4.5, 4.1, 2.1))

g <- ggplot(subset, aes(year, Emissions, color = type))
g + geom_line(stat = "summary", fun.y = "sum") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle("Total Emissions in Baltimore City from 1999 to 2008")
dev.copy(png, file="./figure/plot3.png", width = 480, height = 480)
dev.off()
