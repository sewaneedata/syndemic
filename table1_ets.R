library(tidyverse)
mdata <- read.csv("m_data.csv")
masterdata <- read.csv("masterdata")


# ----Sex----
#Calculate the totals for each condition (condition and SUD diagnosis)
masterdata %>% 
  filter(ost&sud) %>% 
  tally() #number of osteomyelitis and SUD cases

masterdata %>% 
  filter(endo&sud) %>% 
  tally() #number of endocarditis and SUD cases

masterdata %>% 
  filter(sepsis&sud) %>% 
  tally() #number of sepsis and SUD cases

masterdata %>% 
  filter(sstvi&sud) %>% 
  tally() #number of SSTVI and SUD cases

#Calculate the number of females with osteomyelitis
masterdata %>% 
  filter(ost&sud) %>% 
  filter(Patient_Sex == 'F') %>% 
  tally()

#Calculate the percentage of females with osteomyelitis and SUD diagnosis
(242/692) *100 #round up to 35% 

#Calculate the number of males with osteomyelitis
masterdata %>% 
  filter(ost&sud) %>% 
  filter(Patient_Sex == 'M') %>% 
  tally()

#Calculate the percentage of males with osteomyelitis and SUD diagnosis 
(450/692) *100 

#Calculate the number of females with endocarditis and SUD diagnosis
masterdata %>% 
  filter(endo&sud) %>% 
  filter(Patient_Sex == 'F') %>% 
  tally()

#Calculate the percentage of females with endocarditis and SUD diagnosis 
(555/1008) *100

#Calculate the number of males with endocarditis and SUD diagnosis
masterdata %>% 
  filter(endo&sud) %>% 
  filter(Patient_Sex == 'M') %>% 
  tally()

#Calculate the percentage of males with endocarditis and SUD diagnosis
(453/1008) *100

#Calculate the number of females with sepsis and SUD diagnosis 
masterdata %>% 
  filter(sepsis&sud) %>% 
  filter(Patient_Sex == 'F') %>% 
  tally()

#Calculate the percentage of females with sepsis and SUD diagnosis 
(2856/5572) *100

#Calculate the number of males with sepsis and SUD diagnosis
masterdata %>% 
  filter(sepsis&sud) %>% 
  filter(Patient_Sex == 'M') %>% 
  tally()

#Calculate the percentage of males with sepsis and SUD diagnosis
(2715/5572) *100

#Calculate the number of females with SSTVI and SUD diagnosis
masterdata %>% 
  filter(sstvi&sud) %>% 
  filter(Patient_Sex == 'F') %>% 
  tally()

#Calculate the percentage of females with SSTVI and SUD diagnosis 
(5004/10511) *100

#Calculate the number of males with SSTVI and SUD diagnosis 
masterdata %>% 
  filter(sstvi&sud) %>% 
  filter(Patient_Sex == 'M') %>% 
  tally()

#Calculate the percentage of males with SSTVI and SUD diagnosis 
(5506/10510) *100

# ----Race----

# ----Age (years)----
#assigned 89 to >89 so the measures if the middle  could be calculated
masterdata$Age[which(masterdata$Age==">89")] <- 89 

#Find the median age of people with  osteomyelitis and SUD diagnosis 
masterdata %>% 
  filter(ost&sud) %>% 
  mutate(Age=as.numeric(Age)) %>% 
  summarise(Median = median(Age, na.rm=TRUE))

#Find the mean age of people with osteomyelitis and SUD diagnosis
masterdata %>% 
  filter(ost&sud) %>% 
  mutate(Age=as.numeric(Age)) %>% 
  summarise(Mean = mean(Age, na.rm=TRUE))

#Find the age range of people with osteomyelitis and SUD diagnosis 
#Subtract the smallest value from the largest value
masterdata %>% 
  filter(ost&sud) %>% 
  mutate(Age=as.numeric(Age)) %>% 
  summarise(Range = range(Age, na.rm=TRUE))
  
#Find the median age of people with endocarditis and SUD diagnosis
masterdata %>% 
  filter(endo&sud) %>% 
  mutate(Age=as.numeric(Age)) %>% 
  summarise(Median = median(Age, na.rm=TRUE))

#Find the mean age of people 