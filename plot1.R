# Load supplied data
classCodes <- readRDS("Source_Classification_Code.rds")
emissionsData <- readRDS("summarySCC_PM25.rds")

## 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
##    Using the base plotting system, make a plot showing the total PM2.5 emission from 
##    all sources for each of the years 1999, 2002, 2005, and 2008.

library("dplyr")

## Use dplyr to group by and summarise.
graphData <- emissionsData %>% 
             group_by(year) %>% 
             summarise(total = sum(Emissions))

png("plot1.png")

plot(graphData$year, 
     graphData$total,
     type="l",
     main="PM2.5 Emissions",
     xlab="Year",
     ylab="Total Emissions")

dev.off()