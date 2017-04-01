data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

startDate <- strptime('2007-02-01 00:00:00', '%Y-%m-%d %H:%M:%S')
endDate <- strptime('2007-02-02 23:59:59', '%Y-%m-%d %H:%M:%S')
data$FullTime <- paste(data$Date, data$Time)

data$FullTime <- strptime(as.character(data$FullTime), format="%d/%m/%Y %H:%M:%S")

data <- data[data$FullTime>=startDate & data$FullTime<=endDate, ]

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

png(file="plot2.png", width=480, height=480)
plot(x=data$FullTime, y=data$Global_active_power, type="l",
     ylab = "Global Active Power (kilowatts)",
     xlab = ""
)
dev.off()