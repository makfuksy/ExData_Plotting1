#Download dataset and unzip it
myCurrentWD <- getwd()
if (!file.exists(file.path(myCurrentWD, "/household_power_consumption.txt"))) {
  dataseturl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(dataseturl, file.path(myCurrentWD, "household_power_consumption.zip"))
  unzip(zipfile = "household_power_consumption.zip")
}

## Load dataset
loadedData0 <- read.table(file = file.path(myCurrentWD, "/household_power_consumption.txt"), 
                         na.strings = "?", sep = ";", header = TRUE)

# Filter observation between 2007-02-01 and 2007-02-02
loadedData <- loadedData0[which(as.Date(loadedData0$Date, format="%d/%m/%Y") >= "2007-02-01" 
                                & as.Date(loadedData0$Date, format="%d/%m/%Y") <= "2007-02-02"),]
#omit NAs rows
loadedData <- na.omit(loadedData)
# Convert Date and time columns to datetime type
loadedData$DateTime <- as.POSIXct(paste(loadedData$Date, loadedData$Time), format="%d/%m/%Y %H:%M:%S")

#Convert Global_active_power column to numeric
loadedData$Global_active_power <- as.numeric(loadedData$Global_active_power)

png("plot3.png", width=480, height=480)

## Process plot3
plot(x= loadedData$DateTime, y=loadedData$Sub_metering_1, xlab="", ylab="Energy sub metering", type = "l")
lines(x= loadedData$DateTime, y=loadedData$Sub_metering_2, col="red")
lines(x= loadedData$DateTime, y=loadedData$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1 ","Sub_metering_2 ", "Sub_metering_3 ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
rm(loadedData0)