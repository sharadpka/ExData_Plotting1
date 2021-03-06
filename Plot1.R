##Reads and loads the file to a table
dataFile <- "household_power_consumption.txt"
power <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

##Reads and processes the variables
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
reqpower <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
reqpower$Global_active_power <- as.numeric(as.character(reqpower$Global_active_power))
reqpower$Global_reactive_power <- as.numeric(as.character(reqpower$Global_reactive_power))
reqpower$Voltage <- as.numeric(as.character(reqpower$Voltage))
reqpower <- transform(reqpower, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
reqpower$Sub_metering_1 <- as.numeric(as.character(reqpower$Sub_metering_1))
reqpower$Sub_metering_2 <- as.numeric(as.character(reqpower$Sub_metering_2))
reqpower$Sub_metering_3 <- as.numeric(as.character(reqpower$Sub_metering_3))

##Plot 1
#Creates a histogram of global active power data and saves it to a png file
plot1 <- function() {
  hist(reqpower$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)", ylim = c(0,1200),las=1)
  png("plot1.png", width=480, height=480)
}
plot1()