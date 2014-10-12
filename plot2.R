## Use source("plot2.R") command to run this R script inorder to line graph.

## Precondition: The data file is in your current working directory
## Postcondition: Line graph is created in your working directory

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

## Remove rows with NAs in the Global_active_power column
subpowerdata <- subpowerdata[complete.cases(subpowerdata[,3]),]

## Convert Global_active_power column to numeric
subpowerdata$Global_active_power <- as.numeric(subpowerdata$Global_active_power)

## Add new column as concatenation of Date and Time columns
subpowerdata$datetime = paste(subpowerdata$Date, subpowerdata$Time, sep=" ")
  
## Convert the datetime column into Date/Time format
subpowerdata <- transform(subpowerdata, datetime = strptime(subpowerdata$datetime, "%Y-%m-%d %H:%M:%S"))

## Open PNG graphic device as copying a plot is not an exact operation
## Default values for width and height arguments of png function are both 480, so no need to explicitly set them)
png("plot2.png")

## Create formatted line graph for Global_active_power
plot(x = subpowerdata$datetime, y = subpowerdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Close the PNG graphic device
dev.off()

