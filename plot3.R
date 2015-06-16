# Load supplied data
classCodes <- readRDS("Source_Classification_Code.rds")
emissionsData <- readRDS("summarySCC_PM25.rds")

## 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##    which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
##    Which have seen increases in emissions from 1999–2008? 
##    Use the ggplot2 plotting system to make a plot answer this question.

library("dplyr")
library("ggplot2")

## Use dplyr to filter for Baltimore and group by (type and year) and summarise.
graphData <- emissionsData %>% 
             filter(fips == "24510") %>% 
             group_by(type, year) %>% 
             summarise(total = sum(Emissions))

png("plot3.png")

# Use ggplot2 to create graph with a facet_wrap for multiple types
qplot(year, total, data = graphData, geom = c("point", "smooth")) +
    facet_wrap(~ type) + 
    labs(title="PM2.5 Emissions in Baltimore City", y="Total Emissions", x="Years")

dev.off()