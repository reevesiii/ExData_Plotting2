# Load supplied data
classCodes <- readRDS("Source_Classification_Code.rds")
emissionsData <- readRDS("summarySCC_PM25.rds")

## 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library("dplyr")
library("ggplot2")

## Use dplyr to filter with grep for (combustion and coal)
combustionData <- classCodes %>% 
                  filter(grepl("combustion", SCC.Level.One, ignore.case=TRUE) 
                    | grepl("coal", SCC.Level.Three, ignore.case=TRUE)) %>% 
                  select(SCC) 

## Use dplyr join the filtered types to the emissions data set
joinData <- inner_join(combustionData, emissionsData, by="SCC")

## Use dplyr to group by and summarise.
graphData <- joinData %>% 
             group_by(year) %>% 
             summarise(total = sum(Emissions))

png("plot4.png")

# Use ggplot2 to create graph with with both points and lines
qplot(year, total, data = graphData, geom = c("point", "smooth")) +
    labs(title="PM2.5 Emissions from Coal Combustion-Related Sources", y="Total Emissions", x="Years")

dev.off()