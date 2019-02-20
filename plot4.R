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
png(file="plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
with(dp, { plot(dp$DatTim, dp$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
           plot(dp$DatTim, dp$Voltage, xlab="datatime", ylab="Voltage", type="l")
           plot(dp$DatTim, dp$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
                lines(dp$DatTim, dp$Sub_metering_2, col="red")
                lines(dp$DatTim, dp$Sub_metering_3, col="blue")
              legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")
           plot(dp$DatTim, dp$Global_reactive_power, xlab="datatime", ylab="Global_reactive_power", type="l")
   })
dev.off()