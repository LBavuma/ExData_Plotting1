# plot3.R
# This script creates Plot 3: Time series of Energy sub-metering

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
png("plot3.png", width = 480, height = 480)

# Create line plot for Sub_metering_1
plot(subset_data$datetime, subset_data$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black")

# Add Sub_metering_2 line
lines(subset_data$datetime, subset_data$Sub_metering_2, col = "red")

# Add Sub_metering_3 line
lines(subset_data$datetime, subset_data$Sub_metering_3, col = "blue")

# Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       lwd = 1)

# Close device
dev.off()