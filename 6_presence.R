##           Setting to "Presence"
##                04/06/2022
## Each raster that has breaks set will now be adjust to
## just presence maps. any value remaining on these rasters
## will be set to 1 to indicate algae "presence"

#-------------------------------------------------------------------------

### Packages
library(tidyverse)
library(rgdal) 
library(sp)
library(sf)
library(dplyr)
library(rgeos)
library(raster)

#------------------------------------------------------------------------
##Inputs

## shape file to set plot extent
glacier.outline.UTMZ6 <- readOGR("../glacier_outline/2013_glacieroutline.shp")

#------------------------------------------------------------------------
## 2013
breaks.2013 <- raster("../breaks/cellarea_breaks_2013.tif")

breaks.2013[breaks.2013 > 0] = 1 # any positive value becomes 1

plot(breaks.2013, ext= glacier.outline.UTMZ6) # check that it worked

writeRaster(breaks.2013, "../presence/presence_2013.tif", overwrite=T)
#------------------------------------------------------------------------
## 2014
breaks.2014 <- raster("../breaks/cellarea_breaks_2014.tif")

breaks.2014[breaks.2014 > 0] = 1

writeRaster(breaks.2014, "../presence/presence_2014.tif", overwrite=T)

#------------------------------------------------------------------------
## 2015
breaks.2015 <- raster("../breaks/cellarea_breaks_2015.tif")

breaks.2015[breaks.2015 > 0] = 1

writeRaster(breaks.2015, "../presence/presence_2015.tif", overwrite=T)

#------------------------------------------------------------------------
## 2016
breaks.2016 <- raster("../breaks/cellarea_breaks_2016.tif")

breaks.2016[breaks.2016 > 0] = 1

writeRaster(breaks.2016, "../presence/presence_2016.tif", overwrite=T)

#------------------------------------------------------------------------
## 2018
breaks.2018 <- raster("../breaks/cellarea_breaks_2018.tif")

breaks.2018[breaks.2018 > 0] = 1

writeRaster(breaks.2018, "../presence/presence_2018.tif", overwrite=T)

#------------------------------------------------------------------------
## 2019
breaks.2019 <- raster("../breaks/cellarea_breaks_2019.tif")

breaks.2019[breaks.2019 > 0] = 1

writeRaster(breaks.2019, "../presence/presence_2019.tif", overwrite=T)

#------------------------------------------------------------------------
## 2020
breaks.2020 <- raster("../breaks/cellarea_breaks_2020.tif")

breaks.2020[breaks.2020 > 0] = 1

writeRaster(breaks.2020, "../presence/presence_2020.tif", overwrite=T)

#------------------------------------------------------------------------
## 2021
breaks.2021 <- raster("../breaks/cellarea_breaks_2021.tif")

breaks.2021[breaks.2021 > 0] = 1

writeRaster(breaks.2021, "../presence/presence_2021.tif", overwrite=T)

#------------------------------------------------------------------------
##  END