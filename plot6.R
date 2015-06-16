# Load supplied data
classCodes <- readRDS("Source_Classification_Code.rds")
emissionsData <- readRDS("summarySCC_PM25.rds")

## 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from 
##    motor vehicle sources in Los Angeles County, California (fips == "06037"). 
##    Which city has seen greater changes over time in motor vehicle emissions?

library("dplyr")
library("ggplot2")

## Use dplyr to filter with grep for vehicles
vehiclesData <- classCodes %>% 
                filter(grepl("vehicles", SCC.Level.Two, ignore.case=TRUE)) %>% 
                select(SCC) 

## Use dplyr to filter for Baltimore City and Los Angeles and then add a city column
emissionsDataFiltered <- emissionsData %>% 
                         filter(fips == "24510" | fips == "06037") %>% 
                         mutate(city = ifelse(fips == "24510", "Baltimore", "Los Angeles"))

## Use dplyr join the filtered types to the vehicles data set
joinData <- inner_join(vehiclesData, emissionsDataFiltered, by="SCC")

## Use dplyr to group by and summarise.
graphData <- joinData %>% 
             group_by(year, city) %>% 
             summarise(total = sum(Emissions))

png("plot6.png")

# Use ggplot2 to create graph with with both points and lines
qplot(year, total, data = graphData, color = city, geom = c("point", "smooth")) +
      labs(title="PM2.5 Emissions from Vehicle Sources (Baltimore City vs LA)", y="Total Emissions", x="Years")

dev.off()