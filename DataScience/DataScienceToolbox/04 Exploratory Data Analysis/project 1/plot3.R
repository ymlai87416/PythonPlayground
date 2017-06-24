data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)

startDate <- strptime('2007-02-01 00:00:00', '%Y-%m-%d %H:%M:%S')
endDate <- strptime('2007-02-02 23:59:59', '%Y-%m-%d %H:%M:%S')
data$FullTime <- paste(data$Date, data$Time)

data$FullTime <- strptime(as.character(data$FullTime), format="%d/%m/%Y %H:%M:%S")

data <- data[data$FullTime>=startDate & data$FullTime<=endDate, ]

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

png(file="plot3.png", width=480, height=480)
plot(x=data$FullTime, y=data$Sub_metering_1, type="l",
     ylab = "Energy sub metering",
     xlab = "", col="black"
)
lines( data$FullTime, data$Sub_metering_2,col=2)
lines( data$FullTime, data$Sub_metering_3,col=4)
legend("topright", col=c("black", "red", "blue"), legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"), lty=c(1,1), lwd=c(2.5,2.5,2.5))
dev.off()