# # Reading in info of every zip and their state and county
# zips<-read_csv("/Users/erteam/Desktop/Syndemic Project/zip_code_database.csv")
# 
# # Reading important info
# md_phi<-read_csv("/Users/erteam/Desktop/Syndemic Project/masterdataphi.csv")
# 
# # Selecting the columns we need
# zips<-zips%>% select(zip,state,county)
# 
# # Make columns match
# zips<-zips %>% rename(Patient_Zip = zip) %>% mutate( Patient_Zip = as.numeric(Patient_Zip))
# 
# # Mashing together to give everyone a county name
# d<-full_join(md_phi,zips, by = "Patient_Zip")
# 
# # Keep unique ids
# # d<-d %>% distinct(...1, .keep_all = TRUE)
# 
# # Keep columns we need
# dids<-d %>% select(...1,state,county)
# write_csv(dids, "countybyid.csv")