##         Conditional Statment (in Arc)
##              04/06/2022
## Each NDI calc is run through a conditional statement to make
## any pixels with values < or equal to 0 = 0.
## This must be done before a abundance calculation to insure
## that and pixels going into the abundance calc are actual
## presences of algae. 

#----------------------------------------------------------------

### Packages
library(tidyverse)
library(rgdal) 
library(sp)
library(sf)
library(dplyr)
library(rgeos)
library(raster)

#-----------------------------------------------------------------
## 2013

NDI.2013 <- raster("../NDI/NDI_2013.tif")

NDI.2013[NDI.2013 < 0] = 0 # anything less then or equal to 0 becomes 0

plot(NDI.2013) # check that it worked

writeRaster(NDI.2013, "../conditional/NDI_2013_con.tif", overwrite=T)

#-----------------------------------------------------------------
## 2014

NDI.2014 <- raster("../NDI/NDI_2014.tif")

NDI.2014[NDI.2014 < 0] = 0

writeRaster(NDI.2014, "../conditional/NDI_2014_con.tif", overwrite=T)

#-----------------------------------------------------------------
## 2015

NDI.2015 <- raster("../NDI/NDI_2015.tif")

NDI.2015[NDI.2015 < 0] = 0

writeRaster(NDI.2015, "../conditional/NDI_2015_con.tif", overwrite=T)

#-----------------------------------------------------------------
## 2016

NDI.2016 <- raster("../NDI/NDI_2016.tif")

NDI.2016[NDI.2016 <= 0] = 0

writeRaster(NDI.2016, "../conditional/NDI_2016_con.tif", overwrite=T)

#-----------------------------------------------------------------
## 2018

NDI.2018 <- raster("../NDI/NDI_2018.tif")

NDI.2018[NDI.2018 <= 0] = 0

writeRaster(NDI.2018, "../conditional/NDI_2018_con.tif", overwrite=T)

#-----------------------------------------------------------------
## 2019

NDI.2019 <- raster("../NDI/NDI_2019.tif")

NDI.2019[NDI.2019 <= 0] = 0

writeRaster(NDI.2019, "../conditional/NDI_2019_con.tif", overwrite=T)

#-----------------------------------------------------------------
## 2020

NDI.2020 <- raster("../NDI/NDI_2020.tif")

NDI.2020[NDI.2020 <= 0] = 0

writeRaster(NDI.2020, "../conditional/NDI_2020_con.tif", overwrite=T)

#-----------------------------------------------------------------
## 2021

NDI.2021 <- raster("../NDI/NDI_2021.tif")

NDI.2021[NDI.2021 <= 0] = 0

writeRaster(NDI.2021, "../conditional/NDI_2021_con.tif", overwrite=T)

#------------------------------------------------------------------

##  END 