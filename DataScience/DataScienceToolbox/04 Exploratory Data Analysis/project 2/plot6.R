data1 <- readRDS("Source_Classification_Code.rds")
data2 <- readRDS("summarySCC_PM25.rds")
motorSource <- data1[grep("motor vehicle", ignore.case=TRUE,data1$Short.Name), ]
data3 <- data2[data2$SCC %in% motorSource$SCC, ]
data35 <- data3[data3$fips=="24510" | data3$fips=="06037", ]
data4 <- aggregate(data35$Emission ~ data35$year+data35$fips, FUN=sum)
names(data4) <- c("year", "fips", "emission")
data4$fips[data4$fips=="06037"] <- "Los Angeles County"
data4$fips[data4$fips=="24510"] <- "Baltimore City"
library(ggplot2)
gph <- qplot(year, emission, data=data4, color=fips, geom="line", main="PM2.5 Emission from Motor Vehicle")
gph