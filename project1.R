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

if (!exists("hpc_data"))
    loadData()
