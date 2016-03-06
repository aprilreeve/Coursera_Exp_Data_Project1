## download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file (fileUrl, destfile="power_consumption.zip")
## unzip data file - household_power_consumption.txt
unzip("power_consumption.zip")

## read in data file with numeric columns
consumption <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
## convert Date and Time columns from character to date and time format
power.consumption <- transform(consumption,Date=as.Date(Date, "%d/%m/%Y"), Time=strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"))
## select specific two days of data
power.consumption.data <- subset(power.consumption, Date == "2007-02-01" | Date == "2007-02-02")

## open graphics device - png file
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

## display 4 plots - 2x2
par(mfrow=c(2,2), mar=c(4,4,2,1))

## plot1
## create line plot - structure
plot(power.consumption.data$Time, power.consumption.data$Global_active_power, type="n", xlab="", ylab = "Global Active Power (kilowatts)", main="")
## draw line
lines(power.consumption.data$Time, power.consumption.data$Global_active_power, col="black")

## plot2
## create line plot - structure
plot(power.consumption.data$Time, power.consumption.data$Voltage, type="n", xlab="datetime", ylab = "Voltage", main="")
## draw line
lines(power.consumption.data$Time, power.consumption.data$Voltage, col="black")

## plot3
## create line plot - structure
plot(power.consumption.data$Time, power.consumption.data$Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering", main="")
## draw lines
lines(power.consumption.data$Time, power.consumption.data$Sub_metering_1, col="black")
lines(power.consumption.data$Time, power.consumption.data$Sub_metering_2, col="red")
lines(power.consumption.data$Time, power.consumption.data$Sub_metering_3, col="blue")
## create legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col=c("black", "red","blue"), lty=c(1 ,1, 1))

## plot4
## create line plot - structure
plot(power.consumption.data$Time, power.consumption.data$Global_reactive_power, type="n", xlab="datetime", ylab = "Global_reactive_power", main="")
## draw line
lines(power.consumption.data$Time, power.consumption.data$Global_reactive_power, col="black")

## close graphics device
dev.off()