## Set working directory and read in NEI and SCC data
setwd("~/Desktop/exdata-data-NEI_data")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## Use grep function to subet SCC data set to include only motor vehicles 
## emissions sources
SCC_vehicles <- SCC[grepl("vehicle", SCC$EI.Sector, ignore.case=TRUE),]

## Subset NEI data to create a data frame including observations from Baltimore only
Baltimore <- NEI[which(NEI$fips == "24510"),]

## Subset Baltimore-only data frame using SCC codes that correspond to motor 
## vehicle emissions sources
Baltimore_vehicles <- subset(Baltimore, SCC %in% SCC_vehicles$SCC)

## Use the aggregate function to create a new data frame from Baltimore_vehicles that 
## sums motor vehicle emissions in Baltimore for 1999, 2002, 2005, and 2008
Baltimore_vehicle_emissions <- aggregate(Baltimore_vehicles$Emissions ~ Baltimore_vehicles$year, data=Baltimore_vehicles, sum)

## Subset NEI data to create a data frame including observations from Los Angeles only
LA <- NEI[which(NEI$fips == "06037"),]

## Subset Los Angeles-only data frame using SCC codes that correspond to motor 
## vehicle emissions sources
LA_vehicles <- subset(LA, SCC %in% SCC_vehicles$SCC)

## Use the aggregate function to create a new data frame from LA_vehicles that sums 
## vehicle emissions in Los Angeles for 1999, 2002, 2005, and 2008
LA_vehicle_emissions <- aggregate(LA_vehicles$Emissions ~ LA_vehicles$year, data=LA_vehicles, sum)

## Create a vectors from both the LA and Baltimore subets that include total motor 
## vehicle emissions for each city in each year in 1999, 2002, 2005, and 2008
LA_emissions <- LA_vehicle_emissions[,2]
Baltimore_emissions <-  Baltimore_vehicle_emissions[,2]

## Install quantmod package
install.packages("quantmod")
library(quantmod)

## Call Delt function on both the LA_emissions and Baltimore_emssions vectors to
## determine the percent change in emissions between years. Save the results 
## as new vectors, x and y.
x <- Delt(LA_emissions)
y <- Delt(Baltimore_emissions)

## Create a new vector of years. Then bind this "Year" vector to the x and y vectors
## into a new data frame. Replace NA observations in this data frame with 0s.
Year <- c(1999,2002,2005,2008)
Baltimore_LA <- data.frame(cbind(Year,x,y))
Baltimore_LA[is.na(Baltimore_LA)] <- 0

## Create a plot using R's base plotting library that measures the percent change 
## of PMS25  emissions from motor vehicles in Baltimore and Los Angeles between 
## 1999 and 2008. Save this plot in my working directory as a .png file.
png("plot6.png", width=575, height=575)
plot(Baltimore_LA$Year, Baltimore_LA$Delt.1.arithmetic, ylim=c(-.7,.3),
     xlab="Year", ylab="Percent Change in Motor Vehicle Emissions",
     main="Percent Change in Los Angeles and Baltimore Motor Vehicle Emissions,
     1999 to 2008", yaxt="n")
lines(Baltimore_LA$Year, Baltimore_LA$Delt.1.arithmetic, lty=3)
lines(Baltimore_LA$Year, Baltimore_LA$Delt.1.arithmetic.1, lty=5)
points(Baltimore_LA$Year, Baltimore_LA$Delt.1.arithmetic.1)
axis(2, at=seq(-0.6,0.2,0.2), labels=paste(seq(-60,20,20), "%", sep=""), 
     hadj=.8, las=1)
text(c(2003,2004),c(.13,-.37), labels = c("Los Angeles", "Baltimore"))
legend("topright", legend = c("Los Angeles", "Baltimore"), 
       lty=c(3,5))
abline(h=0, col="red")
dev.off()







LAAutoEmissions <- LA[which(LA$type == "ON-ROAD"),]

LAA99 <- LAAutoEmissions[which(LAAutoEmissions$year == 1999),]
LAAsum99 <- sum(LAA99$Emissions)

LAA02 <- LAAutoEmissions[which(LAAutoEmissions$year == 2002),]
LAAsum02 <- sum(LAA02$Emissions)

LAA05 <- LAAutoEmissions[which(LAAutoEmissions$year == 2005),]
LAAsum05 <- sum(LAA05$Emissions)

LAA08 <- LAAutoEmissions[which(LAAutoEmissions$year == 2008),]
LAAsum08 <- sum(LAA08$Emissions)

LAAutos <- c(LAAsum99, LAAsum02, LAAsum05, LAAsum08)
Year <- c(1999, 2002, 2005, 2008)

plot(Year, LAAutos)
lines(Year, LAAutos)