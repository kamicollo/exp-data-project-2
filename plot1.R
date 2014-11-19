library(data.table)
unzip("exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEID <- data.table(NEI)
d1 <- NEID[, sum(Total=Emissions), by=year]
setnames(d1, "V1", "Total.Emissions")
png("plot1.png", width=480, height=480)
plot(type="l", 
     x=d1$year, y=d1$Total.Emissions, 
     xlab="Years", ylab="Total Emissions", main="Total emissions in the U.S."
)
dev.off()