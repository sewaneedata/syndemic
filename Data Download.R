######################## Libraries and Datasets ----

library(readr)
library(tidyverse)

IP19 <- readr::read_csv('IP19_redacted.csv')

######################## Codebook Formatting----

#Reads and formats ICD-10 2019 Codebook
ICD <- readr::read_delim("icd10cm_order_2019.txt", delim = ' ', col_names = FALSE) %>% 
  select(-X1, -X3, -X4) %>% 
  unite(col = 'Details', X5:X62, sep = ' ', na.rm = TRUE)

#Filters Codebook to only words we deem relevant
ICD_Filtered <- ICD %>% 
  filter(grepl('endocarditis| sepsis | osteomyelitis', Details, ignore.case = TRUE))

######################## Dataset Formatting (IP19) ----

#Filters out unnecessary columns
IP19 <-IP19 %>% select(
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
                  -Wrong_Claim
)

#Limits the dataset to just the 385XX area code
IP19_385XX <- IP19 %>% filter(Patient_Zip == '385XX')

#Combines all of the Diags into new variable
IP19 <- 
  IP19 %>% 
  mutate()

IP19 <- 
  IP19$Diag1 %>%
  paste(IP19$Diag1, 
        IP19$Diag2, 
        IP19$Diag3, 
        IP19$Diag4,
        IP19$Diag5,
        IP19$Diag6,
        IP19$Diag7,
        IP19$Diag8,
        IP19$Diag9,
        IP19$Diag10,
        IP19$Diag11,
        IP19$Diag12,
        IP19$Diag13,
        IP19$Diag14,
        IP19$Diag15,
        IP19$Diag16,
        IP19$Diag17,
        IP19$Diag18)


IP19 <- IP19_385XX %>% 
  filter(Diag1 %in% c('A419', 'R652', 'R6520', 'R6521')) %>% 
  count(Diag1)
  #filter(Diag2 %in% c('A419', 'R652', 'R6520', 'R6521'))

ggplot(data = IP19, aes(x =Diag1)) +
  geom_bar()

