# Load supplied data
classCodes <- readRDS("Source_Classification_Code.rds")
emissionsData <- readRDS("summarySCC_PM25.rds")

## 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library("dplyr")
library("ggplot2")

## Use dplyr to filter with grep for vehicles
vehiclesData <- classCodes %>% 
                filter(grepl("vehicles", SCC.Level.Two, ignore.case=TRUE)) %>% 
                select(SCC) 

## Use dplyr to filter for Baltimore City
emissionsDataFiltered <- emissionsData %>% 
                         filter(fips == "24510")

## Use dplyr join the filtered types to the vehicles data set
joinData <- inner_join(vehiclesData, emissionsDataFiltered, by="SCC")

## Use dplyr to group by and summarise.
graphData <- joinData %>% 
             group_by(year) %>% 
             summarise(total = sum(Emissions))

png("plot5.png")

# Use ggplot2 to create graph with with both points and lines
qplot(year, total, data = graphData, geom = c("point", "smooth")) +
      labs(title="PM2.5 Emissions from Vehicle Sources in Baltimore City", y="Total Emissions", x="Years")

dev.off()