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
#let's get name data header for coal data
head(sccData$Short.Name)


par("mar"=c(5.1, 4.5, 4.1, 2.1))

coal <- grep("coal", sccData$Short.Name, ignore.case = T)
coal <- sccData[coal, ]
coal <- neiData[neiData$SCC %in% coal$SCC, ]

coalEmissions <- aggregate(coal$Emissions, list(coal$year), FUN = "sum")
#plotting onto screen andthen copy to png
plot(coalEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions From Coal Combustion-related\n Sources from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))
dev.copy(png, file="./figure/plot4.png", width = 480, height = 480)
dev.off()
