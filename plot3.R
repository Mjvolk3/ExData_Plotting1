#Multi-line Plot

library(dplyr)
library(lubridate)
file_name <- "household_power_consumption.txt"

if (!exists("HPC_data")){       
        HPC_data <- read.table(file_name, 
                               sep = ";",
                               header = TRUE,
                               na.strings = "?"
        )
        
        HPC_Date_time <- mutate(HPC_data, Date_time = dmy_hms(paste(HPC_data$Date, HPC_data$Time)))
        HPC_clean <- HPC_Date_time %>% select(-(1:2))
}

if (!exists("HPC_days")){
        HPC_days <- subset(HPC_clean,
                           date(HPC_clean$Date_time) == "2007-02-01" | date(HPC_clean$Date_time) == "2007-02-02")
}

#Plotting and device creation

png("plot3.png", width = 480, height = 480, units = "px")

plot(HPC_days$Date_Time, type = "n", HPC_days$Sub_metering_1, ylab = "Energy sub metering", xlab = NA)
lines(HPC_days$Date_Time, HPC_days$Sub_metering_1, col = "black", lty = 1)
lines(HPC_days$Date_Time, HPC_days$Sub_metering_2, col = "red", lty = 1)
lines(HPC_days$Date_Time, HPC_days$Sub_metering_3, col = "blue", lty = 1)
legend("topright", lty=rep(1,3),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()