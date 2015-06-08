plot2 <- function() {
  
  ## Plot 2 for Exploritory Data Analysis Project 1
  
  ## Uses the Electric power consumption dataset from UCI Machine Learning
  
  ## Measurements of electric power consumption in one household with 
  ## a one-minute sampling rate over a period of almost 4 years. Different 
  ## electrical quantities and some sub-metering values are available.
  
  library(sqldf)
  
  ## Create a directory for the download
  dir.create("./data/", showWarnings = FALSE)
  
  ## Set data file variables
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  destination <- "./data/epc.zip"
  
  ## If the file has already been downloaded, skip the download
  if (!file.exists(destination)) {
    download.file(url, destination)
    message("File downloaded")
  }
  message("File already downloaded")
  
  ## Use sql to read in only the data for the choosen dates
  data <- read.csv.sql(unzip(destination), 
      sql = "select * from file where Date in ('1/2/2007','2/2/2007')", 
      header = TRUE, sep = ";")
  
  ## Combine Date and Time into a single column and change to Date class
  data <- cbind(paste(data$Date, data$Time), data)
  names(data) <- c("Datetime", names(data)[2:10])
  data$Datetime <- strptime(data$Datetime, format = "%d/%m/%Y %H:%M:%S")
  
  ## Create a 480 x 480 PNG file with the requested plot
  png(file = "./plot2.png", width = 480, height = 480) ## open PNG device
  with(data, plot(Datetime, Global_active_power, type = "l",
                  ylab = "Global Acitve Power (kilowatts)",
                  xlab = ""))
  dev.off() ## Don't forget to close the device
  
  message("PNG file created")
  
}