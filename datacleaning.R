######################## Libraries and Data sets ####################
# June 23rd 2022 | Start of exploration and cleaning!
#####################################################################
library(tidyverse)
library(stringr)
library(gsheet)

setwd("D:/DataLab/syndemic")
codes <- read_csv("codes.csv")
#####################################################################
# This data is already filtered for choosen column values!
data<-read_csv("impdata.csv")
#####################################################################
# New Correct way of cleaning data-----------------------------------
# Making all diagnosis into one column!
# For all data change all trainpl into data
trainpl<-data %>% 
  select( ...1,
          Diag1:Diag18
  )
trainpl<-trainpl %>% pivot_longer(starts_with("Diag"))

# Get codes that tell us with what it should start with
swdf<-codes %>% filter(astrid)
swv<-pull(swdf,code)

# Look for any person id that has codes that start with any of our start with patterns
swfinal<-trainpl %>%
  filter(substr(value,1,3) %in% swv )
swfinal<-swfinal %>% filter( !(substr(value,1,1) == "T" & (substr(value,6,6)=="5"|substr(value,6,6)=="6" )))
# This last filter is for the special T codes where the second to last character
# can't be a 5 or 6. I generalized and saw that most codes where 7 characters long
# so I used substr to look at the 6th character and made sure it didn't equal

# Get codes that are fixed and we only want them to match that specific code
fixeddf<-codes %>% filter(!astrid)
fixedv<-pull(fixeddf,code)

# Look for any person id that has code that matches any of our fixed codes
fixedfinal<-trainpl %>% filter(value %in% fixedv)

# Make the patient ids in vectors and join them
swidv<-pull(swfinal,...1)
ffidv<-pull(fixedfinal,...1)
fidv<-c(ffidv, swidv)
fidv<-unique(fidv)

# Get person with ids that we got and care about
cleands<-data %>% filter( ...1 %in% fidv)

# Clean more, get rid of some more columns
cleands<-cleands %>% select(-starts_with("HCPC_Rate"),
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

write_csv(cleands, "m_data.csv")

# Getting rid of some codes that arent helpful.


# Possibly useful code but not the most important--------------------
#####################################################################
# Reading in doc of IDC10codes and creating codes csv----------------
# icd<-gsheet2tbl("https://docs.google.com/spreadsheets/d/1hrniE4MIjZKVABg2DMR_tnKOt-SuIdPXYkzszWjQqbA/edit?usp=sharing")

# Making a column with codes.
# Noting that codes with astrid needs to be searched as start with, not fixed code. 
# icd<-icd %>% mutate(code = substr(icd$diagnosis,1 , 7 )) %>%mutate( astrid = ifelse(str_detect(icd$diagnosis, "[*]"),TRUE,FALSE))

# Getting rid of astrid or, period from codes. 
# icd$code <- icd$code %>% str_replace_all("[.]","") %>% str_replace_all("[*]","")
# Only run once, making this into csv for later use
# write_csv(icd, "codes.csv")
#####################################################################
# Data set Formatting ----------------------------------------------- 
# New data already has only selected rows.
# Filters out unnecessary columns
# train <-df %>% select(
#   -Type_Bill,
#   -Fed_Tax_SubID,
#   -Fed_Tax_Num,
#   -Admission_Type,
#   -Admission_Source,
#   -Do_Not_Resuscitate,
#   -Accident_St,
#   -starts_with("Units_Service"), #[1:18]
#   -Primary_Health_Plan_Id,
#   -Secondary_Health_Plan_Id,
#   -Tertiary_Health_Plan_Id,
#   -Primary_Patient_Rel_Insr,
#   -Secondary_Patient_Rel_Insr,
#   -Tertiary_Patient_Rel_Insr,
#   -Dx_Px_Qualifier,
#   -starts_with("POA"), #[1:18]
#   -starts_with("Patient_Reason_Visit"),#[1:3],
#   -Prospect_Pay_Code,
#   -starts_with("Ecode"), #[1:3]
#   -starts_with("E_POA"), #[1:3]
#   -Type_ER_Visit,
#   -Outcome_ER_Visit,
#   -Inpatient_Flag,
#   -ER_Flag,
#   -PET_Flag,
#   -ASTC_Flag,
#   -Lithotripsy_Flag,
#   -MRI_MRA_Flag,
#   -Megavolt_Rad_Flag,
#   -CT_Flag,
#   -Fatal_Error_Flag,
#   -starts_with("Record_Num"), #[1:2]
#   -Bill_End,
#   -MUL,
#   -Patient_ID,
#   -TN_Co_Res,
#   -Payer_A,
#   -Payer_B,
#   -Payer_C,
#   -Amount_Counter,
#   -Race,
#   -LOS,
#   -DRG_Rank,
#   -Inpat_Record_Flag,
#   -ER_Record_Flag,
#   -ASTC_Record_Flag,
#   -Obs_23hr_Record_Flag,
#   -CON_Flag,
#   -Cumulative_Record_Flag,
#   -Reportable_Flag,
#   -TN_Co_Unk,
#   -Processing_Period,
#   -MS_MDC,
#   -MS_DRG,
#   -MS_DRG_4digit,
#   -HAC,
#   -Admit_From_ED_Flag,
#   -Wrong_Claim
# )
# paste0(colnames(train), collapse = " , ")
#####################################################################
# Combines all of the diagnosis into one variable column-------------
# train1<-train
# train1$Diag1 <- train$Diag1 %>%
#   paste(df$Diag1,
#         df$Diag2,
#         df$Diag3,
#         df$Diag4,
#         df$Diag5,
#         df$Diag6,
#         df$Diag7,
#         df$Diag8,
#         df$Diag9,
#         df$Diag10,
#         df$Diag11,
#         df$Diag12,
#         df$Diag13,
#         df$Diag14,
#         df$Diag15,
#         df$Diag16,
#         df$Diag17,
#         df$Diag18
#   )
# 
# # Gets rid of diagnosis columns because I combined it into one
# train1<-train1 %>% 
#   select(-Diag2:-Diag18)
# 
# Trying to clean data unsuccessfully-------------------------------------------
# codevector<-pull(codes , code)
# # creating empty collection to then fill
# keepall<-c()
# # For loop to go through each code and compare to diagnosis column to keep their row number
# for(i in 1:107){
#   keep<-grep(codevector[i], train1$Diag1)
#   keepall<-c(keep, keepall)
# }
# # Getting rid of repeating row numbers
# keepall<-unique(keepall)
# # Picking just the rows that mention any of the codes in our code collection.
# filtered_df1<-train1[keepall,]
# 
# sample(filtered_df1$Diag1, 6)
# 
# # Filtered to make sure data start with the codes!
# # filtered_df2<-filtered_df1 %>% filter(str_starts(Diag1 , paste0(codevector, collapse="|")))
# 
# New way of filtering data and didn't work-------------------------------------
# # Selecting columns I want
# trainnew<-df %>% 
#   select( ...1,
#           Diag1:Diag18
#   )
# trainnew<-trainnew %>% pivot_longer(starts_with("Diag"))
# 
# ke<-data.frame()
# 
# ke<-trainnew %>% filter(substr(value,1,nchar(codevector[104])) == as.character(codevector[104]))
# 
# 
# 
# # trainnew<-trainnew %>% mutate(checkcode = str_starts(value , paste0(codevector, collapse="|")))
# # filter_ids<-trainnew %>% filter(str_starts(value , paste0(codevector, collapse="|")))




