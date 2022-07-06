library(tidyverse)
#mdata <- read.csv("m_data.csv")
zips <- read_csv("countybyid.csv")
masterdata <- read.csv("masterdata.csv")
masterdata<-full_join(zips,masterdata, by = "...1" )
masterdata<-masterdata %>% filter(state == "TN")

# ----Sex----
#Calculate the totals for each condition (condition and SUD diagnosis)
#number of osteomyelitis and SUD cases
masterdata %>% 
  filter(ost&sud) %>% 
  tally() 

#number of endocarditis and SUD cases
masterdata %>% 
  filter(endo&sud) %>% 
  tally() 

#number of sepsis and SUD cases
masterdata %>% 
  filter(sepsis&sud) %>% 
  tally()

#number of SSTVI and SUD case
masterdata %>% 
  filter(sstvi&sud) %>% 
  tally()

#Calculate the number of females with osteomyelitis
masterdata %>% 
  filter(ost&sud) %>% 
  filter(Patient_Sex == 'F') %>% 
  tally()

#Calculate the percentage of females with osteomyelitis and SUD diagnosis
(211/617) *100  

#Calculate the number of males with osteomyelitis
masterdata %>% 
  filter(ost&sud) %>% 
  filter(Patient_Sex == 'M') %>% 
  tally()

#Calculate the percentage of males with osteomyelitis and SUD diagnosis 
(406/617) *100 

#Calculate the number of females with endocarditis and SUD diagnosis
masterdata %>% 
  filter(endo&sud) %>% 
  filter(Patient_Sex == 'F') %>% 
  tally()

#Calculate the percentage of females with endocarditis and SUD diagnosis 
(514/932) *100

#Calculate the number of males with endocarditis and SUD diagnosis
masterdata %>% 
  filter(endo&sud) %>% 
  filter(Patient_Sex == 'M') %>% 
  tally()

#Calculate the percentage of males with endocarditis and SUD diagnosis
(418/932) *100

#Calculate the number of females with sepsis and SUD diagnosis 
masterdata %>% 
  filter(sepsis&sud) %>% 
  filter(Patient_Sex == 'F') %>% 
  tally()

#Calculate the percentage of females with sepsis and SUD diagnosis 
(2587/5039) *100

#Calculate the number of males with sepsis and SUD diagnosis
masterdata %>% 
  filter(sepsis&sud) %>% 
  filter(Patient_Sex == 'M') %>% 
  tally()

#Calculate the percentage of males with sepsis and SUD diagnosis
(2451/5039) *100

#Calculate the number of females with SSTVI and SUD diagnosis
masterdata %>% 
  filter(sstvi&sud) %>% 
  filter(Patient_Sex == 'F') %>% 
  tally()

#Calculate the percentage of females with SSTVI and SUD diagnosis 
(4575/9603) *100

#Calculate the number of males with SSTVI and SUD diagnosis 
masterdata %>% 
  filter(sstvi&sud) %>% 
  filter(Patient_Sex == 'M') %>% 
  tally()

#Calculate the percentage of males with SSTVI and SUD diagnosis 
(5027/9603) *100

# ----Race----

# ----Age (years)----
#assigned 89 to >89 so the measures if the middle  could be calculated
masterdata$Age[which(masterdata$Age==">89")] <- 89 
#Make age numeric 
masterdata<-masterdata %>% mutate(Age=as.numeric(Age))

# #Find the median age of people with  osteomyelitis and SUD diagnosis 
# masterdata %>% 
#   filter(ost&sud) %>% 
#   mutate(Age=as.numeric(Age)) %>% 
#   summarise(Median = median(Age, na.rm=TRUE))
#Median of osteomyelitis and SUD diagnosis with age range set to 18-64
masterdata %>% 
  filter(ost&sud) %>% 
  filter(Age>=18) %>% 
  filter(Age<=64) %>% 
  summarize(Median = median(Age, na.rm = TRUE))

# #Find the mean age of people with osteomyelitis and SUD diagnosis
# masterdata %>% 
#   filter(ost&sud) %>% 
#   mutate(Age=as.numeric(Age)) %>% 
#   summarise(Mean = mean(Age, na.rm=TRUE))
#Mean of osteomyelitis and SUD diagnosis with age range set to 18-44
masterdata %>% 
  filter(ost&sud) %>% 
  filter(Age>=18) %>% 
  filter(Age<=64) %>% 
  summarize(Mean = mean(Age, na.rm = TRUE))

#Find the age range of people with osteomyelitis and SUD diagnosis 
#Subtract the smallest value from the largest value
# masterdata %>% 
#   filter(ost&sud) %>% 
#   mutate(Age=as.numeric(Age)) %>% 
#   summarise(Range = range(Age, na.rm=TRUE))
  
# #Find the median age of people with endocarditis and SUD diagnosis
# masterdata %>% 
#   filter(endo&sud) %>% 
#   mutate(Age=as.numeric(Age)) %>% 
#   summarise(Median = median(Age, na.rm=TRUE))
#Median of endocarditis and SUD diagnosis with age range set to 18-44
masterdata %>% 
  filter(endo&sud) %>% 
  filter(Age>=18) %>% 
  filter(Age<=64) %>% 
  summarize(Median = median(Age, na.rm = TRUE))

# #Find the mean age of people with endocarditis and SUD diagnosis
# masterdata %>% 
#   filter(endo&sud) %>% 
#   mutate(Age=as.numeric(Age)) %>% 
#   summarise(Mean = mean(Age, na.rm=TRUE))

#Mean age of people with endocarditis and SUD diagnosis with ages 18-64
masterdata %>% 
  filter(endo&sud) %>% 
  filter(Age>=18) %>% 
  filter(Age<=64) %>% 
  summarize(Mean = mean(Age, na.rm = TRUE))

# #Find the age range of people with endocarditis and SUD diagnosis
# #Subtract the smallest value from the largest value
# masterdata %>%
#   filter(endo&sud) %>%
#   mutate(Age=as.numeric(Age)) %>%
#   summarise(Range = range(Age, na.rm=TRUE))

#Find the median age of people with sepsis and SUD diagnosis
# masterdata %>% 
#   filter(sepsis&sud) %>% 
#   mutate(Age=as.numeric(Age)) %>% 
#   summarise(Median = median(Age, na.rm=TRUE))

#Median age of people with sepsis and SUD ages 18-64
masterdata %>% 
  filter(sepsis&sud) %>% 
  filter(Age>=18) %>% 
  filter(Age<=64) %>% 
  summarize(Median = median(Age, na.rm = TRUE))

# #Find the mean age of people with sepsis and SUD diagnosis.
# masterdata %>% 
#   filter(sepsis&sud) %>% 
#   mutate(Age=as.numeric(Age)) %>% 
#   summarise(Mean = mean(Age, na.rm=TRUE))

#Mean age of people with sepsis and SUD ages 18-64
masterdata %>% 
  filter(sepsis&sud) %>% 
  filter(Age>=18) %>% 
  filter(Age<=64) %>% 
  summarize(Mean = mean(Age, na.rm = TRUE))

# #Find the age range of people with sepsis and SUD diagnosis 
# #Subtract the smallest value from the largest value.
# masterdata %>% 
#   filter(sepsis&sud) %>% 
#   mutate(Age=as.numeric(Age)) %>% 
#   summarise(Range = range(Age, na.rm=TRUE))

# #Find the median age of people with SSTVI and SUD diagnosis
# masterdata %>% 
#   filter(sstvi&sud) %>% 
#   mutate(Age=as.numeric(Age)) %>% 
#   summarise(Median = median(Age, na.rm=TRUE))

#Median age of people with SSTVI and SUD ages 18-64
masterdata %>% 
  filter(sstvi&sud) %>% 
  filter(Age>=18) %>% 
  filter(Age<=64) %>% 
  summarize(Median = median(Age, na.rm = TRUE))

# #Find the mean age of people with SSTVI and SUD diagnosis
# masterdata %>% 
#   filter(sstvi&sud) %>% 
#   mutate(Age=as.numeric(Age)) %>% 
#   summarise(Mean = mean(Age, na.rm=TRUE))

#Mean age with the age range set to 18-64
masterdata %>% 
  filter(sstvi&sud) %>% 
  filter(Age>=18) %>% 
  filter(Age<=64) %>% 
  summarize(Mean = mean(Age, na.rm = TRUE))

# #Find the age range of people with SSTVI and SUD diagnosis
# #Subtract the smallest value from the largest value
# masterdata %>% 
#   filter(sstvi&sud) %>% 
#   mutate(Age=as.numeric(Age)) %>% 
#   summarise(Range = range(Age, na.rm=TRUE))

# ---- Length of Stay (days) ---- 

# ----Disposition ----
#See the way the codes are entered 
# masterdata %>% 
#   pull(Patient_Discharge_Status) %>% 
#   unique() %>% 
#   sort() %>% 
#   print()

#Show the entries as integers
masterdata <-
  masterdata %>% 
  mutate(Patient_Discharge_Status=as.integer(Patient_Discharge_Status, na.rm=TRUE))

#Create vectors for discharged, expired, hospice, and LAMA 
disc <- c(01, 02, 03, 04, 05, 06, 21, 43, 61, 62, 63, 64, 65, 66, 69, 70, 81, 
          82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95)
exp <- c(20, 40, 41, 42)
hos <- c(50, 51)
lama <- c(07)

#Making new columns so it is easier to identify discharge statuses
masterdata<-masterdata %>% mutate(PDS = 
         ifelse(Patient_Discharge_Status %in% disc, 'disc', 
         ifelse(Patient_Discharge_Status %in% exp, 'exp',
         ifelse(Patient_Discharge_Status %in% hos, 'hos', 
         ifelse(Patient_Discharge_Status %in% lama, 'lama','unknown')))))

#Find dispositions of those with SUD and osteomyelitis 
masterdata %>% 
  group_by(PDS) %>% 
  filter(sud&ost) %>% 
  tally()

#Calculate disposition percentages for SUD and osteomyelitis 
(529/617) *100 #Discharged
(4/617) *100 #Expired 
(6/617) *100 #Hospice
(77/617) *100 #LAMA
(1/617) *100 #Unknown

#Find dispositions of those with SUD and endocarditis 
masterdata %>% 
  group_by(PDS) %>% 
  filter(sud&endo) %>% 
  tally()

#Calculate disposition percentages for SUD and endocarditis 
(646/932) *100 #Discharged
(6/932) *100 #Expired
(7/932) *100 #Hospice
(216/932) *100 #LAMA
(1/932) *100 #Unknown

#Find dispositions of those with SUD and sepsis 
masterdata %>% 
  group_by(PDS) %>% 
  filter(sud&sepsis) %>% 
  tally()

#Calculate disposition percentages for SUD and sepsis
(4040/5039) *100 #Discharged 
(257/5039) *100 #Expired 
(88/5039) *100 #Hospice 
(654/5039) *100 #LAMA

#Find dispositions of those with SUD and SSTVI 
masterdata %>% 
  group_by(PDS) %>% 
  filter(sud&sstvi) %>% 
  tally()

#Calculate disposition percentages for SUD and SSTVI
(8025/9603) *100 #Discharged
(267/9603) *100 #Expired
(100/9603) *100 #Hospice
(1207/9603) *100 #LAMA
(4/9603) *100 #Unknown



# ---- Payor(s) ----










 