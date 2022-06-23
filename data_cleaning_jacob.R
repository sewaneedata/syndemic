######################## Libraries ----

library(readr)
library(tidyverse)

######################## Codebook Formatting----

#Reads the filtered ICD-10 2019 Codebook
ICD <- read_csv("codes.csv")

######################## Dataset Formatting (IP19) ----

#Base DataSet
IP19 <- readr::read_csv('IP19_redacted.csv')

#Filters out unnecessary columns
IP19 <- IP19 %>% select(
                  -Type_Bill,
                  -Fed_Tax_SubID,
                  -Fed_Tax_Num,
                  -Admission_Type,
                  -Admission_Source,
                  -Do_Not_Resuscitate,
                  -Accident_St,
                  -starts_with("Units_Service"), #[1:18]
                  -Primary_Health_Plan_Id,
                  -Secondary_Health_Plan_Id,
                  -Tertiary_Health_Plan_Id,
                  -Primary_Patient_Rel_Insr,
                  -Secondary_Patient_Rel_Insr,
                  -Tertiary_Patient_Rel_Insr,
                  -Dx_Px_Qualifier,
                  -starts_with("POA"), #[1:18]
                  -starts_with("Patient_Reason_Visit"),#[1:3],
                  -Prospect_Pay_Code,
                  -starts_with("Ecode"), #[1:3]
                  -starts_with("E_POA"), #[1:3]
                  -Type_ER_Visit,
                  -Outcome_ER_Visit,
                  -Inpatient_Flag,
                  -ER_Flag,
                  -PET_Flag,
                  -ASTC_Flag,
                  -Lithotripsy_Flag,
                  -MRI_MRA_Flag,
                  -Megavolt_Rad_Flag,
                  -CT_Flag,
                  -Fatal_Error_Flag,
                  -starts_with("Record_Num"), #[1:2]
                  -Bill_End,
                  -MUL,
                  -Patient_ID,
                  -TN_Co_Res,
                  -Payer_A,
                  -Payer_B,
                  -Payer_C,
                  -Amount_Counter,
                  -Race,
                  -LOS,
                  -DRG_Rank,
                  -Inpat_Record_Flag,
                  -ER_Record_Flag,
                  -ASTC_Record_Flag,
                  -Obs_23hr_Record_Flag,
                  -CON_Flag,
                  -Cumulative_Record_Flag,
                  -Reportable_Flag,
                  -TN_Co_Unk,
                  -Processing_Period,
                  -MS_MDC,
                  -MS_DRG,
                  -MS_DRG_4digit,
                  -HAC,
                  -Admit_From_ED_Flag,
                  -Wrong_Claim)

#Creates values with the ICD10 codes to be used to filter by later
ICD_2 <- pull(ICD, code)

#Filtering DataSet to only ICD-10 codes we care about
IP19_filtered_by_codes <- 
  IP19 %>% 
  filter(Diag1 %in% ICD_2 |
         Diag2 %in% ICD_2 |
         Diag3 %in% ICD_2 |
         Diag4 %in% ICD_2 |
         Diag5 %in% ICD_2 |
         Diag6 %in% ICD_2 |
         Diag7 %in% ICD_2 |
         Diag8 %in% ICD_2 |
         Diag9 %in% ICD_2 |
         Diag10 %in% ICD_2 |
         Diag11 %in% ICD_2 |
         Diag12 %in% ICD_2 |
         Diag13 %in% ICD_2 |
         Diag14 %in% ICD_2 |
         Diag15 %in% ICD_2 |
         Diag16 %in% ICD_2 |
         Diag17 %in% ICD_2 |
         Diag18 %in% ICD_2)

#Unites the 18 'diag' columns into one 'diagnosis' column
IP19_diagnosis_filtered <- IP19_filtered_by_codes %>% 
  unite(col = diagnosis, 
        Diag1:Diag18,
        sep = ' ',
        remove = TRUE,
        na.rm = TRUE)

#or (filtered data by codes vs not)

IP19_diagnosis_not_filtered <- IP19 %>% 
  unite(col = diagnosis, 
        Diag1:Diag18,
        sep = ' ',
        remove = TRUE,
        na.rm = TRUE)

########################