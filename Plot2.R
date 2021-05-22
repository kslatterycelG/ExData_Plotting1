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

#Plot 2 has Global Active Power (kilowatts) in the y axis. The x axis appears 
#to be time labeled with day of the week.
png(file="plot2.png",width=480, height=480)
with(pw_sub,plot(Date_Time, Global_active_power, type = "l", xlab="", 
                 ylab="Global Active Power (kilowatts)"))
dev.off()
