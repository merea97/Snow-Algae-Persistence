##              Modeling and Plotting with GAMs
##                       05/02/20222

## This script will take our created dataframe and using it to look at 
## various data trends. then we will use a subset to create various GAM
## models and determine which is the most predictive. After which we will
## plot the model's performance in comparison to observed data. 

#-----------------------------------------------------------------------
##Packages
library(pROC)
library(ROCit)
library(tidyverse)
library(rgdal) 
library(sp)
library(sf)
library(dplyr)
library(rgeos)
library(raster)
library(fields)
#----------------------------------------
##bring in data
binomial.dat <- read.csv("../data_frames/binomial_dat.csv")

##Observe distribution trends for Elevation and Distance from Coast variables
persis.labs <- c("0"="Algae Absence", "1" ="Algae Presence")

binomial.dat[sample(1:nrow(binomial.dat),25000),] %>%
  ggplot(aes(x=Coast.Distance.km, y=Elevation.m))+
  stat_density_2d(aes(fill = ..level..), geom = "polygon",color="white",size=0.1)+
  scale_fill_distiller(palette=4, direction=-1) +
  theme(plot.title=element_text(size=16,face = "bold"))+
  theme(legend.position='none')+
  facet_grid(cols = vars(Persistance), labeller = labeller(Persistance=persis.labs))+
  theme(strip.text.x = element_text(face="bold"))+
  labs(title="Algae Absence/Presence Distribution Densities",
       y="Elevation (m)", 
       x="Distance from Coast (km)")

## Save
ggsave("../figures/density_plot.pdf",last_plot())

#--------------------------------------------------
# Single variable GAM model preformances, creating and graphing:

##GAM model for Proximity to Coast

# Get 20000 random points from data set
n <- 20000
dat.sub <- binomial.dat[sample(1:nrow(binomial.dat),n),]

## Model for sample points
dist.gam <- mgcv::gam(Persistance~s(Coast.Distance.km), 
                      family = "binomial",
                      method = "REML",
                      data = dat.sub)
summary(dist.gam)
gam.check(dist.gam)

## Create predictions with dist.gam model
sample.dist <- seq(16,52,1) 

my.preds <- predict(dist.gam, 
                    newdata = data.frame(Coast.Distance.km=sample.dist),
                    type = "response")

## Filter data frame to remove Coast distances <10 and >53
dat.sub <- dat.sub %>% filter(Coast.Distance.km > 16 & Coast.Distance.km < 52) %>%
  mutate(dist.class = cut(Coast.Distance.km,seq(16,52,2)))

# Create data frame of probability using actual data 
# chunked for distance to coast seq(10,54,1)
dat.sum <- dat.sub %>% group_by(dist.class) %>%
  summarise(algae = sum(Persistance),
            total = length(Persistance),
            algae.prop = algae/total)

# Find the mids of the dataframe to plot
dat.sum$mids <- (seq(16,52,2)[1:(length(seq(16,52,2))-1)]+(seq(16,52,2)[2:(length(seq(16,52,2)))]))/2

# Plot predicted probability with observed probability 
ggplot(data = data.frame(algae = my.preds, 
                         distance.km = sample.dist), 
       aes(x=distance.km, y = algae))+
  geom_smooth(aes(shape = "Modeled", linetype="Modeled"), method = "gam", color="black", size=.5)+
  geom_point(data = dat.sum, aes(x=mids, y=algae.prop, shape="Observed", linetype = "Observed"), color = "deepskyblue3", size = 2.5)+
  labs(title="Coast Proximity Modeling Preformance",
       y="Probability of Algae Presence", 
       x="Distance from Coast (km)")+
  scale_shape_manual(name = "Probability Source", values=c('Observed'=18, 'Modeled'=NA)) + 
  scale_linetype_manual(name = "Probability Source", values=c('Observed'= NA, 'Modeled'="dashed"))+
  theme(legend.position =c(0.2,0.8))+
  theme(plot.title=element_text(size=14,face = "bold"),
        legend.title =element_text(size=8,face = "bold"))

# Save
ggsave("../figures/dist_mod.pdf",last_plot())

##---------------------------------------------------------------------

##GAM model for Elevation

## Model for sample points
elev.gam <- mgcv::gam(Persistance~s(Elevation.m), 
                      family = "binomial",
                      method = "REML",
                      data = dat.sub)
## Create predictions with dist.gam model
sample.elev <- seq(750,1680,40) 

my.preds.elev <- predict(elev.gam, 
                         newdata = data.frame(Elevation.m=sample.elev),
                         type = "response")

## Filter data frame to remove Coast distances <10 and >53
dat.sub <- dat.sub %>% filter(Elevation.m > 760 & Elevation.m < 1680) %>%
  mutate(elev.class = cut(Elevation.m,seq(760,1680,40)))

# Create data frame of probability using actual data 
# chunked for distance to coast seq(10,54,1)
dat.sum <- dat.sub %>% group_by(elev.class) %>%
  summarise(algae = sum(Persistance),
            total = length(Persistance),
            algae.prop = algae/total)

# Find the mids of the dataframe to plot
dat.sum$mids <- (seq(760,1680,40)[1:(length(seq(760,1680,40))-1)]+(seq(760,1680,40)[2:(length(seq(760,1680,40)))]))/2

# Plot predicted probability with observed probability 
ggplot(data = data.frame(algae = my.preds.elev, 
                         elev.m = sample.elev), 
       aes(x=elev.m, y = algae))+
  geom_smooth(aes(shape = "Modeled", linetype="Modeled"), method = "gam", color="black", size=.5)+
  geom_point(data = dat.sum, aes(x=mids, y=algae.prop, shape="Observed", linetype = "Observed"), color = "deepskyblue3", size = 2.5)+
  labs(title="Elevation Modeling Preformance",
       y="Probability of Algae Presence", 
       x="Elevation (m)")+
  scale_shape_manual(name = "Probability Source", values=c('Observed'=18, 'Modeled'=NA)) + 
  scale_linetype_manual(name = "Probability Source", values=c('Observed'= NA, 'Modeled'="dashed"))+
  theme(legend.position =c(0.15,0.8))+
  theme(plot.title=element_text(size=14,face = "bold"),
        legend.title =element_text(size=8,face = "bold"))

# Save
ggsave("../figures/elev_mod.pdf",last_plot())

##--------------------------------------------------------------

##GAM slope
## Model for sample points
slope.gam <- mgcv::gam(Persistance~s(slope.deg), 
                       family = "binomial",
                       method = "REML",
                       data = dat.sub)
## Create predictions with dist.gam model
sample.slope <- seq(0,50,2) 

my.preds <- predict(slope.gam, 
                    newdata = data.frame(slope.deg=sample.slope),
                    type = "response")

dat.sub <- dat.sub %>% filter(slope.deg > 0 & slope.deg < 50) %>%
  mutate(slope.class = cut(slope.deg,seq(0,50,2)))

# Create data frame of probability using actual data 
# chunked for distance to coast seq(10,54,1)
dat.sum <- dat.sub %>% group_by(slope.class) %>%
  summarise(algae = sum(Persistance),
            total = length(Persistance),
            algae.prop = algae/total)

# Find the mids of the dataframe to plot
dat.sum$mids <- (seq(0,50,2)[1:(length(seq(0,50,2))-1)]+(seq(0,50,2)[2:(length(seq(0,50,2)))]))/2

# Plot predicted probability with observed probability 
ggplot(data = data.frame(algae = my.preds, 
                         slope.deg = sample.slope), 
       aes(x=slope.deg, y = algae))+
  geom_smooth(aes(shape = "Modeled", linetype="Modeled"), method = "gam", color="black", size=.5)+
  geom_point(data = dat.sum, aes(x=mids, y=algae.prop, shape="Observed", linetype = "Observed"), color = "deepskyblue3", size = 2.5)+
  labs(title="Slope Modeling Preformance",
       y="Probability of Algae Presence", 
       x="Slope (degrees)")+
  scale_shape_manual(name = "Probability Source", values=c('Observed'=18, 'Modeled'=NA)) + 
  scale_linetype_manual(name = "Probability Source", values=c('Observed'= NA, 'Modeled'="dashed"))+
  theme(legend.position =c(0.2,0.8))+
  theme(plot.title=element_text(size=14,face = "bold"),
        legend.title =element_text(size=8,face = "bold"))

# Save
ggsave("../figures/slope_mod.pdf",last_plot())

#--------------------------------------------------------------------

##GAM aspect
## Model for sample points
aspect.gam <- mgcv::gam(Persistance~s(aspect.deg), 
                        family = "binomial",
                        method = "REML",
                        data = dat.sub)
## Create predictions with dist.gam model
sample.aspect <- seq(0,360,10) 

my.preds <- predict(aspect.gam, 
                    newdata = data.frame(aspect.deg=sample.aspect),
                    type = "response")

dat.sub <- dat.sub %>% filter(aspect.deg > 0 & aspect.deg < 360) %>%
  mutate(aspect.class = cut(aspect.deg,seq(0,360,10)))

# Create data frame of probability using actual data 
# chunked for distance to coast seq(10,54,1)
dat.sum <- dat.sub %>% group_by(aspect.class) %>%
  summarise(algae = sum(Persistance),
            total = length(Persistance),
            algae.prop = algae/total)

# Find the mids of the dataframe to plot
dat.sum$mids <- (seq(0,360,10)[1:(length(seq(0,360,10))-1)]+(seq(0,360,10)[2:(length(seq(0,360,10)))]))/2

# Plot predicted probability with observed probability 
ggplot(data = data.frame(algae = my.preds, 
                         aspect.rad = sample.aspect), 
       aes(x=aspect.rad, y = algae))+
  geom_smooth(aes(shape = "Modeled", linetype="Modeled"), method = "gam", color="black", size=.5)+
  geom_point(data = dat.sum, aes(x=mids, y=algae.prop, shape="Observed", linetype = "Observed"), color = "deepskyblue3", size = 2.5)+
  labs(title="Aspect Modeling Preformance",
       y="Probability of Algae Presence", 
       x="Aspect (degrees)")+
  scale_shape_manual(name = "Probability Source", values=c('Observed'=18, 'Modeled'=NA)) + 
  scale_linetype_manual(name = "Probability Source", values=c('Observed'= NA, 'Modeled'="dashed"))+
  theme(legend.position =c(0.2,0.8))+
  theme(plot.title=element_text(size=14,face = "bold"),
        legend.title =element_text(size=8,face = "bold"))
# Save
ggsave("../figures/aspect_mod.pdf",last_plot())

#------------------------------------------------------
#Comparing individual performance
AIC(elev.gam,
    dist.gam,
    slope.gam,
    aspect.gam)

# aspect most reliable individual variable

#---------------------------------------
## Various multi-variable models:
dist.elev.gam <- mgcv::gam(Persistance~s(Coast.Distance.km) + s(Elevation.m), 
                               family = "binomial",
                               method = "REML",
                               data = dat.sub)
summary(dist.elev.gam)
gam.check(dist.elev.gam)

slope.aspect.gam <-mgcv::gam(Persistance~s(aspect.deg) + s(slope.deg), 
                             family = "binomial",
                             method = "REML",
                             data = dat.sub)

summary(slope.aspect.gam)
gam.check(slope.aspect.gam)

minusdist.gam <- mgcv::gam(Persistance~s(Elevation.m) + s(aspect.deg) + s(slope.deg), 
                      family = "binomial",
                      method = "REML",
                      data = dat.sub)

summary(minusdist.gam)
gam.check(minusdist.gam)

minuselev.gam <- mgcv::gam(Persistance~s(Coast.Distance.km) + s(aspect.deg) + s(slope.deg), 
                       family = "binomial",
                       method = "REML",
                       data = dat.sub)

summary(minuselev.gam)
gam.check(minuselev.gam)

all.gam <- mgcv::gam(Persistance~s(Coast.Distance.km) + s(Elevation.m) + s(aspect.deg) + s(slope.deg), 
                     family = "binomial",
                     method = "REML",
                     data = dat.sub)

summary(all.gam)
gam.check(all.gam)

AIC(dist.elev.gam,
    slope.aspect.gam,
    minusdist.gam,
    minuselev.gam,
    all.gam)

##all.gam is the best
#----------------
## Establishing a probability cut off for all.gam model
predictions <- predict(all.gam,
                       type = "response",
                       newdata= binomial.dat)

all.gam.preds.df <- data.frame(predictions, observations = binomial.dat$Persistance)

ROCobj.gam <- rocit(score = all.gam.preds.df$predictions,
                    class = all.gam.preds.df$observations)

plot(ROCobj.gam) ##gives an ROC curve

summary(ROCobj.gam)

##AUC is 0.7352
#-----------------------------------------------------------
accuracy.gam <- measureit(score = all.gam.preds.df$predictions,
                          class = all.gam.preds.df$observations,
                          measure = "ACC")
plot(accuracy.gam$ACC~accuracy.gam$Cutoff, type = "l")

my.roc.gam <- roc(all.gam.preds.df$observations,
                  all.gam.preds.df$predictions)

coords(my.roc.gam,"best",ret="threshold")

##Threshold is 0.347576
abline(v=0.347576, col="red")

gam.cutoff <- all.gam.preds.df %>%
  mutate(roc.cutoff=ifelse(predictions > 0.347576,
                           "Present","Absent"))

gam.cutoff %>% tabyl(roc.cutoff, observations) %>% adorn_percentages()
#------------------------------------
# Plot observed vs modeled
pred.df <- data.frame(long = binomial.dat$long, lat = binomial.dat$lat, predictions=gam.cutoff$roc.cutoff, observations=binomial.dat$Persistance)%>%
  mutate(observations=ifelse(observations > 0,
                           "Present","Absent"))

cols <- c("Present" = "skyblue2", "Absent"="dodgerblue4")

##Observed data
pred.df %>% ggplot(aes(x=long, y=lat))+
  geom_point(aes(col=observations), size = 0.008)+
  labs(col = "")+
  scale_colour_manual(values = cols)+
  labs(title= "Observed Algae Presence", x="Longitude", y="Latitude")+
  theme(plot.title=element_text(size=14,face = "bold"))+
  guides(shape = guide_legend(override.aes = list(size = 2)))+
  guides(color = guide_legend(override.aes = list(size = 2)))+
  theme(legend.title = element_text(size = 12), 
        legend.text = element_text(size = 12))

# Save
ggsave("../figures/observed.pdf",last_plot())

##Predicted data
pred.df %>% ggplot(aes(x=long, y=lat))+
  geom_point(aes(col=predictions), size = 0.008)+
  labs(col = "")+
  scale_colour_manual(values = cols)+
  labs(title= "Predicted Algae Presence", x="Longitude", y="Latitude")+
  theme(plot.title=element_text(size=14,face = "bold"))+
  guides(shape = guide_legend(override.aes = list(size = 2)))+
  guides(color = guide_legend(override.aes = list(size = 2)))+
  theme(legend.title = element_text(size = 12), 
        legend.text = element_text(size = 12))

ggsave("../figures/predicted.pdf",last_plot())
#---------------------------------------------------
##END