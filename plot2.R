library(data.table)
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEID <- data.table(NEI)
##filps 24510 is Baltimore
d2 <- NEID[fips=="24510"][, sum(Emissions), by=list(year)]
setnames(d2, "V1", "Total.Emissions")
png("plot2.png", width=480, height=480)
plot(type="b", 
     x=d2$year, y=d2$Total.Emissions, 
     xlab="Years", ylab="Total Emissions", main="Total emissions in Baltimore"
)
dev.off()