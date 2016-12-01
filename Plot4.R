# Plot 3 GAP - Global Active Power

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

#plot the 4 types of graphs
par(mfrow=c(2,2))
#graph 1
plot(gap$timestamp,gap$Global_active_power, type= "l", xlab= "", ylab= "Global Active Power(kilowatts)")

#graph 2
plot(gap$timestamp,gap$Voltage, type= "l", xlab= "Voltage", ylab= "Datetime")

#graph 3

plot(gap$timestamp,gap$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(gap$timestamp,gap$Sub_metering_2,col="red")
lines(gap$timestamp,gap$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

#graph 4
plot(gap$timestamp,gap$Global_reactive_power, type= "l", xlab="Datetime" , ylab= "Global Reactive Power")
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()

