library(data.table)
library(lubridate)
library(dplyr)

#reading data
dataEn<-fread("../household_power_consumption.txt")

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
tdd1<-ymd("2007-02-01")
tdd2<-ymd("2007-02-02")
dp<-filter(dataEn, (dmy(dataEn$Date)==tdd1)|(dmy(dataEn$Date)==tdd2))
dp[,3:8] <-sapply(dp[,3:8], as.numeric)
#write.table(dp, "dataForPlotting.txt", row.name=FALSE)
rm(dataEn)

#dp<-fread("dataForPlotting.txt")
#  plotting
png(file="plot1.png", width = 480, height = 480)
hist(dp$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()

