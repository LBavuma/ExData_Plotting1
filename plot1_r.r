# plot1.R
# This script creates Plot 1: Histogram of Global Active Power

# Check if data file exists
if (!file.exists("household_power_consumption.txt")) {
    stop("Data file not found! Please run download_data.R first or ensure the file is in your working directory.")
}

# Read the data
print("Reading data file...")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   na.strings = "?", stringsAsFactors = FALSE)
print(paste("Data loaded successfully! Rows:", nrow(data), "Columns:", ncol(data)))

# Convert Date column to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset data for dates 2007-02-01 and 2007-02-02
subset_data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"), ]

# Create PNG device
png("plot1.png", width = 480, height = 480)

# Create histogram
hist(subset_data$Global_active_power, 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red",
     breaks = 12)

# Close device
dev.off()