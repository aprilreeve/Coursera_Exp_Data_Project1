## download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file (fileUrl, destfile="power_consumption.zip")
## unzip data file - household_power_consumption.txt
unzip("power_consumption.zip")

## clean data file
## read in data file with numeric columns
consumption <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
## convert Date and Time columns from character to date and time format
power.consumption <- transform(consumption,Date=as.Date(Date, "%d/%m/%Y"), Time=strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"))
## add Day of the week column
power.consumption$day <- factor(weekdays(power.consumption$Date))
## select specific two days of data
power.consumption.data <- subset(power.consumption, Date == "2007-02-01" | Date == "2007-02-02")

## open graphics device - png file
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
## create line plot - structure
plot(power.consumption.data$Time, power.consumption.data$Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering", main="")
## draw lines
lines(power.consumption.data$Time, power.consumption.data$Sub_metering_1, col="black")
lines(power.consumption.data$Time, power.consumption.data$Sub_metering_2, col="red")
lines(power.consumption.data$Time, power.consumption.data$Sub_metering_3, col="blue")
## create legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col=c("black", "red","blue"), lty=c(1 ,1, 1))
## close graphics device
dev.off()