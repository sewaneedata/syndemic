########################
library(tidyverse)
library(ggVennDiagram)
library(forcats)
library(lubridate)

md <- read_csv('masterdata.csv')
zipid<-read_csv("countybyid.csv")
md<-full_join(zipid,md,by = "...1") %>% filter(state == "TN")

######################## Primary Payer (top 5) & Total Costs Paid Graph ----

#Sets up an object that groups by primary payer, 
#sums the total costs each payer paid for syndemic patients,
#only saves the top 5,
#and then adds a new column, gov, for if it was funded by the government or not
md_top_payers <- md %>% 
  filter(sud, endo | sstvi) %>% 
  group_by(Primary_Payer_Class_Cd) %>%
  summarise(total = sum(Total_Tot_Chrg)) %>% 
  arrange(desc(total)) %>% 
  head(5) %>% 
  mutate(gov = ifelse(Primary_Payer_Class_Cd %in% c('M','K','J', '8'), TRUE, FALSE))

#Renames the primary payers to their common name
md_top_payers$Primary_Payer_Class_Cd <- fct_recode(md_top_payers$Primary_Payer_Class_Cd,
             'Medicare' = 'M',
             'Medicare Advantage' = 'K',
             'Self-Pay' = 'P',
             'Blue Care' = 'J',
             'Americhoice' = '8')

#Plots the top 5 primary payers by their costs paid for syndemic patients
ggplot(data = md_top_payers, 
       aes(y = total/100000000, 
           x = reorder(Primary_Payer_Class_Cd, -total), 
           fill = gov ) ) +
  geom_col() +
  labs(title = 'Total Costs Covered by Top 5 Healthcare Providers',
       subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
       caption = 'End the Syndemic | DataLab 2022',
       x = 'Primary Provider',
       y = 'Cost Paid (in millions of US dollars)') +
  scale_fill_manual(md_top_payers, values = c('#1B365D', '#C11701'), 
                    labels = c('Privately Funded', 'Government Funded', '', '', ''),
                    name = 'Color Legend:') +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 10))

######################## Graph of Government vs Private payers & Cost paid for syndemic patients ----

#creates a object that groups by primary payer, summaries total paid by provider,
#and then adds gov columns to determine if government funded or privately funded
md_big_gov <- md %>% 
  filter(sud, endo | sstvi) %>% 
  group_by(Primary_Payer_Class_Cd) %>% 
  summarise(total = sum(Total_Tot_Chrg)) %>% 
  arrange(desc(total)) %>% 
  mutate(gov = ifelse(Primary_Payer_Class_Cd %in% c('C','D','M','W','N','K','J',11, 12, 8, 10, 'Q', 'T'), 
                      'Government Funded', 
                      'Privately Funded'))

#Plots government vs private total funding for syndemic patients
ggplot(data = md_big_gov, 
       aes(y = total/100000000, 
           x = gov, 
           fill = gov ) ) +
  geom_col() +
  labs(title = 'Total Costs Paid by Government and Private Providers',
       caption = 'End the Syndemic | DataLab 2022',
       subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
       x = 'Primary Payer',
       y = 'Cost Paid (in millions of US dollars)') +
  scale_fill_manual(md_top_payers, values = c('#C11701', '#1B365D')) +
  theme(legend.position = '0')

######################## Venn Diagram of SUDs Patients & Syndemic-Related Illnesses Patients ----

#Creates a list of SUDs & ENDO or SSTVI for the ggvenn package to read
syndemic_list <- 
  list('SUDs' = which(md$sud), 
       'SSTVIs or Endocarditis' = which(md$endo | md$sstvi))

#Creates a venn diagram showing overlap in SUDS and syndemic related ICD-10s
ggVennDiagram(syndemic_list,
              label_size = 4,
              label_alpha = 0.3,
              label = c('count')) +
  theme(legend.position = '0') +
  labs(title = 'Hospitalization overlap for substance use disorder (SUDs) and infectious sequela of interest',
       subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
       caption = 'End the Syndemic | DataLab 2022') +
  scale_color_manual(values = c('black','black')) +
  scale_fill_gradientn(colors = c('#555555', '#C11701', '#555555', '#1B365D'))

######################## Trends in hospitalization incidence rates by age group ----

#Reads in the private health info version of our dataset
md_phi <- read.csv('masterdataphi.csv')
zips<-read_csv("zip_code_database.csv")
zips<-zips%>% select(zip,state,county)
zips<-zips %>% rename(Patient_Zip = zip)
d<-full_join(md_phi,zips, by = "Patient_Zip")
md_phi<-d %>% distinct(...1, .keep_all = TRUE) %>% filter(state == "TN")

#Formats data, adds a months column, makes an age groups column and then a quarter columns for the year
md_phi_jacob <- 
  md_phi %>% 
  mutate(creation_dt = mdy(creation_dt)) %>% 
  mutate(months = month(creation_dt)) %>% 
  mutate(Age_Groups = ifelse(Age %in% 0:17, '0-17', 
                             ifelse(Age %in% 18:24, '18-24',
                                    ifelse(Age %in% 25:34, '25-34',
                                           ifelse(Age %in% 35:44, '35-44',
                                                  ifelse(Age %in% 45:54, '45-54',
                                                         ifelse(Age %in% 55:64, '55-64', '65+'))))))) %>% 
  mutate(quarter = ifelse(months %in% 1:3, 1,
                          ifelse(months %in% 4:6, 2,
                                 ifelse(months %in% 7:9, 3, 4)))) 


#Plots SUDS and endo
ggplot(data = md_phi_jacob %>% 
         filter(!Age_Groups == '65+', !Age_Groups == '0-17', sud&endo) %>% 
         group_by(Age_Groups, quarter) %>% 
         tally(),
      aes(x = quarter,
          y = n,
          color = Age_Groups)) +
  geom_point() +
  geom_line() +
  labs(title = 'Trends in Hospitalization for Substance Abuse and Endocarditis',
       subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
       caption = 'End the Syndemic | DataLab 2022',
       x = 'Yearly Quarter',
       y = 'Total Patients') +
  scale_color_manual(values = c('#C11701', '#B1B1B1', '#1B365D', '#9A77C7', '#91BAA7'))

#Plots SUDS and osteo
ggplot(data = md_phi_jacob %>% 
         filter(!Age_Groups == '65+', !Age_Groups == '0-17', sud&ost) %>% 
         group_by(Age_Groups, quarter) %>% 
         tally(),
       aes(x = quarter,
           y = n,
           color = Age_Groups)) +
  geom_point() +
  geom_line() +
  labs(title = 'Trends in Hospitalization for Substance Abuse and Ostemyelitis',
       subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
       caption = 'End the Syndemic | DataLab 2022',
       x = 'Yearly Quarter',
       y = 'Total Patients') +
  scale_color_manual(values = c('#C11701', '#B1B1B1', '#1B365D', '#9A77C7', '#91BAA7'))

#Plots SUDS and sepsis
ggplot(data = md_phi_jacob%>% 
         filter(!Age_Groups == '65+', !Age_Groups == '0-17', sud&sepsis) %>% 
         group_by(Age_Groups, quarter) %>% 
         tally(),
       aes(x = quarter,
           y = n,
           color = Age_Groups)) +
  geom_point() +
  geom_line() +
  labs(title = 'Trends in Hospitalization for Substance Abuse and Sepsis',
       subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
       caption = 'End the Syndemic | DataLab 2022',
       x = 'Yearly Quarter',
       y = 'Total Patients') +
  scale_color_manual(values = c('#C11701', '#B1B1B1', '#1B365D', '#9A77C7', '#91BAA7'))

#Plots SUDS and sstvi
ggplot(data = md_phi_jacob %>% 
         filter(!Age_Groups == '65+', !Age_Groups == '0-17', sud&sstvi) %>% 
         group_by(Age_Groups, quarter) %>% 
         tally(),
       aes(x = quarter,
           y = n,
           color = Age_Groups)) +
  geom_point() +
  geom_line() +
  labs(title = 'Trends in Hospitalization for Substance Abuse and all SSTVIs',
       subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
       caption = 'End the Syndemic | DataLab 2022',
       x = 'Yearly Quarter',
       y = 'Total Patients') +
  scale_color_manual(values = c('#C11701', '#B1B1B1', '#1B365D', '#9A77C7', '#91BAA7'))

#Plots SUDS and SSTVI or Endo
ggplot(data = md_phi_jacob %>% 
         filter(!Age_Groups == '65+', !Age_Groups == '0-17', sud, endo | sstvi) %>% 
         group_by(Age_Groups, quarter) %>% 
         tally(),
       aes(x = quarter,
           y = n,
           color = Age_Groups)) +
  geom_point() +
  geom_line() +
  labs(title = 'Trends in Hospitalization for Substance Abuse and all SSTVIs or Endocarditis',
       subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
       caption = 'End the Syndemic | DataLab 2022',
       x = 'Yearly Quarter',
       y = 'Total Patients') +
  scale_color_manual(values = c('#C11701', '#B1B1B1', '#1B365D', '#9A77C7', '#91BAA7'))

######################## Trends in hospitalization costs (in dollars) ----

#Adds a gov column, private or publicly funded, to md_phi
md_phi_jacob <- md_phi_jacob %>%
  mutate(gov = ifelse(Primary_Payer_Class_Cd %in% c('C','D','M','W','N','K','J',11, 12, 8, 10, 'Q', 'T'), 
                      'Government Funded', 
                      'Privately Funded'))

#Changes format of # from exponential to normal
options(scipen = 999)

#Plots SUDS and endo
ggplot(data = md_phi_jacob %>% 
         filter(sud,endo),
       aes(x = quarter,
           y = Total_Tot_Chrg/100,
           fill = gov)) +
  geom_col(position = 'dodge') +   
  labs(title = 'Trends in Costs for Substance Abuse and Endocarditis',
                      subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
                      caption = 'End the Syndemic | DataLab 2022',
                      x = 'Yearly Quarter',
                      y = 'Cost (In US Dollars)',
       fill = 'Primary Payer:') +
  theme(legend.position = 'bottom') +
  scale_fill_manual(values = c('#C11701', '#1B365D'))

#Plots SUDS and ost
ggplot(data = md_phi_jacob %>% 
         filter(sud, ost),
       aes(x = quarter,
           y = Total_Tot_Chrg/100,
           fill = gov)) +
  geom_col(position = 'dodge') +
  labs(title = 'Trends in Costs for Substance Abuse and Osteomyelitis',
                      subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
                      caption = 'End the Syndemic | DataLab 2022',
                      x = 'Yearly Quarter',
                      y = 'Cost (In US Dollars)',
       fill = 'Primary Payer:') +
  theme(legend.position = 'bottom') +
  scale_fill_manual(values = c('#C11701', '#1B365D'))

#Plots SUDS and sepsis
ggplot(data = md_phi_jacob %>% 
         filter(sud, sepsis),
       aes(x = quarter,
           y = Total_Tot_Chrg/100,
           fill = gov)) +
  geom_col(position = 'dodge') +
  labs(title = 'Trends in Costs for Substance Abuse and Sepsis',
                      subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
                      caption = 'End the Syndemic | DataLab 2022',
                      x = 'Yearly Quarter',
                      y = 'Cost (In US Dollars)',
       fill = 'Primary Payer:') +
  theme(legend.position = 'bottom') +
  scale_fill_manual(values = c('#C11701', '#1B365D'))


#Plots SUDS and SSTVIs
ggplot(data = md_phi_jacob %>% 
         filter(sud, sstvi),
       aes(x = quarter,
           y = Total_Tot_Chrg/100,
           fill = gov)) +
  geom_col(position = 'dodge') +
  labs(title = 'Trends in Costs for Substance Abuse and all SSTVIs',
                      subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
                      caption = 'End the Syndemic | DataLab 2022',
                      x = 'Yearly Quarter',
                      y = 'Cost (In US Dollars)',
       fill = 'Primary Payer:') +
  theme(legend.position = 'bottom') +
  scale_fill_manual(values = c('#C11701', '#1B365D'))
  
#Plots SUDS and SSTVIs or Endo
ggplot(data = md_phi_jacob %>% 
         filter(sud, sstvi|endo),
       aes(x = quarter,
           y = Total_Tot_Chrg/100,
           fill = gov)) +
  geom_col(position = 'dodge') +
  labs(title = 'Trends in Costs for Substance Abuse and Endocarditis or a SSTVI',
       subtitle = 'TN Hospitals 2019 | Inpatient and Outpatient',
       caption = 'End the Syndemic | DataLab 2022',
       x = 'Yearly Quarter',
       y = 'Cost (In US Dollars)',
       fill = 'Primary Payer:') +
  theme(legend.position = 'bottom') +
  scale_fill_manual(values = c('#C11701', '#1B365D'))

######################## Unfiltered data glance (WIP)----

#loads unfiltered data
dataphi <- read_csv("dataphi.csv")

########################
