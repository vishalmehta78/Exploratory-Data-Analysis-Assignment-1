# check sqldf is installed if not then install

if(!require("sqldf", character.only = TRUE))
{
  install.packages("sqldf")
}

library(sqldf)

#load data from source file

srcdata <- read.csv.sql("household_power_consumption.txt", 
                        "select Global_active_power
                          from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";")

#plot graph to device

png(filename = "plot1.png",width=480,height=480)
with(srcdata,hist(Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatt)", ylab="Frequency",col="red"))

dev.off()

#remove dataset

remove(srcdata)