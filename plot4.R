## Use source("plot4.R") command to run this R script inorder to create multi-plots graph.

## Precondition: The data file is in your current working directory
## Postcondition: Multi-plots graph is created in your working directory

## Read the data from text file to a data frame
powerdata <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)

## Convert the Date column from character to Date format
powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")

## Keep rows corresponding to dates 01/02/2007 and 02/02/2007
date1 <- as.Date("01/02/2007", "%d/%m/%Y")
date2 <- as.Date("02/02/2007", "%d/%m/%Y")
subpowerdata <- powerdata[((powerdata$Date == date1)|(powerdata$Date == date2)),]

## Convert missing values for Global_active_power, Global_reactive_power, Voltage and Sub_metering columns from ? to NA
subpowerdata$Global_active_power[subpowerdata$Global_active_power == "?" ] <- NA
subpowerdata$Global_reactive_power[subpowerdata$Global_reactive_power == "?" ] <- NA
subpowerdata$Voltage[subpowerdata$Voltage == "?" ] <- NA
subpowerdata$Sub_metering_1[subpowerdata$Sub_metering_1 == "?" ] <- NA
subpowerdata$Sub_metering_2[subpowerdata$Sub_metering_2 == "?" ] <- NA
subpowerdata$Sub_metering_3[subpowerdata$Sub_metering_3 == "?" ] <- NA

## Remove rows with NAs in Global_active_power, Global_reactive_power, Voltage and Sub_metering columns
subpowerdata <- subpowerdata[complete.cases(subpowerdata[,3]),]
subpowerdata <- subpowerdata[complete.cases(subpowerdata[,4]),]
subpowerdata <- subpowerdata[complete.cases(subpowerdata[,5]),]
subpowerdata <- subpowerdata[complete.cases(subpowerdata[,7]),]
subpowerdata <- subpowerdata[complete.cases(subpowerdata[,8]),]
subpowerdata <- subpowerdata[complete.cases(subpowerdata[,9]),]

## Convert Global_active_power, Global_reactive_power, Voltage and Sub_metering columns to numeric
subpowerdata$Global_active_power <- as.numeric(subpowerdata$Global_active_power)
subpowerdata$Global_reactive_power <- as.numeric(subpowerdata$Global_reactive_power)
subpowerdata$Voltage <- as.numeric(subpowerdata$Voltage)
subpowerdata$Sub_metering_1 <- as.numeric(subpowerdata$Sub_metering_1)
subpowerdata$Sub_metering_2 <- as.numeric(subpowerdata$Sub_metering_2)
subpowerdata$Sub_metering_3 <- as.numeric(subpowerdata$Sub_metering_3)

## Add new column as concatenation of Date and Time columns
subpowerdata$datetime = paste(subpowerdata$Date, subpowerdata$Time, sep=" ")
  
## Convert the datetime column into Date/Time format
subpowerdata <- transform(subpowerdata, datetime = strptime(subpowerdata$datetime, "%Y-%m-%d %H:%M:%S"))

## Open PNG graphic device as copying a plot is not an exact operation
## Default values for width and height arguments of png function are both 480, so no need to explicitly set them)
png("plot4.png")

## Layout for multi-plots graphs (2 rows x 2 columns) with default margins
par(mfrow = c(2,2))

## Set up axes labels
xlabels <- c("", "datetime", "", "datetime")
ylabels <- c("Global Active Power", "Voltage", "Energy sub metering", "Global_reactive_power")

## Create formatted graphs
colnums <- c(3,5,7,4)
for(i in 1:4){
   plot(x = subpowerdata[,10], y = subpowerdata[,colnums[i]], type = "l", main = "", xlab = xlabels[i], ylab = ylabels[i])
   if (i == 3){
	lines(x = subpowerdata[,10], y = subpowerdata[,colnums[i]+1], col = "red", type = "l")
	lines(x = subpowerdata[,10], y = subpowerdata[,colnums[i]+2], col = "blue", type = "l")
	legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")
   }
}

## Close the PNG graphic device
dev.off()

