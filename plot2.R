#Line Plot

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

png("plot2.png", width = 480, height = 480, units = "px")

plot(HPC_days$Date_Time,HPC_days$Global_active_power,
     type = "l", 
     lty = 1, 
     xlab = NA, 
     ylab = "Global Active Power (kilowatts)")

dev.off()