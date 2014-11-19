library(data.table)
library(ggplot2)
library(gridExtra)
library(scales)
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEID <- data.table(NEI)
##Assumption is made that all motor vehicles are on-road vehicles (as defined in Sector60 class.). 
##This is based on Table3 in http://www.epa.gov/ttn/chief/net/2008report.pdf
##filps 24510 is Baltimore, 06037 is Los Angeles County
codes <- SCC$SCC[grepl("On-Road", SCC$EI.Sector, fixed="TRUE")]
d6 <- NEID[SCC %in% codes][fips=="24510" | fips=="06037"][, sum(Emissions), by=list(year, fips)]
d6$fips <- sub("24510", "Baltimore", d6$fips)
d6$fips <- sub("06037", "Los Angeles County", d6$fips)
setnames(d6, "V1", "Total.Emissions")
setnames(d6, "fips", "Region")
png("plot6.png", width=480, height=480)
p1 <- ggplot(data=d6, aes(x=year,y=Total.Emissions, colour=Region)) + geom_line(aes(group=Region)) + geom_point() +
    ggtitle('Motor vehicle related emissions')
p2 <- ggplot(data=d6, aes(x=year,y=Total.Emissions, colour=Region)) + geom_line(aes(group=Region)) + geom_point() +
    ggtitle('Motor vehicle related emissions (log scale)') + scale_y_continuous(trans=log10_trans())
grid.arrange(p1, p2, ncol=1)
dev.off()