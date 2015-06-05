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

## Create line graph for Global Active Power over time
## and send to PNG file
png(filename = "plot2.png") ## Open the PNG file device
paste(data$Date, data$Time) %>% ## Pipe combined date and time to formatting
        strptime(format = "%Y-%m-%d %H:%M:%S") %>% ## Pipe format to plot
        plot(data$Global_active_power, type = "l"
             ,xlab = "", ylab = "Global Active Power (kilowatts)") ## Plot line graph
dev.off() ## Close the PNG device