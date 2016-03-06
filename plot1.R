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

## remove NA data for plot
#clean.power.consumption.data <- subset(power.consumption.data, Global_active_power != NA)

## open graphics device - png file
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
## create histogram
hist(power.consumption.data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
## close graphics device
dev.off()
