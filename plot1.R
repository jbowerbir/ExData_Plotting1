# Assignment 1
# plot1
## NOTE: Data file household_power_consumption.txt needs to be in your wd

library(data.table)


# Read data into R and convert '?'s to NAs:
dataFull <- read.table("household_power_consumption.txt",
                       sep = ";", header = TRUE, na.strings = "?")


# Subset data to include only relavent dates (2007-02-01 and 2007-02-02):
## convert date variable from character to date class
dataFull$Date <- as.Date(dataFull$Date, format = "%d/%m/%Y")
## specify dates desired in working dataset
startDate <- as.Date("01/02/2007", format = "%d/%m/%Y")
endDate <- as.Date("02/02/2007", format = "%d/%m/%Y")
## subset data to desired dates
data <- dataFull[ which( dataFull$Date == startDate |
                           dataFull$Date == endDate ), ]
          

# Covert variables to approriate classes:
## check current variables classes
sapply(data, class)
## all variables save time are appropriate
data$Time <- strptime(data$Time, format = "%H:%M:%S")



# Generate and save histogram:
## open PNG device, create 'plot1.png' of specified dimensions in wd 
png(filename = "plot1.png", width = 480, height = 480, units = "px")
## create histogram and send to a file (no plot appears on screen)
hist(as.numeric(data$Global_active_power), col="red", breaks = 15,
     xlab = "Global Active Power (kilowats)", main = "Global Active Power")
## close the PNG file device
dev.off()


