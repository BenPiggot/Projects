## Set working directory and read in the NEI and SCC data sets.
setwd("~/Desktop/exdata-data-NEI_data")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## Subset the NEI dataset by year and then sum the emissions total for each yearly subset.
## I chose this more extensive subsetting method because the aggregate function struggled to 
## deal with a data set as large as the NEI data set on my computer.
Y99 <- NEI[which(NEI$year == 1999),]
sum99 <- sum(Y99$Emissions)
Y02 <- NEI[which(NEI$year == 2002),]
sum02 <- sum(Y02$Emissions)
Y05 <- NEI[which(NEI$year == 2005),]
sum05 <- sum(Y05$Emissions)
Y08 <- NEI[which(NEI$year == 2008),]
sum08 <- sum(Y08$Emissions)

## Create a vectors of the total emissions sums for each yearly subset and of years.
Emissions <- c(sum99, sum02, sum05, sum08)
Year <- c(1999,2002,2005,2008)

## Create a plot using R's base plotting library that measure PM2.5 emissions in the
## United States from 1999 to 2008. Save this plot in my working directory as a .png file.
png("plot1.png", width=550, height=550)
plot(Year, Emissions, ylab=expression("Tons of PM"[2.5]), cex.main=1.6,
     main=expression(PM[2.5]~"Emissions in the United States, 1999-2008 (in tons)"))
lines(Year, Emissions)
options(scipen=999)
dev.off()

