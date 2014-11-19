library(data.table)
library(ggplot2)
library(gridExtra)
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEID <- data.table(NEI)
##Assumption is made that all Fuel Combustion sectors that mention Coal should capture all 
## coal-combustion sources. This is based on Table3 in http://www.epa.gov/ttn/chief/net/2008report.pdf
codes <- SCC$SCC[
    grepl("Fuel Comb", SCC$EI.Sector, fixed="TRUE") & 
    grepl("Coal", SCC$EI.Sector, fixed="TRUE")
]
d4 <- NEID[SCC %in% codes][, sum(Emissions), by=list(year)]
setnames(d4, "V1", "Total.Emissions")
png("plot4.png", width=480, height=480)
ggplot(data=d4, aes(x=year,y=Total.Emissions)) + geom_line() + geom_point() +
    ggtitle('Coal combustion related emissions')
dev.off()