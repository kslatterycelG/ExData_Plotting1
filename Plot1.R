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

#Plot 1 is a Red Histogram with the Title "Global Active Power" it appears to have 
# ~11 breaks and an x label of Global Active Power (kilowatts)
png(file="plot1.png",width=480, height=480)

hist(pw_sub$Global_active_power, col="red", main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()
