library(data.table)
library(ggplot2)
library(gridExtra)
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEID <- data.table(NEI)
##filps 24510 is Baltimore
d3 <- NEID[fips=="24510"][, sum(Emissions), by=list(year,type)]
setnames(d3, "V1", "Total.Emissions")
png("plot3.png", width=480, height=480)
ggplot(data=d3, aes(x=year,y=Total.Emissions)) + geom_line() + geom_point() +
    facet_wrap(~type) +
    ggtitle('Baltimore emissions by type')
dev.off()