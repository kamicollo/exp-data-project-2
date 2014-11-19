library(data.table)
library(ggplot2)
library(gridExtra)
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEID <- data.table(NEI)
##Assumption is made that all motor vehicles are on-road vehicles (as defined in Sector60 class.). 
##This is based on Table3 in http://www.epa.gov/ttn/chief/net/2008report.pdf
##filps 24510 is Baltimore
codes <- SCC$SCC[grepl("On-Road", SCC$EI.Sector, fixed="TRUE")]
d5 <- NEID[SCC %in% codes][fips=="24510"][, sum(Emissions), by=list(year)]
setnames(d5, "V1", "Total.Emissions")
png("plot5.png", width=480, height=480)
ggplot(data=d5, aes(x=year,y=Total.Emissions)) + geom_line() + geom_point() +
    ggtitle('Motor vehicle related emissions in Baltimore')
dev.off()