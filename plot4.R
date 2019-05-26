#download and unzip file
if (!file.exists("./data.zip"))
{
  download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", destfile="./data.zip")
}
unzip ("data.zip")

#read data
data_full <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
data <- data_full[(data_full$Date=="1/2/2007" | data_full$Date=="2/2/2007" ), ]


#format date and time
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
dateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(dateTime, format = "%Y-%m-%d %H:%M:%S")


# create panel of graphs

par(mfrow = c(2, 2))
with(data, {
  plot(x = data$DateTime, y = data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(x = data$DateTime, y = data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(x = data$DateTime, y = data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(x = data$DateTime, y = data$Sub_metering_2, type = "l", col = "red")
  lines(x = data$DateTime, y = data$Sub_metering_3, type = "l", col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(x = data$DateTime, y = data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.copy(png,file = "plot4.png")
dev.off()