###################################################
#               Plot 4                            #
###################################################
# Read the data into the RAM
file = "household_power_consumption.txt"
data = read.table(file, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

# Extract only the data we need
subdata = data[data$Date %in% c("1/2/2007","2/2/2007") ,]
rm(data,file)

# Parse the data with strptime (I really hate this one, I tried to use as.Date, then combine, then... well, took me hours, really)
subdata$DateTime = strptime(paste(subdata$Date, subdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
# remove the columns we don't need 
subdata$Date = NULL
subdata$Time = NULL
#Convert all the necessary columns into numeric type
subdata$Global_active_power = as.numeric(subdata$Global_active_power)
subdata$Sub_metering_1 = as.numeric(subdata$Sub_metering_1)
subdata$Sub_metering_2 = as.numeric(subdata$Sub_metering_2)
subdata$Sub_metering_3 = as.numeric(subdata$Sub_metering_3)
subdata$Voltage = as.numeric(subdata$Voltage)
subdata$Global_reactive_power = as.numeric(subdata$Global_reactive_power)


plot4 = function() {        
        # tune the layout
        par(mfrow = c(2, 2)) 
        #par(bg="transparent") #I know how to make the background transparend, but in Windows 10 viewer it look just awfully
        par(cex.lab = 0.8, cex.axis = 0.8)        
        #Plot active power against time
        plot(subdata$DateTime, subdata$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        #Plot voltage against time
        plot(subdata$DateTime, subdata$Voltage, type="l", xlab="datetime", ylab="Voltage")
        #Plot submetering1 against time and tune it to death
        plot(subdata$DateTime, subdata$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
        lines(subdata$DateTime, subdata$Sub_metering_2, type="l", col="red")
        lines(subdata$DateTime, subdata$Sub_metering_3, type="l", col="blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=3, col=c("black", "red", "blue"), cex=0.8, bty="n")
        # Plot reactive power against time
        plot(subdata$DateTime, subdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        # Set the default layout back
        par(mfrow = c(1,1))
        par(bg="white")
        par(cex.lab = 1, cex.axis=1)
}
# Plot the data and see how cool we are
plot4()

# Write the picture to png
#par(bg="transparent") #I know how to make the background transparend, but in Windows 10 viewer it look just awfully
dev.copy(png, file ="plot4.png", width=504, height=504)
plot4()
dev.off()
