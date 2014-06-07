## Set working directory and read in NEI and SCC data 
setwd("~/Desktop/exdata-data-NEI_data")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## Subset NEI data to create a new data frame including observations from Baltimore only
Baltimore <- NEI[which(NEI$fips == "24510"),]

## Rename columns for year, type, and Emissions from the new Baltimore-only data frame
year <- Baltimore$year
type <- Baltimore$type
Emissions <- Baltimore$Emissions

## Use the aggregate function to create a new data frame from Baltimore data frame that  
## sums total emissions for 1999, 2002, 2005, and 2008
BaltimoreSum <- aggregate(Emissions ~ year + type, data=Baltimore, FUN =sum)

## Install ggplot2 package
install.packages("ggplot2")
library(ggplot2)

## Create a plot using ggplot2 library that measures total PM2.5 emissions in Baltimore
## from 1999 to 2008 by type (using facets). Save this plot in my working directory 
## as a .png file.
png("plot3.png", width=800, height=400)
qplot(year, Emissions, data=BaltimoreSum, facets = .~type, geom="line",
      main=expression(PM[2.5]~"Emissions in Baltimore by Source Type, 1999-2008"),
      xlab="Year", ylab=expression("Tons of PM"[2.5])) + theme_grey(base_size = 16)
dev.off()





B99 <- Baltimore[which(Baltimore$year == 1999),]
Bsum99 <- sum(B99$Emissions)

B02 <- Baltimore[which(Baltimore$year == 2002),]
Bsum02 <- sum(B02$Emissions)

B05 <- Baltimore[which(Baltimore$year == 2005),]
Bsum05 <- sum(B05$Emissions)

B08 <- Baltimore[which(Baltimore$year == 2008),]
Bsum08 <- sum(B08$Emissions)

BEmissions <- c(Bsum99, Bsum02, Bsum05, Bsum08)
Year <- c(1999,2002,2005,2008)

install.packages("ggplot2")
library(ggplot2)
