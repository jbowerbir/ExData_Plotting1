# Assignment 1
# plot2
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
          

# Covert variables to approriate classes and create needed variables
## check current variables classes
sapply(data, class)
## generate variable with date and time combined
data$dateTime <- strptime( 
  paste( as.character(data$Date), as.character(data$Time) ), 
  format = "%Y-%m-%d %H:%M:%S")


# Generate and save plot:
## open PNG device, create 'plot2.png' of specified dimensions in wd 
png(filename = "plot2.png", width = 480, height = 480, units = "px")
## create histogram and send to a file (no plot appears on screen)
with(data, plot(dateTime, Global_active_power, type = "l", 
                xlab = "", ylab = "Global Active Power (kilowats)"))
## close the PNG file device
dev.off()


