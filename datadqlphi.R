#SQLITE in RSTUDIO example!

library(RSQLite)
library(DBI)
library(dbplyr)
library(readr)
library(data.table)

setwd("~/Desktop/Syndemic Project")
# Reading in sqlite
portaldb <- dbConnect(SQLite(), "copy_discharges_phi")

# List tables in database
dbListTables(portaldb)

# Column names
dbListFields(portaldb, "discharges_phi")

# Query description
# Where I selected all rows I wanted to keep since couldnt write a csv with all columns
res<-"SELECT '...1' ,File_Type, creation_dt , Data_Yr , Bill_Number , Record_Seq_Num , Hospital_ID , Form_Type , Patient_Zip , Patient_Sex , Patient_Discharge_Status , Accident_Code , Rev_Cd1 , Rev_Cd2 , Rev_Cd3 , Rev_Cd4 , Rev_Cd5 , Rev_Cd6 , Rev_Cd7 , Rev_Cd8 , Rev_Cd9 , Rev_Cd10 , Rev_Cd11 , Rev_Cd12 , Rev_Cd13 , Rev_Cd14 , Rev_Cd15 , Rev_Cd16 , Rev_Cd17 , Rev_Cd18 , Rev_Cd19 , Rev_Cd20 , Rev_Cd21 , Rev_Cd22 , Rev_Cd23 , HCPC_Rate_HIPPS_Rate_Cd1 , HCPC_Rate_HIPPS_Rate_Cd2 , HCPC_Rate_HIPPS_Rate_Cd3 , HCPC_Rate_HIPPS_Rate_Cd4 , HCPC_Rate_HIPPS_Rate_Cd5 , HCPC_Rate_HIPPS_Rate_Cd6 , HCPC_Rate_HIPPS_Rate_Cd7 , HCPC_Rate_HIPPS_Rate_Cd8 , HCPC_Rate_HIPPS_Rate_Cd9 , HCPC_Rate_HIPPS_Rate_Cd10 , HCPC_Rate_HIPPS_Rate_Cd11 , HCPC_Rate_HIPPS_Rate_Cd12 , HCPC_Rate_HIPPS_Rate_Cd13 , HCPC_Rate_HIPPS_Rate_Cd14 , HCPC_Rate_HIPPS_Rate_Cd15 , HCPC_Rate_HIPPS_Rate_Cd16 , HCPC_Rate_HIPPS_Rate_Cd17 , HCPC_Rate_HIPPS_Rate_Cd18 , HCPC_Rate_HIPPS_Rate_Cd19 , HCPC_Rate_HIPPS_Rate_Cd20 , HCPC_Rate_HIPPS_Rate_Cd21 , HCPC_Rate_HIPPS_Rate_Cd22 , HCPC_Rate_HIPPS_Rate_Cd23 , Tot_Chrg_by_Rev_Cd1 , Tot_Chrg_by_Rev_Cd2 , Tot_Chrg_by_Rev_Cd3 , Tot_Chrg_by_Rev_Cd4 , Tot_Chrg_by_Rev_Cd5 , Tot_Chrg_by_Rev_Cd6 , Tot_Chrg_by_Rev_Cd7 , Tot_Chrg_by_Rev_Cd8 , Tot_Chrg_by_Rev_Cd9 , Tot_Chrg_by_Rev_Cd10 , Tot_Chrg_by_Rev_Cd11 , Tot_Chrg_by_Rev_Cd12 , Tot_Chrg_by_Rev_Cd13 , Tot_Chrg_by_Rev_Cd14 , Tot_Chrg_by_Rev_Cd15 , Tot_Chrg_by_Rev_Cd16 , Tot_Chrg_by_Rev_Cd17 , Tot_Chrg_by_Rev_Cd18 , Tot_Chrg_by_Rev_Cd19 , Tot_Chrg_by_Rev_Cd20 , Tot_Chrg_by_Rev_Cd21 , Tot_Chrg_by_Rev_Cd22 , Tot_Chrg_by_Rev_Cd23 , Total_Tot_Chrg , Non_Cvrd_Chrg_by_Rev_Cd1 , Non_Cvrd_Chrg_by_Rev_Cd2 , Non_Cvrd_Chrg_by_Rev_Cd3 , Non_Cvrd_Chrg_by_Rev_Cd4 , Non_Cvrd_Chrg_by_Rev_Cd5 , Non_Cvrd_Chrg_by_Rev_Cd6 , Non_Cvrd_Chrg_by_Rev_Cd7 , Non_Cvrd_Chrg_by_Rev_Cd8 , Non_Cvrd_Chrg_by_Rev_Cd9 , Non_Cvrd_Chrg_by_Rev_Cd10 , Non_Cvrd_Chrg_by_Rev_Cd11 , Non_Cvrd_Chrg_by_Rev_Cd12 , Non_Cvrd_Chrg_by_Rev_Cd13 , Non_Cvrd_Chrg_by_Rev_Cd14 , Non_Cvrd_Chrg_by_Rev_Cd15 , Non_Cvrd_Chrg_by_Rev_Cd16 , Non_Cvrd_Chrg_by_Rev_Cd17 , Non_Cvrd_Chrg_by_Rev_Cd18 , Non_Cvrd_Chrg_by_Rev_Cd19 , Non_Cvrd_Chrg_by_Rev_Cd20 , Non_Cvrd_Chrg_by_Rev_Cd21 , Non_Cvrd_Chrg_by_Rev_Cd22 , Non_Cvrd_Chrg_by_Rev_Cd23 , Total_Non_Cvrd_Chrg , Primary_Payer_Class_Cd , Secondary_Payer_Class_Cd , Tertiary_Payer_Class_Cd , National_Provider_Id , Diag1 , Diag2 , Diag3 , Diag4 , Diag5 , Diag6 , Diag7 , Diag8 , Diag9 , Diag10 , Diag11 , Diag12 , Diag13 , Diag14 , Diag15 , Diag16 , Diag17 , Diag18 , Admit_Diag_Cd , Proc1 , Proc2 , Proc3 , Proc4 , Proc5 , Proc6 , JARID , Patient_Race_Ethnicity , Obs_Unit_Flag , Tot_Charges_Recorded , Tot_Charges_Analysis , Age , TN_Res_Flag , Hospital_Id_JAR , Tot_Charges_Summed , CostWt FROM discharges_phi "

# Creating query
ex<-dbGetQuery(portaldb, res)

# Writing query data
write.csv(ex, "impdataphi.csv")
# One time thing

# Disconnect from sqlite
dbDisconnect(portaldb)

 