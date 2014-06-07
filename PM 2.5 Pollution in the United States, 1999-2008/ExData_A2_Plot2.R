## Set working directory and read in NEI and SCC data 
setwd("~/Desktop/exdata-data-NEI_data")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## Subset NEI data to create a new data frame including observations from Baltimore only
Baltimore <- NEI[which(NEI$fips == "24510"),]

## Use the aggregate function to create a new data frame from Baltimore data farme that 
## sums total emissions for 1999, 2002, 2005, and 2008
BEmissions <- aggregate(Baltimore$Emissions ~ Baltimore$year, data=Baltimore, sum)

## Create a plot using R's base plotting library that measure PM2.5 emissions in Baltimore 
## from 1999 to 2008. Save this plot in my working directory as a .png file.
png("plot2.png", width=575, height=575)
plot(BEmissions[,1], BEmissions[,2], xlab="Year", ylab=expression("Tons of PM"[2.5]), 
     cex.main=2, main=expression(PM[2.5]~"Emissions in Baltimore, 1999-2008"))
lines(BEmissions[,1], BEmissions[,2])
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


