zips<-read_csv("zip_code_database.csv")
zips<-zips%>% select(zip,state,county)
zips<-zips %>% rename(Patient_Zip = zip)
d<-full_join(md_phi,zips, by = "Patient_Zip")
d<-d %>% distinct(...1, .keep_all = TRUE)
dids<-d %>% select(...1,state,county)
write_csv(dids, "countybyid.csv")

