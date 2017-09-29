# Assignment 1
# plot3
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
## open PNG device, create 'plot3.png' of specified dimensions in wd 
png(filename = "plot3.png", width = 480, height = 480, units = "px")
## construct the initial plot using the option type = "n" to draw everything 
## in the plot except data points inside the plot window; use data from
## variable Sub_metering_1 as it has the largest range of values
with(data, plot(dateTime, Sub_metering_1,
                xlab = "", ylab = "Energy sub metering", type = "n"))
## graph data on same plot using annotation function points() and send to a file
with(data, points(dateTime, Sub_metering_1, type = "l", col = "black"))
with(data, points(dateTime, Sub_metering_2, type = "l", col = "red"))
with(data, points(dateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## close the PNG file device
dev.off()

