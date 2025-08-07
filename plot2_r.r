# plot2.R
# This script creates Plot 2: Time series of Global Active Power

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

# Create datetime column by combining Date and Time
subset_data$datetime <- strptime(paste(subset_data$Date, subset_data$Time), 
                                format = "%Y-%m-%d %H:%M:%S")

# Create PNG device
png("plot2.png", width = 480, height = 480)

# Create line plot
plot(subset_data$datetime, subset_data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Close device
dev.off()