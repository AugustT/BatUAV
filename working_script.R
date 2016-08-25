rm(list = ls())

library(BatUAV)

audiodir <- 'C:/Users/Tom/Pictures/UAV/Chris stag/Audio files/18th'

files <- list.files(audiodir, pattern = '.WAV$', full.names = TRUE)

filetab <- createFileTimeTable(files)
GPStab <- GPSFromLog('C:/Users/Tom/Dropbox/Project Erebus/Stag logs from quad flight with bat recordings/111 18-Jun-16 10-39-08 PM.bin.log')

# Adjust the filetab as the recorder was not correct
filetab$time <- filetab$time + (60*7)

combTab <- combineRecGPS(filetab = filetab, GPStab = GPStab)

library(leaflet)

# Use file name to get peak frequency
combTab$Peak <- gsub('^0', '', substr(combTab$file, start = nchar(combTab$file) - 10, stop = nchar(combTab$file) - 8))

# Create 1 second sonograms
combTab$Spectrogram <- unlist(lapply(X = combTab$file, FUN = writeSpectrogram, res = 70))

saveas <- function(map, file){
  class(map) <- c("saveas",class(map))
  attr(map,"filesave")=file
  map
}

print.saveas <- function(x, ...){
  class(x) = class(x)[class(x)!="saveas"]
  htmltools::save_html(x, file=attr(x,"filesave"))
}

options = providerTileOptions(minZoom = 8, maxZoom = 10)

m <- leaflet(width = 1000, height = 1000)
m <- addProviderTiles(m, 'Esri.WorldImagery')
m <- addMarkers(m, lng = combTab$longitude, lat = combTab$latitude, popup = paste('<h2>',
                                                                                  paste('Trigger Frequency -', combTab$Peak),
                                                                                  '<h2/>',
                                                                                  paste0('<img src="',
                                                                                         combTab$Spectrogram,
                                                                                         '" alt="Spectrogram">'))
                )
saveas(m, file = file.path(audiodir, 'index.html'))

browseURL(file.path(audiodir, 'index.html'))

