#download file from web
fileurl <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
download.file(fileurl, destfile =  "power_consumption.zip")

# memory required = no. of column * no. of rows * 8 bytes
# rows= 2,075,259 and columns = 9 -> ca. 149 MB of RAM memory required to read the entire file 
# NB : if you want to run the code, please place in the same directory with the UNZIPPED .txt"
# read file into R but only rows of interset (ie, referring to 1st and 2nd Feb 2007 data), set NA ="?"
library(dplyr)
data <- read.table("household_power_consumption.txt", header = F, sep = ";", quote = "", na.strings="?", nrows = 2880, skip = 66637)
variable_names <- c("Date", 
                    "Time", 
                    "Global_active_power", 
                    "Global_reactive_power", 
                    "Voltage", 
                    "Global_intensity", 
                    "Sub_metering_1",
                    "Sub_metering_2",
                    "Sub_metering_3")
names(data) = variable_names
dates <- (data$Date)
times <- (data$Time)
datetimes = paste(dates, times)
datetimes <- strptime(datetimes, "%d/%m/%Y %H:%M:%S") # collapse date & time into a single datetime variable
data1 <- cbind(datetimes, data) # NB days names on graphs are expressed in italian!!
data2 <- select(data1, -Date, - Time) # drop non-relevant variables

rm("data", "data1") # remove data tables from memory

# create plot 1

hist(data2$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png",width = 480, height = 480, units = "px")
dev.off()
