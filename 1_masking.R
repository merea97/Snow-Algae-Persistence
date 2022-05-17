##       MASKING
##      04/06/2022
## script to extract by glacier outline for each band for each year
## and put in a new folder and name each "maskB4_2013.tif"

## Noted issues: Some raw raster files are in UTMZ5, some in UTMZ6. This
## will not effect the raster calculation next step, but will need to be
## "fixed" before all rasters can be added together.

## Years that are in UTMZ6: 2013, 2015, 2019

## Downloads came from Collection 2 Level 2 Landsat 8 data on
## Earth Explorer Website

## Glacier outline was found from B4/B6 (Red/SWIR) to represent
## glacier extent, then converted to a polygon

#----------------------------------------------------------------------------

### Packages
library(tidyverse)
library(rgdal) 
library(sp)
library(sf)
library(dplyr)
library(rgeos)
library(raster)

#----------------------------------------------------------------------------

## Inputs

## Shapefile
glacier.outline.UTMZ6 <- readOGR("../glacier_outline/2013_glacieroutline.shp")
plot(glacier.outline.UTMZ6)

crs(glacier.outline.UTMZ6) ##checking crs

## must import 2014 raster data to run following line, refer to line 49
glacier.outline.UTMZ5 <- spTransform(glacier.outline.UTMZ6, crs(B3.2014)) ##reprojecting shapefile

crs(glacier.outline.UTMZ5) ##checking new crs

#----------------------------------------------------------------------------

## 2013 rasters In UTM Z6
B3.2013 <- raster("../downloads/2013/LC08_L2SP_068018_20130915_20200913_02_T1_SR_B3.TIF")
B4.2013 <- raster("../downloads/2013/LC08_L2SP_068018_20130915_20200913_02_T1_SR_B4.TIF")

B3.2013.mask <- mask(B3.2013,
                     glacier.outline.UTMZ6,
                     inverse=FALSE)

writeRaster(B3.2013.mask,"../masks/B3_2013_mask.tif")

B3.mask.2013.check <- raster("../masks/B3_2013_mask.tif")

plot(B3.mask.2013.check)

B4.2013.mask <- mask(B4.2013,
                     glacier.outline.UTMZ6,
                     inverse=FALSE)

writeRaster(B4.2013.mask,"../masks/B4_2013_mask.tif")

#----------------------------------------------------------------------------

## 2014 In UTM Z5
B3.2014 <- raster("../downloads/2014/LC08_L2SP_069018_20140925_20200910_02_T1_SR_B3.TIF")
B4.2014 <- raster("../downloads/2014/LC08_L2SP_069018_20140925_20200910_02_T1_SR_B4.TIF")

B3.2014.mask <- mask(B3.2014,
                     glacier.outline.UTMZ5,
                     inverse=FALSE)

writeRaster(B3.2014.mask,"../masks/B3_2014_mask.tif")

B4.2014.mask <- mask(B4.2014,
                     glacier.outline.UTMZ5,
                     inverse=FALSE)

writeRaster(B4.2014.mask,"../masks/B4_2014_mask.tif")

B3.mask.2014.check <- raster("../masks/B3_2014_mask.tif")
#----------------------------------------------------------------------------

##2015 In UTM Z6
B3.2015 <- raster("../downloads/2015/LC08_L2SP_068018_20150804_20200908_02_T1_SR_B3.TIF")
B4.2015 <- raster("../downloads/2015/LC08_L2SP_068018_20150804_20200908_02_T1_SR_B4.TIF")

B3.2015.mask <- mask(B3.2015,
                     glacier.outline.UTMZ6,
                     inverse=FALSE)

writeRaster(B3.2015.mask,"../masks/B3_2015_mask.tif")

B4.2015.mask <- mask(B4.2015,
                     glacier.outline.UTMZ6,
                     inverse=FALSE)

writeRaster(B4.2015.mask,"../masks/B4_2015_mask.tif")

#----------------------------------------------------------------------------

## 2016 In UTM Z5
B3.2016 <- raster("../downloads/2016/LC08_L2SP_069018_20160829_20200906_02_T1_SR_B3.TIF")
B4.2016 <- raster("../downloads/2016/LC08_L2SP_069018_20160829_20200906_02_T1_SR_B4.TIF")

B3.2016.mask <- mask(B3.2016,
                     glacier.outline.UTMZ5,
                     inverse=FALSE)

writeRaster(B3.2016.mask,"../masks/B3_2016_mask.tif")

B4.2016.mask <- mask(B4.2016,
                     glacier.outline.UTMZ5,
                     inverse=FALSE)

writeRaster(B4.2016.mask,"../masks/B4_2016_mask.tif")

#----------------------------------------------------------------------------

## 2018 In UTM Z5
B3.2018 <- raster("../downloads/2018/LC08_L2SP_069018_20180904_20200831_02_T1_SR_B3.TIF")
B4.2018 <- raster("../downloads/2018/LC08_L2SP_069018_20180904_20200831_02_T1_SR_B4.TIF")

B3.2018.mask <- mask(B3.2018,
                     glacier.outline.UTMZ5,
                     inverse=FALSE)

writeRaster(B3.2018.mask,"../masks/B3_2018_mask.tif")

B4.2018.mask <- mask(B4.2018,
                     glacier.outline.UTMZ5,
                     inverse=FALSE)

writeRaster(B4.2018.mask,"../masks/B4_2018_mask.tif")

#----------------------------------------------------------------------------

## 2019 In UTM Z6
B3.2019 <- raster("../downloads/2019/LC08_L2SP_068018_20190815_20200827_02_T1_SR_B3.TIF")
B4.2019 <- raster("../downloads/2019/LC08_L2SP_068018_20190815_20200827_02_T1_SR_B4.TIF")

B3.2019.mask <- mask(B3.2019,
                     glacier.outline.UTMZ6,
                     inverse=FALSE)

writeRaster(B3.2019.mask,"../masks/B3_2019_mask.tif")

B4.2019.mask <- mask(B4.2019,
                     glacier.outline.UTMZ6,
                     inverse=FALSE)

writeRaster(B4.2019.mask,"../masks/B4_2019_mask.tif")

#----------------------------------------------------------------------------

## 2020 In UTM Z5
B3.2020 <- raster("../downloads/2020/LC08_L2SP_069018_20200909_20200919_02_T1_SR_B3.TIF")
B4.2020 <- raster("../downloads/2020/LC08_L2SP_069018_20200909_20200919_02_T1_SR_B4.TIF")

B3.2020.mask <- mask(B3.2020,
                     glacier.outline.UTMZ5,
                     inverse=FALSE)

writeRaster(B3.2020.mask,"../masks/B3_2020_mask.tif")

B4.2020.mask <- mask(B4.2020,
                     glacier.outline.UTMZ5,
                     inverse=FALSE)

writeRaster(B4.2020.mask,"../masks/B4_2020_mask.tif")

#----------------------------------------------------------------------------

## 2021 In UTM Z5
B3.2021 <- raster("../downloads/2021/LC08_L2SP_069018_20210726_20210804_02_T1_SR_B3.TIF")
B4.2021 <- raster("../downloads/2021/LC08_L2SP_069018_20210726_20210804_02_T1_SR_B4.TIF")

B3.2021.mask <- mask(B3.2021,
                     glacier.outline.UTMZ5,
                     inverse=FALSE)

writeRaster(B3.2021.mask,"../masks/B3_2021_mask.tif")

B4.2021.mask <- mask(B4.2021,
                     glacier.outline.UTMZ5,
                     inverse=FALSE)

writeRaster(B4.2021.mask,"../masks/B4_2021_mask.tif")

#----------------------------------------------------------------------------

## END
