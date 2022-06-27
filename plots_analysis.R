######################## Libraries and Data sets ####################
# June 27rd 2022 | Start of exploration!
#####################################################################
library(tidyverse)
library(ggthemes)

setwd("D:/DataLab/syndemic")
data<-read_csv("mdata.csv")

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



  
  
