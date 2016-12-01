# Plot 1 GAP - Global Active Power

# read file
file1 <- read.table("household_power_consumption.txt", header=T, sep=";")
file1$Date <- as.Date(file1$Date, format="%d/%m/%Y")
# retrieve data for Feb 1st and 2nd of 2007

gap <- file1[(file1$Date=="2007-02-01") | (file1$Date=="2007-02-02"),]

#convert factors, characters to numeric
gap$Global_active_power <- as.numeric(as.character(gap$Global_active_power))

gap$Global_reactive_power <- as.numeric(as.character(gap$Global_reactive_power))
gap$Voltage <- as.numeric(as.character(gap$Voltage))
gap <- transform(gap, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
gap$Sub_metering_1 <- as.numeric(as.character(gap$Sub_metering_1))
gap$Sub_metering_2 <- as.numeric(as.character(gap$Sub_metering_2))
gap$Sub_metering_3 <- as.numeric(as.character(gap$Sub_metering_3))

# plot the histogram
hist(gap$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()