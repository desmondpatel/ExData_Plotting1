## Use source("plot1.R") command to run this R script inorder to create histogram.

## Precondition: The data file is in your current working directory
## Postcondition: Histogram is created in your working directory

## Read the data from text file to a data frame
powerdata <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)

## Convert the Date column from character to Date format
powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")

## Keep rows corresponding to dates 01/02/2007 and 02/02/2007
date1 <- as.Date("01/02/2007", "%d/%m/%Y")
date2 <- as.Date("02/02/2007", "%d/%m/%Y")
subpowerdata <- powerdata[((powerdata$Date == date1)|(powerdata$Date == date2)),]

## Convert missing values for Global_active_power column from ? to NA
subpowerdata$Global_active_power[subpowerdata$Global_active_power == "?" ] <- NA

## Convert Global_active_power column to numeric
subpowerdata$Global_active_power <- as.numeric(subpowerdata$Global_active_power)

## Note: All columns from 3 to 9 could have been made numeric as shown below using for loop if we need to draw all graphs in one go
## for (i in 3:9) {
##	subpowerdata[,i][subpowerdata[,i] == "?" ] <- NA
##	subpowerdata[,i] <- as.numeric(subpowerdata[,i])
## }

## Open PNG graphic device because copying a plot is not an exact operation
## Default values for width and height arguments of png function are both 480 pixels; so no need to explicitly set them
png("plot1.png")

## Create formatted histogram for Global_active_power
hist(subpowerdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

## Close the PNG graphic device
dev.off()

