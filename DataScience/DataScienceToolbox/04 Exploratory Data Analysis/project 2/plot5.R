data1 <- readRDS("Source_Classification_Code.rds")
data2 <- readRDS("summarySCC_PM25.rds")
motorSource <- data1[grep("motor vehicle", ignore.case=TRUE,data1$Short.Name), ]
data3 <- data2[data2$SCC %in% motorSource$SCC, ]
data35 <- data3[data3$fips=="24510", ]
data4 <- aggregate(data35$Emission ~ data35$year, FUN=sum)
names(data4) <- c("year", "emission")
plot(data4$year, data4$emission, type='l', xlab="Year", ylab="Total PM2.5 emission", main="Total PM2.5 emission from motor vehicle")