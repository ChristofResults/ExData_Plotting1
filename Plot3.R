## R script for project assignment of course 4 - Exploratory Data Analysis - Module 1
## -----------
## PLOT 3
## -----------
## date: 2023-03-06
## author: Christof
## version: 1.0
## status: final
## change history: 
## 1.0 Initial version

## purpose of this script: read data, prepare data, generate 1 plot
## requirements: 
## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
## File name: plot<N>.png with N =1 to 4
## 1 R Code file for each plot: including data reading
## R Code file name: plot<N>.R with N =1 to 4

## plots
## 3. xyplot with timeseries data, x = no label, values Thu, Fri, Sat, y = "Energy sub metering" - 0-30 w incr 10
## 3 series w #1 black line, #2 red line, #3 blue line, no title, legend: top right corner, with colored lines, bold text

## packages
library(ggplot2)
library(lattice)
#library(naniar)
library(dplyr)

## settings
work_dir <- getwd() # setworking directory
source_dir <- paste(work_dir, "/Data/", sep = "") # dir for raw source data
output_dir <- paste(work_dir, "/Plots/", sep = "") # dir for plots

## read data & subset data & prepare the data
      # raw data
      raw_data <- read.csv(paste(source_dir, "household_power_consumption.txt", sep = ""), sep = ";")
      # create date / time column
      raw_data <- mutate(raw_data, date_time = paste(raw_data$Date, raw_data$Time, sep = " "))
      raw_data$date_time <- strptime(raw_data$date_time, "%d/%m/%Y %H:%M:%S")
      # transform raw_data for selection - Date column to Date format - source format DD/MM/YYYY
      raw_data$Date <- as.Date(raw_data$Date, "%d/%m/%Y")
      # select date range needed: 2007-02-01 or 2007-02-02
      data <- subset(raw_data, (raw_data$Date == "2007-02-01" | raw_data$Date == "2007-02-02"))
      # remove raw_data
      rm(raw_data)
      # transformations from char to time or numeric
      data$Global_active_power <- as.numeric(data$Global_active_power) # char to numeric
      
## create plot #2
      # initialize plot
      plotfile = paste(output_dir, "plot3.png", sep = "")
      png(filename = plotfile, width = 480, height = 480, units = "px") # explicitly setting the defaults
     
      # 3 series = start plot without datapoints and build up the 3 sets
      # Sub_metering_1 as Y axis for initial plot because this series has the highest values
      plot(data$date_time, data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "") 
      lines(data$date_time, data$Sub_metering_1, col ="black")
      lines(data$date_time, data$Sub_metering_2, col ="red")
      lines(data$date_time, data$Sub_metering_3, col ="blue")
      
      # legend, with lines (=> lty = 1), with bold text (=> text.font = 2)
      legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), text.font=2)
      
      # close plot
      dev.off()
      
      



