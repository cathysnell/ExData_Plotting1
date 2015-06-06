plot1 <- function() {

## Plot 1 for Exploritory Data Analysis Project 1

## Uses the Electric power consumption dataset from UCI Machine Learning
  
## Measurements of electric power consumption in one household with 
## a one-minute sampling rate over a period of almost 4 years. Different 
## electrical quantities and some sub-metering values are available.

## install.packages("utils")
## install.packages("sqldf")
library(sqldf)

dir.create("./data/", showWarnings = FALSE)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "./data/epc.zip"
if (!file.exists(destination)) {
  download.file(url, destination)
}
message("File downloaded")

data <- read.csv.sql(unzip(destination), sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header = TRUE, sep = ";")

## message(head(data))

png(file = "./plot1.png", width = 480, height = 480) ## open PNG device
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Acitve Power (kilowatts)", col="red")
dev.off()

message("PNG file created")

}