#' @export

writeSpectrogram <- function(WAVpath, outdir = dirname(WAVpath), flim = c(10, 80), time = 0.5, res = 300){

  library(seewave)
  library(tuneR)

  batfile <- readWave(filename = WAVpath, from = 0, to = time, units = 'seconds')

  png(filename = file.path(outdir,
                           gsub('.wav$', '.png', basename(WAVpath), ignore.case = TRUE)),
      width = 6, height = 4, units = 'in', res = res)
  filespec <- spectro(batfile,
                      flim = flim,
                      collevels = seq(-40, 0, 5))
  dev.off()

  return(file.path(outdir, gsub('.wav$', '.png', basename(WAVpath), ignore.case = TRUE)))

}


