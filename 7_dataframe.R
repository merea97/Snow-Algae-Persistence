##                 Making Dataframe
##                    05/08/2022

## This script take our persistence raster and combines it with our
## geo-spatial variable data derived from an Arctic DEM mosaic of the Harding
## Ice field. We will also convert persistence to to binomial data based on the
## number of years of presence (>5 years = persistence)
#----------------------------------------------------------------------------
### Packages
library(tidyverse)
library(rgdal) 
library(sp)
library(sf)
library(dplyr)
library(rgeos)
library(raster)
library(fields)
#----------------------------------------------------------------------------
## Inputs

##bring in glacier outline to crop extent
glacier.outline.UTMZ6 <- readOGR("../shapefiles/2013_glacieroutline.shp")

## bring in persistence raster (algae populations of >5cm^2/L with their pixel
## values representing the number of years they have been observed there)
persistance <- raster("../rasters/persistance.tif")

##bring in geo-spatial variable rasters
dem <- raster("../rasters/dem_final.tif")
slope <- raster("../rasters/slope.tif")
aspect <- raster("../rasters/aspect.tif")
coastdist <- raster("../rasters/coastdist1.tif")

#convert to points vector
dempoints <- rasterToPoints(dem,
                            spatial=TRUE)

sloppoints <- rasterToPoints(aspect,
                             spatial=TRUE)

aspectpoints <- rasterToPoints(slope,
                               spatial=TRUE)

persitancepoints <- rasterToPoints(persistance,
                               spatial=TRUE)

coastdistpoints <- rasterToPoints(coastdist,
                               spatial=TRUE)

##project to lat/long
persis.longlat <- spTransform(persitancepoints, 
                              CRS("+proj=longlat +datum=WGS84"))

elev.longlat <- spTransform(dempoints, 
                            CRS("+proj=longlat +datum=WGS84"))

slope.longlat <- spTransform(sloppoints, 
                             CRS("+proj=longlat +datum=WGS84"))

aspect.longlat <- spTransform(aspectpoints, 
                              CRS("+proj=longlat +datum=WGS84"))

coastdist.longlat <- spTransform(coastdistpoints, 
                              CRS("+proj=longlat +datum=WGS84"))
##make dataframes
elev.df <- data.frame(x=elev.longlat@coords[,1], 
                      y=elev.longlat@coords[,2], 
                      elev.longlat@data)
slope.df <- data.frame(x=slope.longlat@coords[,1], 
                       y=slope.longlat@coords[,2], 
                       slope.longlat@data)
aspect.df <- data.frame(x=aspect.longlat@coords[,1], 
                        y=aspect.longlat@coords[,2], 
                        aspect.longlat@data)
coastdist.df <- data.frame(x=coastdist.longlat@coords[,1], 
                        y=coastdist.longlat@coords[,2], 
                        coastdist.longlat@data)
persistance.df <- data.frame(x=persis.longlat@coords[,1], 
                        y=persis.longlat@coords[,2], 
                        persis.longlat@data)
##join data
df1 <- persistance.df %>%left_join(elev.df)
df2 <- df1%>%left_join(aspect.df)
df3 <- df2%>%left_join(slope.df)
dat.final <- df3%>%left_join(coastdist.df)

##remove any na's
all.dat <- na.omit(dat.final)

# Clean data, binomial values for persistence

binomial.dat <- all.dat %>% rename(Coast.Distance.km = coastdist1, 
                            Elevation.m = dem_final,
                            long = x,
                            lat = y,
                            Persistance = persistance,
                            slope.deg = slope,
                            aspect.deg=aspect) %>%
  mutate(Persistance = 
           replace(Persistance, 
                   Persistance > 0, 1)) %>%
  mutate(Coast.Distance.km = (Coast.Distance.km/1000))

##export
write.csv(binomial.dat, "../data_frames/binomial_dat.csv", row.names=FALSE)

##END