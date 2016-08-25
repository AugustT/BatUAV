#' @export
# Takes a log file and extacts the GPS cordinates and time
GPSFromLog <- function(logPath){

  # if(!grepl('.log$', tolower(basename(logPath)))) stop('Please select a .log file')

  # read in the log file
  log <- readLines(logPath)

  # Take just the GPS lines
  logGPS <- log[grepl('^GPS, ', log)]

  # Convert into a usable data frame
  GPStab <- as.data.frame(do.call(rbind, strsplit(logGPS, ', ' )), stringsAsFactors = FALSE)

  # Convert the GPS time into normal time
  GPSsec <- as.numeric(GPStab$V4)
  GPSweek <- as.numeric(GPStab$V5)

  # THIS DOESNT WORK RIGHT
  GPStimConvert <- function(millisec, week){

    x <- as.Date('1980-01-06')
    x <- x + (GPSweek * 7)
    y <- as.POSIXct(x, tz = 'GMT')
    return(y + (GPSsec/1000))

  }

  finalLog <- data.frame(time = GPStimConvert(GPSsec, GPSweek),
                         latitude = as.numeric(GPStab$V8),
                         longitude = as.numeric(GPStab$V9))

  return(finalLog)

}
