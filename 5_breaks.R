##       Setting lower limits
##            04/06/2022
## Many pixels have algae abundances that are relatively
## negligible. Here we will set a lower limit on the
## abundance that will count as "presence". The lower limit 
## here is defined as > 5cm^2/L cell area. 

#------------------------------------------------------------------------

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
##2013 
cellarea.2013 <- raster("../abundance_cellarea/cell_area_2013.tif")

str(cellarea.2013) ##check structure

cellarea.2013[cellarea.2013 < 5] = 0 # anything less then or equal to 5 becomes NA

plot(cellarea.2013, ext = glacier.outline.UTMZ6) # check that it worked

writeRaster(cellarea.2013, "../breaks/cellarea_breaks_2013.tif", overwrite=T)

#-------------------------------------------------------------------------
##2014
cellarea.2014 <- raster("../abundance_cellarea/cell_area_2014.tif")

cellarea.2014[cellarea.2014 < 5] = 0 

writeRaster(cellarea.2014, "../breaks/cellarea_breaks_2014.tif", overwrite=T)

#-------------------------------------------------------------------------
##2015 
cellarea.2015 <- raster("../abundance_cellarea/cell_area_2015.tif")

cellarea.2015[cellarea.2015 < 5] = 0 

writeRaster(cellarea.2015, "../breaks/cellarea_breaks_2015.tif", overwrite=T)

#-------------------------------------------------------------------------
##2016
cellarea.2016 <- raster("../abundance_cellarea/cell_area_2016.tif")

cellarea.2016[cellarea.2016 < 5] = 0 

writeRaster(cellarea.2016, "../breaks/cellarea_breaks_2016.tif", overwrite=T)

#-------------------------------------------------------------------------
##2018 
cellarea.2018 <- raster("../abundance_cellarea/cell_area_2018.tif")

cellarea.2018[cellarea.2018 < 5] = 0 

writeRaster(cellarea.2018, "../breaks/cellarea_breaks_2018.tif", overwrite=T)

#-------------------------------------------------------------------------
##2019 
cellarea.2019 <- raster("../abundance_cellarea/cell_area_2019.tif")

cellarea.2019[cellarea.2019 < 5] = 0 

writeRaster(cellarea.2019, "../breaks/cellarea_breaks_2019.tif", overwrite=T)

#-------------------------------------------------------------------------
##2020
cellarea.2020 <- raster("../abundance_cellarea/cell_area_2020.tif")

cellarea.2020[cellarea.2020 < 5] = 0

writeRaster(cellarea.2020, "../breaks/cellarea_breaks_2020.tif", overwrite=T)

#-------------------------------------------------------------------------
##2021
cellarea.2021 <- raster("../abundance_cellarea/cell_area_2021.tif")

cellarea.2021[cellarea.2021 < 5] = 0 

writeRaster(cellarea.2021, "../breaks/cellarea_breaks_2021.tif", overwrite=T)

#-------------------------------------------------------------------------

##  END 