###################################################
#               Plot 3                            #
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

plot3 = function() {
        #par(bg="transparent") #I know how to make the background transparend, but in Windows 10 viewer it look just awfully
        par(cex.lab = 0.8, cex.axis = 0.8)
        plot(subdata$DateTime, subdata$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
        lines(subdata$DateTime, subdata$Sub_metering_2, type="l", col="red")
        lines(subdata$DateTime, subdata$Sub_metering_3, type="l", col="blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=3, col=c("black", "red", "blue"))
        par(bg="white")
        par(cex.lab = 1, cex.axis=1)
}

# Plot the data and check it looks as expected
plot3()

# Write the picture to png
dev.copy(png, file ="plot3.png", width=504, height=504)
plot3()
dev.off()