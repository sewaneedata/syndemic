######################## Libraries and Data sets ####################
# June 23rd 2022 | Start of exploration and cleaning!
#####################################################################
library(tidyverse)
library(stringr)
library(gsheet)

setwd("~/Desktop/Syndemic Project")
codes <- read_csv("./syndemic/codes.csv")
#####################################################################
# This data is already filtered for choosen column values!
data<-read_csv("impdataphi.csv")
#####################################################################
# New Correct way of cleaning data-----------------------------------
# Clean more, get rid of some more columns
data<-data %>% select(-starts_with("HCPC_Rate"),
                            -Tot_Charges_Summed,
                            -Tot_Charges_Analysis,
                            -Tot_Charges_Recorded,
                            -Obs_Unit_Flag,
                            -CostWt,
                            -starts_with("Proc"),
                            -Bill_Number,
                            -Record_Seq_Num,
                            -Form_Type,
                            -Accident_Code,
                            -Admit_Diag_Cd
)

write_csv(data, "mdall.csv")

# Making all diagnosis into one column!
# For all data change all trainpl into data
trainpl<-data %>% 
  select( ...1,
          Diag1:Diag18
  )
trainpl<-trainpl %>% pivot_longer(starts_with("Diag"))

# Get codes that tell us with what it should start with
swv<-codes %>% filter(astrid) %>% pull(code)

# Look for any person id that has codes that start with any of our start with patterns
swfinal<-trainpl %>%
  filter(substr(value,1,3) %in% swv )%>%
  filter( !(substr(value,1,1) == "T" & (substr(value,nchar(value)-1,nchar(value)-1)=="5"|substr(value,nchar(value)-1,nchar(value)-1)=="6" )))
# This last filter is for the special T codes where the second to last character
# can't be a 5 or 6. I generalized and saw that most codes where 7 characters long
# so I used substr to look at the 6th character and made sure it didn't equal

# Get codes that are fixed and we only want them to match that specific code
fixedv<-codes %>% filter(!astrid) %>% pull(code)

# Look for any person id that has code that matches any of our fixed codes
fixedfinal<-trainpl %>% filter(value %in% fixedv)

# Make the patient ids in vectors and join them
fidv<-c(pull(fixedfinal,...1), pull(swfinal,...1))
fidv<-unique(fidv)

# Get person with ids that we got and care about
cleands<-data %>% filter( ...1 %in% fidv)

# # Clean more, get rid of some more columns
# cleands<-cleands %>% select(-starts_with("HCPC_Rate"),
#                             -Tot_Charges_Summed,
#                             -Tot_Charges_Analysis,
#                             -Tot_Charges_Recorded,
#                             -Obs_Unit_Flag,
#                             -CostWt,
#                             -starts_with("Proc"),
#                             -Bill_Number,
#                             -Record_Seq_Num,
#                             -Form_Type,
#                             -Accident_Code,
#                             -Admit_Diag_Cd
# )
# Add boolean value for SUD------------------------------------------
syndata<-cleands

synpl<-syndata %>% 
  select( ...1,
          Diag1:Diag18
  )
synpl<-synpl %>% pivot_longer(starts_with("Diag"))
# Vector of sud codes that we need to find starts with
sudcode_a<-codes %>% filter(sud) %>% filter(astrid) %>% pull(code)
# Vector of sud codes that we need to find fixed
sudcode_f<-codes %>% filter(sud) %>% filter(!astrid) %>% pull(code)
# pull ids that match one of these
sudids<- synpl %>% filter(value %in% sudcode_f | substr(value,1,3) %in% sudcode_a) %>%
  filter( !(substr(value,1,1) == "T" & (substr(value,nchar(value)-1,nchar(value)-1)=="5"|substr(value,nchar(value)-1,nchar(value)-1)=="6" ))) %>% 
  pull(...1) %>% unique()
# Add column that says true if id is in this vector
syndata<-syndata %>% mutate(sud = ifelse(...1 %in% sudids, TRUE, FALSE))

# Add boolean value for ENDO-----------------------------------------
# Vector of sendo codes that we need to find fixed
endocode_f<-codes %>% filter(endo) %>% pull(code)
# pull ids that match one of these
endoids<- synpl %>% filter(value %in% endocode_f) %>%
  pull(...1) %>% unique()
# Add column that says true if id is in this vector
syndata<-syndata %>% mutate(endo = ifelse(...1 %in% endoids, TRUE, FALSE))

# Add boolean value for SSTVI----------------------------------------
# Vector of sstvi codes that we need to find starts with
sstcode_a<-codes %>% filter(sstvi) %>% filter(astrid) %>% pull(code)
# Vector of sstvi codes that we need to find fixed
sstcode_f<-codes %>% filter(sstvi) %>% filter(!astrid) %>% pull(code)
# pull ids that match one of these
sstids<- synpl %>% filter(value %in% sstcode_f | substr(value,1,3) %in% sstcode_a) %>%
  pull(...1) %>% unique()
# Add column that says true if id is in this vector
syndata<-syndata %>% mutate(sstvi = ifelse(...1 %in% sstids, TRUE, FALSE))

# Add boolean values for Ost-----------------------------------------
# Vector of ost codes that we need to find starts with
ostcode_a<-codes %>% filter(osteomyelitis) %>% filter(astrid) %>% pull(code)
# Vector of ost codes that we need to find fixed
ostcode_f<-codes %>% filter(osteomyelitis) %>% filter(!astrid) %>% pull(code)
# pull ids that match one of these
ostids<- synpl %>% filter(value %in% ostcode_f | substr(value,1,3) %in% ostcode_a) %>%
  pull(...1) %>% unique()
# Add column that says true if id is in this vector
syndata<-syndata %>% mutate(ost = ifelse(...1 %in% ostids, TRUE, FALSE))

# Add boolean value for Sepsis---------------------------------------
# Vector of sepsis codes that we need to find starts with
sepcode_a<-codes %>% filter(sepsis) %>% filter(astrid) %>% pull(code)
# Vector of sepsis codes that we need to find fixed
sepcode_f<-codes %>% filter(sepsis) %>% filter(!astrid) %>% pull(code)
# pull ids that match one of these
sepids<- synpl %>% filter(value %in% sepcode_f | substr(value,1,3) %in% sepcode_a) %>%
  pull(...1) %>% unique()
# Add column that says true if id is in this vector
syndata<-syndata %>% mutate(sepsis = ifelse(...1 %in% sepids, TRUE, FALSE))

write_csv(syndata, "masterdataphi.csv")
# Possibly useful code but not the most important--------------------
#####################################################################

