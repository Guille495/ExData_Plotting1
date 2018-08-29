# COURSERA: EXPLORATORY DATA ANALYSIS, week 1 Course Project 1
#---------------------------------------------------------------
# Create directory (if non-existent)
# Download zip file
# Unzip file in desired directory 

if(!file.exists("ExploratoryDataAnalysis")) {
        dir.create("ExploratoryDataAnalysis")
}

if(!file.exists("./ExploratoryDataAnalysis/HouseholdPowerConsumption.zip")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, destfile = "./ExploratoryDataAnalysis/HouseholdPowerConsumption.zip")        
}

unzip("./ExploratoryDataAnalysis/HouseholdPowerConsumption.zip", exdir = "./ExploratoryDataAnalysis")

#-----------------------------------------------------------------------------------
# Extract rows related to dates 01/Feb/2007 - 02/Feb/2007 (i.e. 2880 records):

HouseholdPowerConsumption <- read.csv("./ExploratoryDataAnalysis/household_power_consumption.txt", sep = ";", na.strings = "?", header = F, skip = 66637, nrows = 2880)

# Extract only column names from datafile (i.e. 1st row only), rename columns:

ColumnNames <- read.csv("./ExploratoryDataAnalysis/household_power_consumption.txt", sep = ";", nrows = 1, as.is = T, header = F, colClasses = "character")
colnames(HouseholdPowerConsumption) <- ColumnNames

# Change the $Date and $Time (char) variables into a single POSIXlt class DateTime variable:

HouseholdPowerConsumption$Date <- paste(HouseholdPowerConsumption$Date, HouseholdPowerConsumption$Time, sep=", ")       # paste 'Date' and 'Time' columns together
library(dplyr)  # Loading dplyr for easier manipulation (i.e. function 'rename()')
HouseholdPowerConsumption <- rename(HouseholdPowerConsumption, DateTime = Date)
HouseholdPowerConsumption$DateTime <- strptime(HouseholdPowerConsumption$DateTime, format = "%d/%m/%Y, %H:%M:%S")       # Changing 'DateTime' from char to POSIXlt
HouseholdPowerConsumption$Time <- NULL   # Dropping the 'Time' variable, as it is now incorporated into 'DateTime'
#--------------------------------------------------------------
#--------------------------------------------------------------
# Plot1 creation:

png(filename = "plot1.png", width = 480, height = 480)  # Call graphics device to create a png file in my current working directory
plot1 <- hist(HouseholdPowerConsumption$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

#--------------------------------------------------------------
# SCRIPT END
#--------------------------------------------------------------