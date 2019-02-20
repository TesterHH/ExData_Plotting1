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
dp<-mutate(dp, DatTim=as.POSIXct(strptime(paste(dp$Date, dp$Time), "%d/%m/%Y %H:%M:%S" )))

#  plotting
png(file="plot2.png", width = 480, height = 480)
plot(dp$DatTim, dp$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.off()