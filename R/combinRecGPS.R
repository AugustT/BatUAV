#' @export

combineRecGPS <- function(filetab, GPStab){

  GPStab$file <- NA

  for(i in 1:nrow(filetab)){

    row <- filetab[i, ]
    diffs <- abs(row$time - GPStab$time)
    minloc <- which.min(diffs)
    GPStab$file[minloc] <- row$filePath

  }


  combTab <- GPStab[!is.na(GPStab$file), ]

  class(combTab) <- 'combTab'

  return(combTab)

}
