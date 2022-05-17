##        Abundance Adjustment Cell Area (cm^2/L)
##                     04/06/2022
## Every pixel with algae presence as indicated by a positive value
## from the NDI equation is then adjusted to represent algae
## abundance in each pixel. This adjustment is (NDI*1400). Ground truth
## measurements(Ganey 2017) show that this calculation has an R^2 of (0.93)
## the closest to field measurements of all abundance equations. 

#----------------------------------------------------------------------

### Packages
library(tidyverse)
library(rgdal) 
library(sp)
library(sf)
library(dplyr)
library(rgeos)
library(raster)

#-----------------------------------------------------------------
### Abundance Cell Area Function 

cell.area.fun <- function(x) {(x*1400)}

#-----------------------------------------------------------------
## 2013

NDI.2013.con <- raster("../conditional/NDI_2013_con.tif")

cell.area.2013 <- calc(NDI.2013.con, cell.area.fun) ## run through function

plot(cell.area.2013) ## Check function

writeRaster(cell.area.2013,"../abundance_cellarea/cell_area_2013.tif", overwrite=T) ## Write output

#-----------------------------------------------------------------
## 2014

NDI.2014.con <- raster("../conditional/NDI_2014_con.tif")

cell.area.2014 <- calc(NDI.2014.con, cell.area.fun)

writeRaster(cell.area.2014,"../abundance_cellarea/cell_area_2014.tif", overwrite=T)

#-----------------------------------------------------------------
## 2015

NDI.2015.con <- raster("../conditional/NDI_2015_con.tif")

cell.area.2015 <- calc(NDI.2015.con, cell.area.fun)

writeRaster(cell.area.2015,"../abundance_cellarea/cell_area_2015.tif", overwrite=T) 

#-----------------------------------------------------------------
## 2016

NDI.2016.con <- raster("../conditional/NDI_2016_con.tif")

cell.area.2016 <- calc(NDI.2016.con, cell.area.fun)

writeRaster(cell.area.2016,"../abundance_cellarea/cell_area_2016.tif", overwrite=T)

#-----------------------------------------------------------------
## 2018

NDI.2018.con <- raster("../conditional/NDI_2018_con.tif")

cell.area.2018 <- calc(NDI.2018.con, cell.area.fun)

writeRaster(cell.area.2018,"../abundance_cellarea/cell_area_2018.tif", overwrite=T)

#-----------------------------------------------------------------
## 2019

NDI.2019.con <- raster("../conditional/NDI_2019_con.tif")

cell.area.2019 <- calc(NDI.2019.con, cell.area.fun)

writeRaster(cell.area.2019,"../abundance_cellarea/cell_area_2019.tif", overwrite=T)

#-----------------------------------------------------------------
## 2020

NDI.2020.con <- raster("../conditional/NDI_2020_con.tif")

cell.area.2020 <- calc(NDI.2020.con, cell.area.fun) 

writeRaster(cell.area.2020,"../abundance_cellarea/cell_area_2020.tif", overwrite=T)

#-----------------------------------------------------------------
## 2021

NDI.2021.con <- raster("../conditional/NDI_2021_con.tif")

cell.area.2021 <- calc(NDI.2021.con, cell.area.fun) 

writeRaster(cell.area.2021,"../abundance_cellarea/cell_area_2021.tif", overwrite=T)

#-----------------------------------------------------------------

##  END


