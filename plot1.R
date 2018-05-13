
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

# Convert Date column to date type
loadedData0$Date <- as.Date(loadedData0$Date, format="%d/%m/%Y")

# Filter observation between 2007-02-01 and 2007-02-02
loadedData <- loadedData0[which(loadedData0$Date >= "2007-02-01" & loadedData0$Date <= "2007-02-02"),c(1,3)]
#Convert Global_active_power column to numeric
loadedData$Global_active_power <- as.numeric(loadedData$Global_active_power)
#Ignore NAs rows
loadedData = na.omit(loadedData)

png("plot1.png", width=480, height=480)
## Plot 1
hist(loadedData$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
rm(loadedData0)