library(tidyverse)
library(tidyr)
mdata <- read.csv("m_data.csv")
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

(1/5039) *100 #Unknown sex sepsis percentage

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

(1/9603) *100 #Unknown sex SSTVI percentage 

# ---- Race ----
#First, the "Patient_Race_Ethnicity" column needs to be split.
#Creating a new data frame with race nand ethnicity separated
raceData <- masterdata %>% 
  separate(Patient_Race_Ethnicity, 
  c('Patient_Race', 'Patient_Ethnicity'),sep=1)

#Find SUD and osteomyelitis patients' races
raceData %>% 
  filter(sud&ost) %>% 
  group_by(Patient_Race) %>% 
  tally()

#Calculate race percentages for SUD and osteomyelitis patients 
(499/617) *100 #White (1)
(107/617) *100 #Black (2)
(7/617) *100 #Other (5)
(4/617) *100 #Unknown (9)

#Find SUD and endocarditis patients' races
raceData %>% 
  filter(sud&endo) %>% 
  group_by(Patient_Race) %>% 
  tally()

#Calculate race percentages for SUD and endocarditis patients
(867/932) *100 #White (1)
(43/932) *100 #Black (2)
(15/932) *100 #Other (5)
(7/932) *100 #Unknown (9)

#Find SUD and sepsis patients' races
raceData %>% 
  filter(sud&sepsis) %>% 
  group_by(Patient_Race) %>% 
  tally()

#Calculate race percentages for SUD and sepsis patients
(4334/5039) *100 #White (1)
(611/5039) *100 #Black (2)
(1/5039) *100 #Native American (3) 
(4/5039) *100 #Asian or Pacific Islander (4) 
(48/5039) *100 #Other (5)
(41/5039) *100 #Unknown (9)

#Find SUD and SSTVI patients' races 
raceData %>% 
  filter(sud&sstvi) %>% 
  group_by(Patient_Race) %>% 
  tally()

#Calculate race percentages for SUD and SSTVI patients
(8445/9603) *100 #White (1)
(998/9603) *100 #Black (2)
(2/9603) *100 #Native American (3)
(6/9603) *100 #Asian or Pacific Islander (4)
(75/9603) *100 #Other (5)
(77/9603) *100 #Unknown (9)

# ---- Ethnicity ----
#Find SUD and osteomyelitis patients' ethnicity 
raceData %>% 
  filter(sud&ost) %>% 
  group_by(Patient_Ethnicity) %>% 
  tally()

#Calculate ethnicity percentages for SUD and osteomyelitis patients
(2/617) *100 #Hispanic 
(610/617) *100 #Non-Hispanic 
(5/617) *100 #Hispanic origin unknown

#Find SUD and endocarditis patients' ethnicity 
raceData %>% 
  filter(sud&endo) %>% 
  group_by(Patient_Ethnicity) %>% 
  tally()

#Calculate ethnicity percentages for SUD and endocarditis patients
(5/932) *100 #Hispanic 
(915/932) *100 #Non-Hispanic 
(12/932) *100 #Hispanic origin unknown

#Find SUD and sepsis patients' ethnicity
raceData %>% 
filter(sud&sepsis) %>% 
  group_by(Patient_Ethnicity) %>% 
  tally()

#Calculate ethnicity percentages for SUD and sepsis patients
(35/5039) *100 #Hispanic
(4923/5039) *100 #Non-hispanic
(81/5039) *100 #Hispanic origin unknown

#Find SUD and SSTVI patients' ethnicity 
raceData %>% 
  filter(sud&sstvi) %>% 
  group_by(Patient_Ethnicity) %>% 
  tally()

#Calculate ethnicity percentages for SUD and SSTVI patients
(74/9603) *100
(9394/9603) *100
(135/9603) *100

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

#Find the mean age of people with osteomyelitis and SUD diagnosis
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

# ---- Disposition ----
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
#Create vectors for each (primary) payor type
medicaid <- c('8','10','J', 'Q', 'T','D')
medicare <- c('K', 'M')
private <- c('H', 'L', 'I', 'B')
self <- c('P')
othergov <- c('C', 'N', 'W', '11', '12', '13')
other <- c('O', 'S', 'Z')

#Making new columns so it is easier to identify the primary payor type 
masterdata <- masterdata %>% mutate(pripayor =
          ifelse(Primary_Payer_Class_Cd %in% medicaid, 'medicaid', 
          ifelse(Primary_Payer_Class_Cd %in% medicare, 'medicare', 
          ifelse(Primary_Payer_Class_Cd %in% private, 'private',
          ifelse(Primary_Payer_Class_Cd %in% self, 'self',
          ifelse(Primary_Payer_Class_Cd %in% othergov, 'othergov',
          ifelse(Primary_Payer_Class_Cd %in% other, 'other', 'unknown')))))))
                                      
#Find primary payor for those with SUD and osteomyelitis 
masterdata %>% 
  group_by(pripayor) %>% 
  filter(sud&ost) %>% 
  tally()

#Calculate payor percentages for SUD and osteomyelitis 
(184/617) *100 #Medicaid 
(230/617) *100 #Medicare 
(21/617) *100 #Private 
(151/617) *100 #Self Pay
(6/617) *100 #Other Government 
(16/617) *100 #Other
(9/617) *100 #Unknown

#Find primary payor for those with SUD and endocarditis
masterdata %>% 
  group_by(pripayor) %>% 
  filter(sud&endo) %>% 
  tally()

#Calculate payor percentages for SUD and endocarditis 
(327/617) *100 #Medicaid 
(84/617) *100 #Medicare
(47/617) *100 #Private
(381/617) *100 #Self Pay
(24/617) *100 #Other Government 
(54/617) *100 #Other 
(15/617) *100 #Unknown

#Find primary payor for those with SUD and sepsis 
masterdata %>% 
  group_by(pripayor) %>% 
  filter(sud&sepsis) %>% 
  tally()

#Calculate payor percentages for SUD and sepsis
(1340/5039) *100 #Medicaid
(1446/5039) *100 #Medicare
(340/5039) *100 #Private 
(1496/5039) *100 #Self Pay 
(83/5039) # Other government
(205/5039) #Other
(129/5039) #Unknown

#Find primary payor for those with SUD and SSTVI
masterdata %>% 
  group_by(pripayor) %>% 
  filter(sud&sstvi) %>% 
  tally()

#Calculate payor percentages for SUD and SSTVI
(2589/9603) *100 #Medicaid
(2331/9603) *100 #Medicare
(581/9603) *100 #Private
(3334/9603) *100 #Self Pay 
(159/9603) *100 #Other Government
(379/9603) *100 #Other
(230/9603) *100 #Unknown

# ---- Total Charge (dollars) ----
#Total cost of SUD and osteomyelitis care
masterdata %>% 
  filter(sud&ost) %>%
  summarise(ostTotal=sum(Total_Tot_Chrg/100))

#Median cost of SUD osteomyelitis care 
masterdata %>% 
  filter(sud&ost) %>%
  summarise(ostMedian=median(Total_Tot_Chrg/100))

#Mean cost of SUD and osteomyelitis care 
masterdata %>% 
  filter(sud&ost) %>%
  summarise(ostMean=mean(Total_Tot_Chrg/100))

#Range of costs for SUD and osteomyelitis care
masterdata %>% 
  filter(sud&ost) %>%
  summarise(ostRange=range(Total_Tot_Chrg/100))

#Total cost of SUD and endocarditis care 
masterdata %>% 
  filter(sud&endo) %>%
  summarise(endoTotal=sum(Total_Tot_Chrg/100))

#Median cost of SUD and endocarditis care 
masterdata %>% 
  filter(sud&endo) %>%
  summarise(endoMedian=median(Total_Tot_Chrg/100))

#Mean cost of SUD and endocarditis care 
masterdata %>% 
  filter(sud&endo) %>%
  summarise(endoMean=mean(Total_Tot_Chrg/100))

#Range of costs for SUD and endocarditis care
masterdata %>% 
  filter(sud&endo) %>%
  summarise(endoRange=range(Total_Tot_Chrg/100))

#Total cost of SUD and sepsis care 
masterdata %>% 
  filter(sud&sepsis) %>%
  summarise(sepsisTotal=sum(Total_Tot_Chrg/100))

#Median cost of SUD and sepsis care 
masterdata %>% 
  filter(sud&sepsis) %>%
  summarise(sepsisMedian=median(Total_Tot_Chrg/100))

#Mean cost of SUD and sepsis care
masterdata %>% 
  filter(sud&sepsis) %>%
  summarise(sepsisMean=mean(Total_Tot_Chrg/100))

#Range of costs for SUD and sepsis care 
masterdata %>% 
  filter(sud&sepsis) %>% 
  summarise(sepsisRange=range(Total_Tot_Chrg/100))

#Total cost of SUD and SSTVI care 
masterdata %>% 
  filter(sud&sstvi) %>% 
  summarise(SSTVITotal=sum(Total_Tot_Chrg/100))

#Median cost of SUD and SSTVI care 
masterdata %>% 
  filter(sud&sstvi) %>% 
  summarise(SSTVIMedian=median(Total_Tot_Chrg/100))

#Mean cost of SUD and SSTVI care 
masterdata %>% 
  filter(sud&sstvi) %>% 
  summarise(SSTVIMean=mean(Total_Tot_Chrg/100))


#Range of costs for SUD and SSTVI care
masterdata %>% 
  filter(sud&sstvi) %>% 
  summarise(SSTVIRange=range(Total_Tot_Chrg/100))





 