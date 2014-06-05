loadData <- function() {
    if (!file.exists("household_power_consumption.txt")) {
        stop("I couldn't find the datafile, household_power_consumption.txt, in your current working directory.  please setwd() to the correct directory and try loadData() again")
    }
    message("Loading hpc_data ...")
    # Skip over the first 66,637 lines to where 2007-02-01 starts, and read 2,880 rows for 
    # all of 2007-02-01 to 2007-02-02.  Since we're skipping over the first line in the file
    # we have to explicitely specify the column names.  Also set NA to '?' as specified in the
    # project instructions.
    hpc_data <<- read.table(file="household_power_consumption.txt",
                            skip=66637, nrow=2880, sep=";", header=FALSE, 
                            col.names = c("Date", "Time", "Global_active_power", 
                                          "Global_reactive_power", "Voltage", 
                                          "Global_intensity", "Sub_metering_1", 
                                          "Sub_metering_2", "Sub_metering_3"),
                            na.strings = "?"
    )
    # convert Date and Time fields into POSIXlt() class objects
    hpc_data$datetime <<- with(hpc_data, strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
    message("data exported into your environment as `hpc_data`")
    invisible(0)
}

plot2 <- function() {
    # Expect hpc_data to exist in the parent frame
    if (!exists("hpc_data"))
        stop("`hpc_data` missing, please run loadData() to load it")
    with(hpc_data,
         plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power"
         )
    )
}

plot3 <- function() {
    # Expect hpc_data to exist in the parent frame
    if (!exists("hpc_data"))
        stop("`hpc_data` missing, please run loadData() to load it")
    with(hpc_data, {
        plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
        lines(datetime, Sub_metering_2, type="l", col="red")
        lines(datetime, Sub_metering_3, type="l", col="blue")
        legend("topright", 
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
               col=c("black","red","blue"),
               lty=1
        )
    })
}

plot4a <- function() {
    # Expect hpc_data to exist in the parent frame
    if (!exists("hpc_data"))
        stop("`hpc_data` missing, please run loadData() to load it")
    with(hpc_data, {
        plot(datetime, Voltage, type="l")
        
    })
}

plot4b <- function() {
    # Expect hpc_data to exist in the parent frame
    if (!exists("hpc_data"))
        stop("`hpc_data` missing, please run loadData() to load it")
    with(hpc_data, {
        plot(datetime, Global_reactive_power, type="l")
    })
}

plot4 <- function() {
    par(mfcol=c(2,2))
    plot2()
    plot3()
    plot4a()
    plot4b()
}

plot4png <- function() {
    message("Generating Plot4.png ...")
    png(filename="Plot4.png", width=480, height=480)
    plot4()
    dev.off()
    message("Done!")
}

if (!exists("hpc_data"))
    loadData()
plot4png()