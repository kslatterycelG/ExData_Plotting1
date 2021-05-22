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

#Plot 3 has Energy sub metering in the y axis. The x axis appears 
#to be time labeled with day of the week.There is a legend in the top right 
#corner. It is a line graph where each of the three sub metering is a different 
#color. 1 is black, 2 is red and 3 is blue. 

png(file="plot3.png",width=480, height=480)
with(pw_sub,plot(Date_Time, Sub_metering_1 , type = "l", xlab="", 
                 ylab="Energy sub metering"))
with(pw_sub,lines(Date_Time, Sub_metering_2, col="red"))
with(pw_sub,lines(Date_Time, Sub_metering_3, col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col= c("black","red","blue"), lty=1)
dev.off()
