#' @export

createFileTimeTable <- function(files, writeFile = NULL){

  fileTimeTable <- lapply(X = files, FUN = function(x) data.frame(filePath = as.character(x),
                                                                  fileName = basename(as.character(x)),
                                                                  time = as.POSIXct(fileTime(as.character(x))),
                                                                  stringsAsFactors = FALSE))
  fileTimeTable <- do.call(rbind, fileTimeTable)

  if(!is.null(writeFile)) write.csv(fileTimeTable, file = out, row.names = FALSE)

  return(fileTimeTable)

}
