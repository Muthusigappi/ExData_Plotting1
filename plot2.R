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


#plot2
plot(y=data$Global_active_power,x=data$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off() 
