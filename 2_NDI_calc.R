##       Initial Algae Calc NDI
##            04/06/2022
## Each year is run through the NDI calc as follows:
## ((B4-B3)/(B4+B3)) this is the initial calc. 

## Noted Issues: UTMZ6 Rasters still have not been projected to
## UTMZ5, this problem will continue to roll over.

#-----------------------------------------------------------------

### Packages
library(tidyverse)
library(rgdal) 
library(sp)
library(sf)
library(dplyr)
library(rgeos)
library(raster)

#-----------------------------------------------------------------
### NDI Function 

NDI.fun <- function(x) {(x[1]-x[2])/(x[1]+x[2])}

#-----------------------------------------------------------------

## 2013

B3.2013 <- raster("../masks/B3_2013_mask.tif")
B4.2013 <- raster("../masks/B4_2013_mask.tif")

stack_2013 <- stack(B4.2013,B3.2013) ## stack rasters for function

NDI.2013 <- calc(stack_2013, NDI.fun) ## run through function

plot(NDI.2013) ## Check function

writeRaster(NDI.2013,"../NDI/NDI_2013.tif") ## Write output

#-----------------------------------------------------------------

## 2014

B3.2014 <- raster("../masks/B3_2014_mask.tif")
B4.2014 <- raster("../masks/B4_2014_mask.tif")

stack_2014 <- stack(B4.2014,B3.2014) 

NDI.2014 <- calc(stack_2014, NDI.fun) 

writeRaster(NDI.2014,"../NDI/NDI_2014.tif")

#-----------------------------------------------------------------

## 2015

B3.2015 <- raster("../masks/B3_2015_mask.tif")
B4.2015 <- raster("../masks/B4_2015_mask.tif")

stack_2015 <- stack(B4.2015,B3.2015) 

NDI.2015 <- calc(stack_2015, NDI.fun)

writeRaster(NDI.2015,"../NDI/NDI_2015.tif")

#-----------------------------------------------------------------

## 2016

B3.2016 <- raster("../masks/B3_2016_mask.tif")
B4.2016 <- raster("../masks/B4_2016_mask.tif")

stack_2016 <- stack(B4.2016,B3.2016) 

NDI.2016 <- calc(stack_2016, NDI.fun)

writeRaster(NDI.2016,"../NDI/NDI_2016.tif")

#-----------------------------------------------------------------

## 2018

B3.2018 <- raster("../masks/B3_2018_mask.tif")
B4.2018 <- raster("../masks/B4_2018_mask.tif")

stack_2018 <- stack(B4.2018,B3.2018) 

NDI.2018 <- calc(stack_2018, NDI.fun) 

writeRaster(NDI.2018,"../NDI/NDI_2018.tif") 

#-----------------------------------------------------------------

## 2019

B3.2019 <- raster("../masks/B3_2019_mask.tif")
B4.2019 <- raster("../masks/B4_2019_mask.tif")

stack_2019 <- stack(B4.2019,B3.2019)

NDI.2019 <- calc(stack_2019, NDI.fun) 

writeRaster(NDI.2019,"../NDI/NDI_2019.tif") 
#-----------------------------------------------------------------

## 2020

B3.2020 <- raster("../masks/B3_2020_mask.tif")
B4.2020 <- raster("../masks/B4_2020_mask.tif")

stack_2020 <- stack(B4.2020,B3.2020)

NDI.2020 <- calc(stack_2020, NDI.fun)

writeRaster(NDI.2020,"../NDI/NDI_2020.tif")
#-----------------------------------------------------------------

## 2021

B3.2021 <- raster("../masks/B3_2021_mask.tif")
B4.2021 <- raster("../masks/B4_2021_mask.tif")

stack_2021 <- stack(B4.2021,B3.2021) 

NDI.2021 <- calc(stack_2021, NDI.fun)

writeRaster(NDI.2021,"../NDI/NDI_2021.tif")

#-----------------------------------------------------------------

## END