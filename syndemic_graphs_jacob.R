########################
library(tidyverse)
library(ggVennDiagram)
library(forcats)

md <- read.csv('masterdata.csv')
######################## Primary Payer (top 5) & Total Costs Paid Graph ----

#Sets up an object that groups by primary payer, 
#sums the total costs each payer paid for syndemic patients,
#only saves the top 5,
#and then adds a new column, gov, for if it was funded by the government or not
md_top_payers <- md %>% 
  filter(sud & endo | sstvi) %>% 
  group_by(Primary_Payer_Class_Cd) %>%
  summarise(total = sum(Total_Tot_Chrg)) %>% 
  arrange(desc(total)) %>% 
  head(5) %>% 
  mutate(gov = ifelse(Primary_Payer_Class_Cd %in% c('M','K','J'), TRUE, FALSE))

#Renames the primary payers to their common name
md_top_payers$Primary_Payer_Class_Cd <- fct_recode(md_top_payers$Primary_Payer_Class_Cd,
             'Medicare' = 'M',
             'Medicare Advantage' = 'K',
             'Self-Pay' = 'P',
             'Blue Care' = 'J',
             'Blue Cross/Blue Shield' = 'B')

#Plots the top 5 primary payers by their costs paid for syndemic patients
ggplot(data = md_top_payers, 
       aes(y = total/100000000000, 
           x = reorder(Primary_Payer_Class_Cd, -total), 
           fill = gov ) ) +
  geom_col() +
  labs(title = 'Costs Paid by Top Payers',
       caption = 'End the Syndemic | DataLab 2022',
       x = 'Primary Payer',
       y = 'Cost Paid (in billions of US dollars)',
       subtitle = 'In 2019') +
  scale_fill_manual(md_top_payers, values = c('red', 'black'), 
                    labels = c('Privately Funded', 'Government Funded', '', '', ''),
                    name = 'Color Legend:') +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 10))

######################## Graph of Government vs Private payers & Cost paid for syndemic patients ----

#creates a object that groups by primary payer, summaries total paid by provider,
#and then adds gov columns to determine if government funded or privately funded
md_big_gov <- md %>% 
  filter(sud & endo | sstvi) %>% 
  group_by(Primary_Payer_Class_Cd) %>% 
  summarise(total = sum(Total_Tot_Chrg)) %>% 
  arrange(desc(total)) %>% 
  mutate(gov = ifelse(Primary_Payer_Class_Cd %in% c('C','D','M','W','N','K','J',11, 12, 8, 10, 'Q', 'T'), 
                      'Government Funded', 
                      'Privately Funded'))

#Plots government vs private total funding for syndemic patients
ggplot(data = md_big_gov, 
       aes(y = total/100000000000, 
           x = gov, 
           fill = gov ) ) +
  geom_col() +
  labs(title = 'Costs Paid by the Government vs Commercial Providers',
       caption = 'End the Syndemic | DataLab 2022',
       x = 'Primary Payer',
       y = 'Cost Paid (in billions of US dollars)',
       subtitle = 'In 2019') +
  scale_fill_manual(md_top_payers, values = c('black', 'red')) +
  theme(legend.position = '0')

######################## Venn Diagram of SUDs Patients & Syndemic-Related Illnesses Patients

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
  labs(caption = 'End the Syndemic | DataLab 2022',
       title = 'Hospitalizations overlap for substance use disorder (SUDs) and infectious sequela of interest',
       subtitle = 'TN Hospitals 2019') +
  scale_fill_distiller(palette = "OrRd", direction = 1) +
  scale_color_brewer(palette = "Set2")

######################## Trends in hospitalization incidence rates by age group ----

ggplot(data = md %>% 
         mutate(Age_Groups = ifelse(Age %in% 0:17, '0-17', 
                                    ifelse(Age %in% 18:24, '18-24',
                                           ifelse(Age %in% 25:34, '25-34',
                                                  ifelse(Age %in% 35:44, '35-44',
                                                         ifelse(Age %in% 45:54, '45-54',
                                                                ifelse(Age %in% 55:64, '55-64', '65+'))))))) %>% 
         mutate(quarter = ifelse(creation_dt %in% 1:3, Q1,
                                 ifelse(creation_dt %in% 4:6, Q2,
                                        ifelse(creation_dt %in% 7:9, Q3, Q4)))),
      aes(x = quarter,
          color = Age)) +
  geom_line()

######################## Trends in hospitalization costs (in dollars) ----
