###############################################
# Nethika Suraweera
# Coursera: Exploratory Data Analysis
# Course Project
# 07/23/2017
# plot 3
###############################################

#rm(list = ls())

####### Download data #######
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile='data') 
unzip ("data", exdir = "./")

#Load data
power_consmptn <- read.table("household_power_consumption.txt",header = T, sep=";")

#Preprocess data
power_consmptn$Date <- as.Date(power_consmptn$Date, format="%d/%m/%Y")
d_frame <- power_consmptn[(power_consmptn$Date=="2007-02-01") | (power_consmptn$Date=="2007-02-02"),]
d_frame$Global_active_power <- as.numeric(as.character(d_frame$Global_active_power))
d_frame$Global_reactive_power <- as.numeric(as.character(d_frame$Global_reactive_power))
d_frame$Voltage <- as.numeric(as.character(d_frame$Voltage))
d_frame <- transform(d_frame, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
d_frame$Sub_metering_1 <- as.numeric(as.character(d_frame$Sub_metering_1))
d_frame$Sub_metering_2 <- as.numeric(as.character(d_frame$Sub_metering_2))
d_frame$Sub_metering_3 <- as.numeric(as.character(d_frame$Sub_metering_3))

### Create Plot 3 ######
with(d_frame,plot(timestamp,Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(d_frame$timestamp,d_frame$Sub_metering_2,col="red")
lines(d_frame$timestamp,d_frame$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
print("plot3.png is created")