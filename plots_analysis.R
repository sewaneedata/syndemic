######################## Libraries and Data sets ####################
# June 27rd 2022 | Start of exploration!
#####################################################################
library(tidyverse)
library(gsheet)
library(ggthemes)
library(leaflet)
library(leaflet.extras)

setwd("D:/DataLab/syndemic")
data<-read_csv("masterdata.csv")
code<-read_csv("codes.csv")

# First decent graph hopefully
zip<-data %>% filter(TN_Res_Flag == "Y") %>% 
  group_by(Patient_Zip) %>%
  summarise(total = sum(Total_Tot_Chrg)) %>%
  arrange(desc(total)) %>%
  head(15)

# First helpful graph 
ggplot(data = zip, aes( x = reorder(Patient_Zip,-total) , y = total/100000000000, fill = total)) + 
  geom_bar( stat = "identity" ) +
  theme_clean() +
  theme(axis.text.x = element_text(angle = 90)) +
  labs( title = "Top 20 Zip codes with highest total charges",
        subtitle = "Tennessee",
        caption = "End The Syndemic | DataLab 2022") +
  xlab("Anonymized Zipcode") +
  ylab("Total (In Billions)") +
  theme(legend.position = "none")

#
data %>% filter(sud) %>% tally()

# Map of SEP trial run
locations<-gsheet2tbl("https://docs.google.com/spreadsheets/d/1sb4P_7-UkcpkmENZ_DpMI45wRY7oItIFbv-0suLmz7U/edit?usp=sharing")
library(dplyr)
library(readr)
library(ggplot2)
library(leaflet)
library(rgdal)
library(raster)
library(sp)
library(rasterVis)
library(htmltools)
library(RColorBrewer)
library(geosphere)
library(tigris)
library(ggmap)


options(tigris_use_cache = TRUE)
temp <- tigris::zctas(starts_with = 370:385)
tnz <-  as(temp, 'Spatial')

leaflet() %>%
  addProviderTiles(providers$OpenStreetMap) %>%
  addMarkers(data = locations, label = locations$address)  

qmap('Tennessee')
  
  

