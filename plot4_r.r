# plot4.R
# This script creates Plot 4: Four panel plot

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
png("plot4.png", width = 480, height = 480)

# Set up 2x2 panel layout
par(mfrow = c(2, 2))

# Plot 1: Global Active Power (top left)
plot(subset_data$datetime, subset_data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

# Plot 2: Voltage (top right)
plot(subset_data$datetime, subset_data$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Plot 3: Energy sub-metering (bottom left)
plot(subset_data$datetime, subset_data$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black")
lines(subset_data$datetime, subset_data$Sub_metering_2, col = "red")
lines(subset_data$datetime, subset_data$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       lwd = 1,
       bty = "n",  # no border around legend
       cex = 0.8)  # smaller text

# Plot 4: Global Reactive Power (bottom right)
plot(subset_data$datetime, subset_data$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

# Close device
dev.off()