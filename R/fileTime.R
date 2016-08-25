#' @export

fileTime <- function(filePath){

  if(!file.exists(filePath)) stop('Could not find file ', filePath)

  # get the files information
  f.info <- file.info(filePath)

  # The minimum date/time will be the creation point
  x <- f.info[1, c('mtime', 'ctime', 'atime')]

  time <- apply(x, 1, min)

  names(time) <- NULL

  return(time)

}
