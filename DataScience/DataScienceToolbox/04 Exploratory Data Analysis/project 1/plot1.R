data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

startDate <- as.Date('2007-02-01', '%Y-%m-%d')
endDate <- as.Date('2007-02-02', '%Y-%m-%d')

data$Date <- as.Date(data$Date, "%d/%m/%Y")

data <- data[data$Date>=startDate & data$Date<=endDate, ]

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

png(file="plot1.png", width=480, height=480)
hist(data$Global_active_power, 
     main="Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col="red"
)
dev.off()