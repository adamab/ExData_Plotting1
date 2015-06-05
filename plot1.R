library(lubridate)

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

## Create histogram plot for Global Active Power
## and send to PNG file
png(filename = "plot1.png") ## Open the PNG file device
hist(data$Global_active_power, col = "red"
     ,main = "Global Active Power"
     ,xlab = "Global Active Power (kilowatts)") ## Plot the Histogram
dev.off() ## Close the PNG device