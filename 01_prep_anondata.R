######################## Libraries and Data sets ####################
# June 23rd 2022 | Start of exploration and cleaning!
#####################################################################
#SQLITE in RSTUDIO example!

# This r scripts is the first place our data goes, because of the size of the data we needed to srink it first through a database language
# this script uses sql in r to make a smaller data set which we did.

library(RSQLite)
library(DBI)
library(dbplyr)
library(readr)
library(data.table)


# Reading in sqlite
portaldb <- dbConnect(SQLite(), "discharges_anon")

# List tables in database
dbListTables(portaldb)

# Column names
dbListFields(portaldb, "discharges_anon")

# Query description
# Where I selected all rows I wanted to keep since couldnt write a csv with all columns
res<-"SELECT '...1' ,File_Type , Data_Yr , Bill_Number , Record_Seq_Num , Hospital_ID , Form_Type , Patient_Zip , Patient_Sex , Patient_Discharge_Status , Accident_Code , Rev_Cd1 , Rev_Cd2 , Rev_Cd3 , Rev_Cd4 , Rev_Cd5 , Rev_Cd6 , Rev_Cd7 , Rev_Cd8 , Rev_Cd9 , Rev_Cd10 , Rev_Cd11 , Rev_Cd12 , Rev_Cd13 , Rev_Cd14 , Rev_Cd15 , Rev_Cd16 , Rev_Cd17 , Rev_Cd18 , Rev_Cd19 , Rev_Cd20 , Rev_Cd21 , Rev_Cd22 , Rev_Cd23 , HCPC_Rate_HIPPS_Rate_Cd1 , HCPC_Rate_HIPPS_Rate_Cd2 , HCPC_Rate_HIPPS_Rate_Cd3 , HCPC_Rate_HIPPS_Rate_Cd4 , HCPC_Rate_HIPPS_Rate_Cd5 , HCPC_Rate_HIPPS_Rate_Cd6 , HCPC_Rate_HIPPS_Rate_Cd7 , HCPC_Rate_HIPPS_Rate_Cd8 , HCPC_Rate_HIPPS_Rate_Cd9 , HCPC_Rate_HIPPS_Rate_Cd10 , HCPC_Rate_HIPPS_Rate_Cd11 , HCPC_Rate_HIPPS_Rate_Cd12 , HCPC_Rate_HIPPS_Rate_Cd13 , HCPC_Rate_HIPPS_Rate_Cd14 , HCPC_Rate_HIPPS_Rate_Cd15 , HCPC_Rate_HIPPS_Rate_Cd16 , HCPC_Rate_HIPPS_Rate_Cd17 , HCPC_Rate_HIPPS_Rate_Cd18 , HCPC_Rate_HIPPS_Rate_Cd19 , HCPC_Rate_HIPPS_Rate_Cd20 , HCPC_Rate_HIPPS_Rate_Cd21 , HCPC_Rate_HIPPS_Rate_Cd22 , HCPC_Rate_HIPPS_Rate_Cd23 , Tot_Chrg_by_Rev_Cd1 , Tot_Chrg_by_Rev_Cd2 , Tot_Chrg_by_Rev_Cd3 , Tot_Chrg_by_Rev_Cd4 , Tot_Chrg_by_Rev_Cd5 , Tot_Chrg_by_Rev_Cd6 , Tot_Chrg_by_Rev_Cd7 , Tot_Chrg_by_Rev_Cd8 , Tot_Chrg_by_Rev_Cd9 , Tot_Chrg_by_Rev_Cd10 , Tot_Chrg_by_Rev_Cd11 , Tot_Chrg_by_Rev_Cd12 , Tot_Chrg_by_Rev_Cd13 , Tot_Chrg_by_Rev_Cd14 , Tot_Chrg_by_Rev_Cd15 , Tot_Chrg_by_Rev_Cd16 , Tot_Chrg_by_Rev_Cd17 , Tot_Chrg_by_Rev_Cd18 , Tot_Chrg_by_Rev_Cd19 , Tot_Chrg_by_Rev_Cd20 , Tot_Chrg_by_Rev_Cd21 , Tot_Chrg_by_Rev_Cd22 , Tot_Chrg_by_Rev_Cd23 , Total_Tot_Chrg , Non_Cvrd_Chrg_by_Rev_Cd1 , Non_Cvrd_Chrg_by_Rev_Cd2 , Non_Cvrd_Chrg_by_Rev_Cd3 , Non_Cvrd_Chrg_by_Rev_Cd4 , Non_Cvrd_Chrg_by_Rev_Cd5 , Non_Cvrd_Chrg_by_Rev_Cd6 , Non_Cvrd_Chrg_by_Rev_Cd7 , Non_Cvrd_Chrg_by_Rev_Cd8 , Non_Cvrd_Chrg_by_Rev_Cd9 , Non_Cvrd_Chrg_by_Rev_Cd10 , Non_Cvrd_Chrg_by_Rev_Cd11 , Non_Cvrd_Chrg_by_Rev_Cd12 , Non_Cvrd_Chrg_by_Rev_Cd13 , Non_Cvrd_Chrg_by_Rev_Cd14 , Non_Cvrd_Chrg_by_Rev_Cd15 , Non_Cvrd_Chrg_by_Rev_Cd16 , Non_Cvrd_Chrg_by_Rev_Cd17 , Non_Cvrd_Chrg_by_Rev_Cd18 , Non_Cvrd_Chrg_by_Rev_Cd19 , Non_Cvrd_Chrg_by_Rev_Cd20 , Non_Cvrd_Chrg_by_Rev_Cd21 , Non_Cvrd_Chrg_by_Rev_Cd22 , Non_Cvrd_Chrg_by_Rev_Cd23 , Total_Non_Cvrd_Chrg , Primary_Payer_Class_Cd , Secondary_Payer_Class_Cd , Tertiary_Payer_Class_Cd , National_Provider_Id , Diag1 , Diag2 , Diag3 , Diag4 , Diag5 , Diag6 , Diag7 , Diag8 , Diag9 , Diag10 , Diag11 , Diag12 , Diag13 , Diag14 , Diag15 , Diag16 , Diag17 , Diag18 , Admit_Diag_Cd , Proc1 , Proc2 , Proc3 , Proc4 , Proc5 , Proc6 , JARID , Patient_Race_Ethnicity , Obs_Unit_Flag , Tot_Charges_Recorded , Tot_Charges_Analysis , Age , TN_Res_Flag , Hospital_Id_JAR , Tot_Charges_Summed , CostWt FROM discharges_anon "

# Creating query
ex<-dbGetQuery(portaldb, res)

# Writing query data 
write.csv(ex, "impdata.csv")
# One time thing

# Disconnect from sqlite
dbDisconnect(portaldb)
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

write_csv(cleands,"m_data.csv")

# Add boolean value for SUD------------------------------------------
syndata<-read_csv("m_data.csv")

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

write_csv(syndata, "masterdata.csv")
# Possibly useful code but not the most important--------------------
#####################################################################
# Reading in doc of IDC10codes and creating codes csv----------------
# icd<-gsheet2tbl("https://docs.google.com/spreadsheets/d/1hrniE4MIjZKVABg2DMR_tnKOt-SuIdPXYkzszWjQqbA/edit?usp=sharing")
# 
# Making a column with codes.
# Noting that codes with astrid needs to be searched as start with, not fixed code. 
# icd<-icd %>% mutate(code = substr(icd$diagnosis,1 , 7 )) %>%mutate( astrid = ifelse(str_detect(icd$diagnosis, "[*]"),TRUE,FALSE))
# 
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




