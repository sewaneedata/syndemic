# Syndemic Project

## Project Summary

Syringe sharing continues to increase the spread of HIV, viral hepatitis, STIs, and other fatal diseases, creating a syndemic and skyrocketing healthcare costs. Every county in TN has been significantly affected by the syndemic, and by analyzing state-wide hospital discharge data, we will determine which counties would benefit most from new syringe exchange programs that assist patients with substance use disorders, slow the spread of disease, and reduce the overall healthcare cost. We will also create an interactive dashboard that will assist in the lobbying for new syringe-sharing programs in the Tennessee counties that need them the most.

## Dashboard Location

Our dashboard will be up and running on a Sewanee:The University of The South website where you could go online and interact withour dashboard. The link will be posted here in the next couple of weeks.

## Want to run our Dashboard in your own Computer?

Now, what if you want to run this code yourself? Sewanee Datalab bought 2019 hospital discharge data from the Tennessee Department of Health. This is the data we used for our analysis and work. To be able to run this dashboard you will need this data. There is two ways to try and get this data. Number one, you can contact datalab@sewanee.edu and ask for the data for this specific dashboard. Number two, going online and buying the same data we bought. 

Now you have data, lets clean it! For this process, you will have to run the `01_prep_anondata.R` script. Due to the size of this data, at the beginning this script uses SQLite in Rstudio to filter for possibly necessary columns, to make this data smaller and easier for Rstudio to handle. After this portion it, write out the new query you made into a new csv. THe next portion is filtering for the cases with one of our diagnosis we care about. This portion will begin by reading in a data sheet that has the diagnosis codes we care about. It will format the codes correctly and label them to make filtering out data easier afterwards. Then we start filtering out more unnecessary columns. Then we go through and filter for just cases we are interested in. We did it by infection, and thre is two parts for each filtering. Due to the nature of the codes we where given, we had to filter for codes that started with a certain pattern, and codes that matched a certain pattern identically. So we filter for them in seperate ways. After going through all of the line of codes. At the end you should be able to write out the master data csv used for the dashboard. 

Finally the dashboard!! This would be the `app.R` Rmd file. This begins by setting everything up for all the analysis. You can see that we read in a couple of csv files, the code used to make them is above the line where we read the csv files( to run these line of codes, I also read in a csv called zips, its a csv with zipcode information, this is fairly easy to find online and download). The one last step is downloading the shapefiles from online. The url where I got the shapefiles is commented right above where I read in the shapefile. With these files, you do no have to include the file type at the end since it's 6 different type of files. This should be it and the dashboard should work. 

### Tips

Make sure your paths to reading in the csv are correct. If these are correct paths and to correct data this map should work!

     
 
