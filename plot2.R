# Load supplied data
classCodes <- readRDS("Source_Classification_Code.rds")
emissionsData <- readRDS("summarySCC_PM25.rds")

## 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
##    Use the base plotting system to make a plot answering this question.

library("dplyr")

## Use dplyr to filter for Baltimore and group by and summarise.
graphData <- emissionsData %>% 
             filter(fips == "24510") %>% 
             group_by(year) %>% 
             summarise(total = sum(Emissions))

png("plot2.png")

plot(graphData$year, 
     graphData$total,
     type="l",
     main="PM2.5 Emissions in Baltimore City",
     xlab="Year",
     ylab="Total Emissions")

dev.off()