#Libraries 

library(tidyverse)
library(lubridate)

#Read Data 
pw<- read_delim("exdata_data_household_power_consumption/household_power_consumption.txt",
                delim = ";")

##Tidy Dataset
#Clean up dates 
pw$Date<- dmy(pw$Date)

#Subset data to include only 2007-02-01 and 2007-02-02
pw_sub<- pw %>% filter(Date=="2007-02-01"|Date=="2007-02-02")

#Create Date_Time Column
pw_sub$Date_Time<- parse_date_time(paste(pw_sub$Date,pw_sub$Time),"Ymd HMS")

#Plot 4 has four different graphs in a 2x2 pattern 
#Top Left: Plot 2
#Top Right: Voltage over Date time with xlab datetime
#Bottom Left: Plot 3
#Bottom Right: Global Reactive Power over Date time with xlab datetime

png(file="plot4.png",width=480, height=480)

par(mfrow=c(2,2))
#Top Left Plot 2  
with(pw_sub,plot(Date_Time, Global_active_power, type = "l", xlab="", 
                 ylab="Global Active Power"))

#Top Right 
with(pw_sub, plot(Date_Time, Voltage, type = "l", xlab="datetime"))

#Bottom Left Plot 3 
with(pw_sub,plot(Date_Time, Sub_metering_1 , type = "l", xlab="",ylab="Energy sub metering"))
lines(pw_sub$Date_Time, pw_sub$Sub_metering_2, col="red")
lines(pw_sub$Date_Time, pw_sub$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                  col= c("black","red","blue"), lty=1)

#Bottom Right 
with(pw_sub, plot(Date_Time, Global_reactive_power, type = "l", xlab="datetime"))

dev.off()
