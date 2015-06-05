library(lubridate)
library(dplyr)

## Read the data needed for the plots from the file
## Uses only the lines that are needed for the project
data <- read.table(file = "household_power_consumption.txt"
           ,header = FALSE, sep = ";", na.strings = "?"
           ,nrows = 2880, skip = 66637, colClasses = "character")

## Reads the colnames into a data frame with 1 row
names <- read.table(file = "household_power_consumption.txt"
                   , header = TRUE, sep = ";", nrows = 1)

## Sets the colnames for the data object from names
colnames(data) <- colnames(names)

## Removes the names object
rm(names)

## Change Date column to POSIXct
data$Date <- dmy(data$Date)

## Change Global_active_power column to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

## Create line graph for sub metering 1 through 3
## and send to PNG file
png(filename = "plot3.png") ## Open the PNG file device
datetime <- paste(data$Date, data$Time) %>%
        strptime(format = "%Y-%m-%d %H:%M:%S") ## Join Date and Time and assign to variable
plot(datetime, data$Sub_metering_1, type = "l"
     ,xlab = "", ylab = "Energy sub metering") ## Plot line graph for sub metering 1
lines(datetime, data$Sub_metering_2, type = "l", col = "red") ## Plot line graph for sub metering 2
lines(datetime, data$Sub_metering_3, type = "l", col = "blue") ## Plot line graph for sub metering 3
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , lwd = 1, col = c("black", "red", "blue")) ## Add the legend to the graph
dev.off() ## Close the PNG device