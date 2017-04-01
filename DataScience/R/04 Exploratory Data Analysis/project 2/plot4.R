data1 <- readRDS("Source_Classification_Code.rds")
data2 <- readRDS("summarySCC_PM25.rds")
coalSource <- data1[grep("coal", ignore.case=TRUE, data1$Short.Name), ]
data3 <- data2[data2$SCC %in% coalSource$SCC, ]
data4 <- aggregate(data3$Emission ~ data3$year, FUN=sum)
names(data4) <- c("year", "emission")
plot(data4$year, data4$emission, type='l', xlab="Year", ylab="Total PM2.5 emission", main="Total PM2.5 emission from coal")