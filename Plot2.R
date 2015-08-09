###################################################
#               Plot 2                            #
###################################################

# Read the data into the RAM
file = "household_power_consumption.txt"
data = read.table(file, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

# Extract only the data we need
subdata = data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# remove variables that we don't need anymore
rm(data,file)

# Parse the data with strptime (I really hate this one, I tried to use as.Date, then combine, then... well, took me hours, really)
subdata$DateTime = strptime(paste(subdata$Date, subdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
# remove the columns we don't need 
subdata$Date = NULL
subdata$Time = NULL
subdata$Global_active_power = as.numeric(subdata$Global_active_power)

# Plot this pretty thing, appreciate it
#par(bg="transparent") #I know how to make the background transparend, but in Windows 10 viewer it look just awfully
par(cex.lab = 0.8, cex.axis = 0.8)
plot(subdata$DateTime, subdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", lwd=1)

# Then save to png
dev.copy(png, file ="plot2.png", width=504, height=504)
plot(subdata$DateTime, subdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

par(bg="white")
par(cex.lab = 1, cex.axis=1)