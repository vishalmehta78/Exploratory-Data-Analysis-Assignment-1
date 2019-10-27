if(!require(sqldf)){
  install.packages("sqldf")
}

library(sqldf)

#Load Source Data

srcdata <- read.csv.sql("household_power_consumption.txt", 
                                                 "select Date, Time, Sub_metering_1,
                                                          Sub_metering_2,
                                                          Sub_metering_3
                                                  from file 
                        where Date = '1/2/2007' or Date = '2/2/2007'", sep=";")

datetime <- strptime(paste(srcdata$Date, srcdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# Build Plot to Device

png(filename = "plot3.png")

plot(datetime, srcdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering",col="green",ylim=c(0,40))
par(new=TRUE)

plot(datetime, srcdata$Sub_metering_2, type="l", xlab="", ylab="",col="red",ylim=c(0,40))
par(new=TRUE)

plot(datetime, srcdata$Sub_metering_3, type="l", xlab="", ylab="",col="blue",ylim=c(0,40))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("green","red","blue"))

dev.off()

#remove data
remove(srcdata,datetime)