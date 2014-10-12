## Use source("plot3.R") command to run this R script inorder to create multi-line graph.

## Precondition: The data file is in your current working directory
## Postcondition: Multi-line graph is created in your working directory

## Read the data from text file to a data frame
powerdata <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)

## Convert the Date column from character to Date format
powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")

## Keep rows corresponding to dates 01/02/2007 and 02/02/2007
date1 <- as.Date("01/02/2007", "%d/%m/%Y")
date2 <- as.Date("02/02/2007", "%d/%m/%Y")
subpowerdata <- powerdata[((powerdata$Date == date1)|(powerdata$Date == date2)),]

## Convert missing values for Sub_metering columns from ? to NA
subpowerdata$Sub_metering_1[subpowerdata$Sub_metering_1 == "?" ] <- NA
subpowerdata$Sub_metering_2[subpowerdata$Sub_metering_2 == "?" ] <- NA
subpowerdata$Sub_metering_3[subpowerdata$Sub_metering_3 == "?" ] <- NA

## Remove rows with NAs in Sub_metering columns
subpowerdata <- subpowerdata[complete.cases(subpowerdata[,7]),]
subpowerdata <- subpowerdata[complete.cases(subpowerdata[,8]),]
subpowerdata <- subpowerdata[complete.cases(subpowerdata[,9]),]

## Convert Sub_metering columns to numeric
subpowerdata$Sub_metering_1 <- as.numeric(subpowerdata$Sub_metering_1)
subpowerdata$Sub_metering_2 <- as.numeric(subpowerdata$Sub_metering_2)
subpowerdata$Sub_metering_3 <- as.numeric(subpowerdata$Sub_metering_3)

## Add new column as concatenation of Date and Time columns
subpowerdata$datetime = paste(subpowerdata$Date, subpowerdata$Time, sep = " ")
  
## Convert the datetime column into Date/Time format
subpowerdata <- transform(subpowerdata, datetime = strptime(subpowerdata$datetime, "%Y-%m-%d %H:%M:%S"))

## Open PNG graphic device because copying a plot is not an exact operation
## Default values for width and height arguments of png function are both 480 pixels; so no need to explicitly set them
png("plot3.png")

## Create formatted line graph for Sub_metering_1
plot(x = subpowerdata$datetime, y = subpowerdata$Sub_metering_1, type = "l", main = "", xlab = "", ylab = "Energy sub metering")

## Add formatted line graph for Sub_metering_2
lines(x = subpowerdata$datetime, y = subpowerdata$Sub_metering_2, col = "red", type = "l")

## Add formatted line graph for Sub_metering_3
lines(x = subpowerdata$datetime, y = subpowerdata$Sub_metering_3, col = "blue", type = "l")

## Add a formatted legend
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

## Close the PNG graphic device
dev.off()

