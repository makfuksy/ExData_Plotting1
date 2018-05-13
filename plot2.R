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
loadedData0 <- loadedData0[which(as.Date(loadedData0$Date, format="%d/%m/%Y") >= "2007-02-01" 
                                & as.Date(loadedData0$Date, format="%d/%m/%Y") <= "2007-02-02"),c(1:3)]
#omit NAs rows
loadedData <- na.omit(loadedData0)
# Convert Date column to date type
loadedData$DateTime <- as.POSIXct(paste(loadedData$Date, loadedData$Time), format="%d/%m/%Y %H:%M:%S")

#Convert Global_active_power column to numeric
loadedData$Global_active_power <- as.numeric(loadedData$Global_active_power)

loadedData <- loadedData[,c(3,4)]

png("plot2.png", width=480, height=480)

## Process plot2
plot(x= loadedData$DateTime, y=loadedData$Global_active_power,
     xlab="",ylab="Global Active Power (kilowatts)", type = "l")
dev.off()
rm(loadedData0)