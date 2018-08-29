# COURSERA: EXPLORATORY DATA ANALYSIS, week 1 Course Project 1
#---------------------------------------------------------------
# Create directory (if non-existent)
# Download zip file
# Unzip file in desired directory 

if(!file.exists("ExploratoryDataAnalysis")) {
        dir.create("ExploratoryDataAnalysis")
}

setwd("./ExploratoryDataAnalysis")

if(!file.exists("HouseholdPowerConsumption.zip")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, destfile = "HouseholdPowerConsumption.zip")        
}

unzip("HouseholdPowerConsumption.zip")

#-----------------------------------------------------------------------------------
# Extract rows related to dates 01/Feb/2007 - 02/Feb/2007 (i.e. 2880 records):

HouseholdPowerConsumption <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", header = F, skip = 66637, nrows = 2880)

# Extract only column names from datafile (i.e. 1st row only), rename columns:

ColumnNames <- read.csv("household_power_consumption.txt", sep = ";", nrows = 1, as.is = T, header = F, colClasses = "character")
colnames(HouseholdPowerConsumption) <- ColumnNames

# Change the $Date and $Time (char) variables into a single POSIXlt class DateTime variable:

HouseholdPowerConsumption$Date <- paste(HouseholdPowerConsumption$Date, HouseholdPowerConsumption$Time, sep=", ")       # paste 'Date' and 'Time' columns together
library(dplyr)  # Loading dplyr for easier manipulation (i.e. function 'rename()')
HouseholdPowerConsumption <- rename(HouseholdPowerConsumption, DateTime = Date)
HouseholdPowerConsumption$DateTime <- strptime(HouseholdPowerConsumption$DateTime, format = "%d/%m/%Y, %H:%M:%S")       # Changing 'DateTime' from char to POSIXlt
HouseholdPowerConsumption$Time <- NULL   # Dropping the 'Time' variable, as it is now incorporated into 'DateTime'
#--------------------------------------------------------------
#--------------------------------------------------------------
# Create plot3
png(filename = "plot3.png", width = 480, height = 480)
with(HouseholdPowerConsumption, { 
        plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_3, col = "blue")
})
legend("topright", lty = "solid", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

# Move working directory one level up (i.e. out of the 'Exploratory Data Analysis' directory)
setwd("..")

#--------------------------------------------------------------
# SCRIPT END
#--------------------------------------------------------------
