data1 <- readRDS("Source_Classification_Code.rds")
data2 <- readRDS("summarySCC_PM25.rds")
data3 <- data2[data2$fips=="24510", ]
data4 <- aggregate(data3$Emission ~ data3$year+data3$type, FUN=sum)
names(data4) <- c("year", "type", "emission")
data4$type <- factor(data4$type)
library(ggplot2)
gph <- qplot(year, emission, data=data4, color=type, geom="line", main="PM2.5 Emission across years from 4 sources")
gph
 
