## Set working directory and read in NEI and SCC data
setwd("~/Desktop/exdata-data-NEI_data")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## Use grep function to subet SCC data set to include only coal combustion 
## pollution sources
SCC_coal_comb <- SCC[grepl("coal", SCC$EI.Sector, ignore.case=TRUE),]

## Subset NEI data set using SCC codes that correspond to coal combustion 
NEI_coal_comb <- subset(NEI, SCC %in% SCC_coal_comb$SCC)

## Use the aggregate function to create a new data frame from NE_coal_comb that  
## sums coal combustion emissions for 1999, 2002, 2005, and 2008
CoalEmissions <- aggregate(NEI_coal_comb$Emissions ~ NEI_coal_comb$year, data=NEI_coal_comb, sum)

## Install ggplot2 package
install.packages("ggplot2")
library(ggplot2)

## Create a plot using ggplot2 library that measures PM25 emissions from coal   
## combustion sources from 1999 to 2008. Save this plot in my working directory 
## as a .png file.
png("plot4.png", width=575, height=575)
qplot(CoalEmissions[,1], CoalEmissions[,2], xlab="Year", ylab=expression("Tons of PM"[2.5]), 
      main=expression(PM[2.5]~"Emissions from Coal Combustion in the US, 1999-2008"),
      geom="line") + theme_grey(base_size = 15) + theme(plot.title = element_text(vjust=2))
dev.off()











C99 <- NEI_coal_comb[which(NEI_coal_comb$year == 1999),]
CS99 <- sum(C99$Emissions)
C02 <- NEI_coal_comb[which(NEI_coal_comb$year == 2002),]
CS02 <- sum(C02$Emissions)
C05 <- NEI_coal_comb[which(NEI_coal_comb$year == 2005),]
CS05 <- sum(C05$Emissions)
C08 <- NEI_coal_comb[which(NEI_coal_comb$year == 2008),]
CS08 <- sum(C08$Emissions)
CoalEmissions <- c(CS99, CS02, CS05, CS08)
Year <- c(1999, 2002, 2005, 2008)
png("plot4.png", width=575, height=575)
plot(Year, CoalEmissions, ylab=expression("Tons of PM"[25]), cex.main=1.6,
     main=expression(PM[25]~"Emissions from Coal Combustion in the US, 1999-2008"))
lines(Year, CoalEmissions)
dev.off()


SCC_coal_comb <- SCC[grepl("combustion", SCC$SCC.Level.One, ignore.case=TRUE)
                     & (grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE) | 
                          grepl("lignite", SCC$SCC.Level.Three, ignore.case=TRUE)),]