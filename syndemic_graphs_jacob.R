########################
library(tidyverse)
library(ggVennDiagram)
library(forcats)

md <- read.csv('masterdata.csv')
codes <- read.csv('codes.csv')
######################## Primary Payer & Total Costs Paid Graph ----

#Sets up an object that groups by primary payer, 
#sums the total costs each payer paid for syndemic patients,
#only saves the top 5,
#and then adds a new column, gov, for if it was funded by the government or not
md2 <- md %>% 
  filter(sud & endo | sstvi) %>% 
  group_by(Primary_Payer_Class_Cd) %>%
  summarise(total = sum(Total_Tot_Chrg)) %>% 
  arrange(desc(total)) %>% 
  head(5) %>% 
  mutate(gov = ifelse(Primary_Payer_Class_Cd %in% c('M','K','J'), TRUE, FALSE))

#Renames the primary payers to their common name
md2$Primary_Payer_Class_Cd <- fct_recode(md2$Primary_Payer_Class_Cd,
             'Medicare' = 'M',
             'Medicare Advantage' = 'K',
             'Self-Pay' = 'P',
             'Blue Care' = 'J',
             'Blue Cross/Blue Shield' = 'B')

#Plots the top 5 primary payers by their costs paid for syndemic patients
ggplot(data = md2, 
       aes(y = total/100000000000, 
           x = reorder(Primary_Payer_Class_Cd, -total), 
           fill = gov ) ) +
  geom_col() +
  labs(title = 'Costs Paid by Top Payers',
       caption = 'End the Syndemic | DataLab 2022',
       x = 'Primary Payer',
       y = 'Cost Paid (in billions of US dollars)',
       subtitle = 'In 2019') +
  scale_fill_manual(md2, values = c('red', 'black'), 
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
  scale_fill_manual(md2, values = c('black', 'red')) +
  theme(legend.position = '0')

########################