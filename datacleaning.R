######################## Libraries and Datasets #####################
# June 23rd 2022 | Start of exploration and cleaning!
#####################################################################
library(tidyverse)

<<<<<<< HEAD
setwd("D:/DataLab/syndemic")
df <- read_csv("D:/DataLab/DataLab_2022/jacobzip.csv")
codes <- read_csv("codes.csv")
=======
df <- read_csv("jacobzip.csv")
>>>>>>> 595cc9bec4fefca6ad89f3f0f170fd2df0593117

# Reading in doc of IDC10codes and creating codes csv----------------
icd<-read_csv("codes-Sheet1.csv", col_names = FALSE)
icd<-icd %>% mutate(code = substr(icd$X1,1 , 7 ))
icd$code <- icd$code %>% str_replace_all("[.]","") %>% 
  str_replace_all("[*]","")
# Only run once
write_csv(icd, "codes.csv")

# Data set Formatting ----------------------------------------------- 

#Filters out unnecessary columns
train <-df %>% select(
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

#Combines all of the Diags into new variable

train1<-train
train1$Diag1 <- train$Diag1 %>%
  paste(df$Diag1,
        df$Diag2,
        df$Diag3,
        df$Diag4,
        df$Diag5,
        df$Diag6,
        df$Diag7,
        df$Diag8,
        df$Diag9,
        df$Diag10,
        df$Diag11,
        df$Diag12,
        df$Diag13,
        df$Diag14,
        df$Diag15,
        df$Diag16,
        df$Diag17,
        df$Diag18
        )

train1<-train1 %>% 
  select(-Diag2,
         -Diag3,
         -Diag4,
         -Diag5,
         -Diag6,
         -Diag7,
         -Diag8,
         -Diag9,
         -Diag10,
         -Diag11,
         -Diag12,
         -Diag13,
         -Diag14,
         -Diag15,
         -Diag16,
         -Diag17,
         -Diag18
         )

codevector<-pull(codes , code)

keepall<-c()
for(i in 1:107){
  keep<-grep(codevector[i], train1$Diag1)
  keepall<-c(keep, keepall)
}
keepall<-unique(keepall)
filtered_df1<-train1[keepall,]


