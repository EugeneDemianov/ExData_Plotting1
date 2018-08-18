
library(lubridate)

#reading the data and subsetting two dates: 2007-02-01 and 2007-02-02
df <- read.table('household_power_consumption.txt',
                 sep = ';', 
                 header = TRUE, 
                 stringsAsFactors=FALSE)
my_data <- subset(df, Date == '1/2/2007' | Date == '2/2/2007')
my_data$Date <- dmy(my_data$Date)
my_data$Time <- hms(my_data$Time)

#plotting a chart
my_data$Global_active_power <- as.numeric(my_data$Global_active_power)
with(my_data, hist(Global_active_power, 
                   col = 'red', 
                   xlab = 'Global Active Power (kilowatts)',
                   main = 'Global Active Power'))

#saving as a png file
dev.copy(png, file = 'plot1.png', width = 480, height = 480)
dev.off()
