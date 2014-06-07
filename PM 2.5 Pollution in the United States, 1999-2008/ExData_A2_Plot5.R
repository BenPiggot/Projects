## Set working directory and read in NEI and SCC data
setwd("~/Desktop/exdata-data-NEI_data")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## Subset NEI data to create a data frame including observations from Baltimore only
Baltimore <- NEI[which(NEI$fips == "24510"),]

## Use grep function to subet SCC data set to include only motor vehicle emissions sources
SCC_vehicles <- SCC[grepl("vehicle", SCC$EI.Sector, ignore.case=TRUE),]

## Subset Baltimore-only data frame using SCC codes that correspond to motor vehicle 
## emissions sources
Baltimore_vehicles <- subset(Baltimore, SCC %in% SCC_vehicles$SCC)

## Use the aggregate function to create a new data frame from Baltimore_vehicles that 
## sums motor vehicle emissions for 1999, 2002, 2005, and 2008
Baltimore_vehicle_emissions <- aggregate(Baltimore_vehicles$Emissions ~ Baltimore_vehicles$year, data=Baltimore_vehicles, sum)

## Install ggplot2 library
install.packages("ggplot2")
library(ggplot2)

## Create a plot using ggplot2 library that measures PM25 total emissions from motor 
## vehicle sources in Baltimore from 1999 to 2008. Save this plot in my working  
##directory as a .png file.
png("plot5.png", width=575, height=575)
qplot(Baltimore_vehicle_emissions[,1], Baltimore_vehicle_emissions[,2], xlab="Year", 
      ylab=expression("Tons of PM"[2.5]), 
      main=expression(PM[2.5]~"Emissions from Motor Vehicles in Baltimore, 1999-2008"),
      geom="line") + theme_grey(base_size = 15) + theme(plot.title = element_text(vjust=2))
dev.off()

















A99 <- AutoEmissions[which(AutoEmissions$year == 1999),]
Asum99 <- sum(A99$Emissions)

A02 <- AutoEmissions[which(AutoEmissions$year == 2002),]
Asum02 <- sum(A02$Emissions)

A05 <- AutoEmissions[which(AutoEmissions$year == 2005),]
Asum05 <- sum(A05$Emissions)

A08 <- AutoEmissions[which(AutoEmissions$year == 2008),]
Asum08 <- sum(A08$Emissions)

Autos <- c(Asum99, Asum02, Asum05, Asum08)
Year <- c(1999, 2002, 2005, 2008)

plot(Year, Autos)
