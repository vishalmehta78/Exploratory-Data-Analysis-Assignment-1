if(!require(sqldf)){
  install.packages("sqldf")
}

library(sqldf)

#Load Source Data

srcdata <- read.csv.sql("household_power_consumption.txt", 
                                                 "select *
                                                  from file 
                        where Date = '1/2/2007' or Date = '2/2/2007'", sep=";")

datetime <- strptime(paste(srcdata$Date, srcdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

srcdata$Global_active_power <- as.character(srcdata$Global_active_power)
srcdata$Voltage <- as.numeric(srcdata$Voltage)
srcdata$Global_reactive_power <- as.numeric(as.character(srcdata$Global_reactive_power))

# Build Plot to Device

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))
plot(datetime, srcdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot(datetime, srcdata$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, srcdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering",col="green",ylim=c(0,40))
par(new=TRUE)

plot(datetime, srcdata$Sub_metering_2, type="l", xlab="", ylab="",col="red",ylim=c(0,40))
par(new=TRUE)

plot(datetime, srcdata$Sub_metering_3, type="l", xlab="", ylab="",col="blue",ylim=c(0,40))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("green","red","blue"),cex=0.5)

plot(datetime, srcdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()

#remove data
remove(srcdata,datetime)