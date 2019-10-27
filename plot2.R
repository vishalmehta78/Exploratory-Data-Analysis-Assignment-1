if(!require(sqldf)){
  install.packages("sqldf")
}

library(sqldf)

#Load Source Data

srcdata <- read.csv.sql("household_power_consumption.txt", 
                                                 "select Date, Time, Global_active_power
                           from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";")

datetime <- strptime(paste(srcdata$Date, srcdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

srcdata$Global_active_power <- as.character(srcdata$Global_active_power)

# Build Plot to Device

png(filename = "plot2.png")

plot(datetime, srcdata$Global_active_power, type= "l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()


#remove data
remove(srcdata,datetime)