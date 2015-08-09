###################################################
#               Plot 1                            #
###################################################

# Read the data into the RAM
file = "household_power_consumption.txt"
data = read.table(file, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

# Extract only the data we need (this was the trickiest part of this assignment, who could have known that "01/02/2007" wouldn't work, duh...)
subdata = data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# remove variables
rm(data,file)

# Convert the column we're going to work with into numeric type:
subdata$Global_active_power = as.numeric(subdata$Global_active_power)

# First build the plot and proudly observe it:
#par(bg="transparent") #I know how to make the background transparend, but in Windows 10 viewer it look just awfully
par(cex.lab = 0.8, cex.main = 1.1, cex.axis = 0.8)
par(mar = c(5, 5, 4, 2)) # Just to make sure the word Frequency is not cut by the left border
hist(subdata$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")


# Write to png
dev.copy(png, file ="plot1.png", width=504, height=504)
hist(subdata$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off() 

#Return to normal
par(bg="white")
par(cex.lab = 1)