plot4 <- function() {
  
  ## Plot 4 for Exploritory Data Analysis Project 1
  
  ## Uses the Electric power consumption dataset from UCI Machine Learning
  
  ## Measurements of electric power consumption in one household with 
  ## a one-minute sampling rate over a period of almost 4 years. Different 
  ## electrical quantities and some sub-metering values are available.
  
  library(sqldf)
  
  dir.create("./data/", showWarnings = FALSE)
  
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  destination <- "./data/epc.zip"
  if (!file.exists(destination)) {
    download.file(url, destination)
  }
  message("File downloaded")
  
  data <- read.csv.sql(unzip(destination), sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header = TRUE, sep = ";")
  
  data <- cbind(paste(data$Date, data$Time), data)
  names(data) <- c("Datetime", names(data)[2:10])
  data$Datetime <- strptime(data$Datetime, format = "%d/%m/%Y %H:%M:%S")
  
  png(file = "./plot4.png", width = 480, height = 480) ## open PNG device
  par(mfcol = c(2, 2))
  with(data, {
    plot(Datetime, Global_active_power, type = "l",
         ylab = "Global Acitve Power",
         xlab = "")
    plot(Datetime, Sub_metering_1, type = "l",
         ylab = "Energy sub metering",
         xlab = "")
      lines(Datetime, Sub_metering_2, col="red")
      lines(Datetime, Sub_metering_3, col="blue")
      legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Datetime, Voltage, type = "l",
         ylab = "Voltage",
         xlab = "datetime")
    plot(Datetime, Global_reactive_power, type = "l",
         ylab = "Global_reactive_power",
         xlab = "datetime")
  })
  dev.off()
  
  message("PNG file created")
  
}