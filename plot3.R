library(lubridate)
Sys.setlocale("LC_TIME", "C") #otherwise we'll see the weekdays in Ukrainian 
#according to my locale

#reading the data and subsetting two dates: 2007-02-01 and 2007-02-02
df <- read.table('household_power_consumption.txt',
                 sep = ';', 
                 header = TRUE, 
                 stringsAsFactors=FALSE)
my_data <- subset(df, Date == '1/2/2007' | Date == '2/2/2007')
my_data$Date <- dmy(my_data$Date)
my_data$Time <- hms(my_data$Time)

#pre-processing of the data
my_data$Sub_metering_1 <- as.numeric(my_data$Sub_metering_1)
my_data$Sub_metering_2 <- as.numeric(my_data$Sub_metering_2)
my_data$DateTime <- my_data$Date + my_data$Time

#plotting a chart and saving it as a png file
png(filename = 'plot3.png', width = 480, height = 480)
with(my_data, plot(DateTime,
                   Sub_metering_1,
                   xlab = '',
                   ylab = 'Energy sub metering',
                   type = 'n',
))
lines(my_data$DateTime, my_data$Sub_metering_1)
lines(my_data$DateTime, my_data$Sub_metering_2, col = 'red')
lines(my_data$DateTime, my_data$Sub_metering_3, col = 'blue')
legend('topright', col = c('black', 'red', 'blue'),
       legend = c('Sub_metering_1',
                  'Sub_metering_2', 
                  'Sub_metering_3'),
       lty=1)

dev.off()
