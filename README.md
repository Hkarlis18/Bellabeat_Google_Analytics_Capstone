# Google Analytics Capstone: Bellabeat Case Study

The following Case Study is part of the final project of the Google Analytics Certificate on Coursera. 
During this analysis, I seek to get insights from the data collected in order to  identify user habits, 
and trends that  Bellabeat could use to guide its marketing strategy.

**Author:**  Karlis Herrera [@hkarlis18](https://www.github.com/hkarlis18)

## Summary

The case study follows the Google Analytics model for data analysis:

### :one: [Ask](https://github.com/Hkarlis18/Bellabeat_Google_Analytics_Capstone/edit/main/README.md#ask)

### :two: [Prepare](https://github.com/Hkarlis18/Bellabeat_Google_Analytics_Capstone/edit/main/README.md#prepare)

### :three: [Process](https://github.com/Hkarlis18/Bellabeat_Google_Analytics_Capstone/edit/main/README.md#process)

### :four: [Analyze](https://github.com/Hkarlis18/Bellabeat_Google_Analytics_Capstone/edit/main/README.md#analyze)

### :five: [Share](https://github.com/Hkarlis18/Bellabeat_Google_Analytics_Capstone/edit/main/README.md#share)

### :six: [Act](https://github.com/Hkarlis18/Bellabeat_Google_Analytics_Capstone/edit/main/README.md#act)


## Overview

Bellabeat is a high-tech company founded in 2013 that manufactures smart products focused on health and women. 
Urška Sršen and Sando Mur, founders of Bellabeat, are on the mission of collecting data on exercise, sleep, stress, 
and reproductive health that will empower women.

Thanks to data women will be able to have a better insight into their health habits and will acquire the knowledge
to make the changes that will lead them to have a better lifestyle. Bellabeat accomplishes this by offering a wide 
range of products such as an app with different membership plans, along with smartwatches, bracelets, necklaces, 
clips, and water bottles.

Bellabeat has been growing since 2013, but they seek to become a key player in the tech industry. They are a strong 
believer that making data-driving decisions is fundamental to growth in the market, hence they expect to use the 
fitness data of users in order to find new growth opportunities and have a better understanding of the needs of their customers. 

## Ask 


During this phase, we will focus on the context of the business task, the stakeholders, and the questions we will address 
in the following steps. 

**Stakeholders:**

**Urška Sršen:** Bellabeat’s co-founder and Chief Creative Officer

**Sando Mur:** Bellabeat’s co-founder; mathematician and  crucial member of the executive team

**Bellabeat marketing analytics team:** A team of data analysts in charge of gathering and examining 
data in order to create the marketing strategist


**Business task:** Analyze data collected from a third-party focusing on smart device usage in the 
fitness field with the intention to identify user habits and trends that  Bellabeat could use to
guide its marketing strategy.

**Key questions:**

1. What are some trends in smart device usage? 

2. How could these trends apply to Bellabeat customers?

3. How could these trends help influence Bellabeat's marketing strategy?


## Prepare 


Bellabeat has decided to use the dataset FitBit Fitness Tracker Data for this analysis. This is a public-domain
dataset available through Mobius. The data is currently stored in Kaggle where it can be downloaded and stored
on a local computer for future analysis.


The information was gathered through a survey created via Amazon Mechanical Turk. Thirty Fitbit users agreed
to share their personal data. The survey collected information related to sleeping reports, heart rate, and 
physical activities. Each user tracked different aspects of their fitness activities from a period time between 
03.12.2016 to 05.12.2016.


**Bias and Concerns**

Next, we will break down certain aspects regarding the dataset used that must be taken into consideration.


+ The timeframe of the dataset is too narrow and old. The data used was collected between 03.12.2016  to  05.12.2016,
a frame of three months it’s not enough to realize a deeper analysis and compared habits. Additionally, the data it’s 
from eight years ago, so it may not be relevant anymore. 


+ When examining the size of the sample in detail, inconsistencies were found in the number of users, and the records of their physical activities
per category, which creates information gaps and prevents more accurate results from being obtained during the analysis. 
For example, only 8 users recorded their weight


+ Only thirty people consented to track their fitness data and shared it. The minimum sample size recommended for any 
analysis is 33 people. However, according to Statista, the number of Fitbit users in 2021 is 111 million, which means 
that the sample used for this analysis is not representative enough. In order to have a 95% confidence level, we will 
need to collect a sample of 385 people, with a margin error of 5%.


+ Another problem with the data is that it does not specify aspects such as the age and geographic location of each user.
This type of information can become decisive in order to understand the habits of each user.


+ The dataset was bought from a third party and a truthful source. However,  it lacks key information that could lead to a complete analysis. 
In addition, it is not advisable to use data from 8 years ago to carry out market analysis in such a dynamic and changing field.

:pushpin:  [Back to Summary](https://github.com/Hkarlis18/Bellabeat_Google_Analytics_Capstone/edit/main/README.md#summary)


## Process


For the data cleaning process, Excel and SQL Server were used. The following checklist was applied to ensure the accuracy and integrity of the data:


+ Evaluate and choose what data would be necessary for the analysis
+ Check for typos and extra spaces within cells
+ Check for duplicates
+ Check the names of the columns to avoid using reserved words in SQL
+ Check for nulls and empty cells
+ Evaluate consistency across columns and data range


**File: Daily_activity_weight**


First, examine the data in Excel and then:

+ Format the data in Excel as a table  for better analysis
+ Check the length of all IDs to guarantee consistency
+ Use the filter option to seek blanks
+ Set numeric values with  two decimal places only
+ Add a new column to determine the weekday of each activity
+ Use the Get Data function in Excel in order to merge the Weight data with the Daily Activity in one table


**SQL**
``` 
/* Total of Calories Burned per Day by Each User */

Select Distinct Id,
ROUND (SUM (( Calories /60)),2) as TotalCaloriesBurned
from dbo.Daily_activity_weight
Group by Id
Order by Id ASC 

/*  Estimate of the Total Number of Steps per Day by Each User */

Select Distinct Id,  CONVERT(VARCHAR(20), ActivityDate, 101) AS ActivityDate,  ActivityWeekday,
ROUND (SUM ((TotalSteps /60)), 2) as TotalSteps
from dbo.Daily_activity_weight
Group by Id, ActivityDate, ActivityWeekday
Order by Id, ActivityWeekday ASC


/* Average of the Four Activity Categories per User Id  */

SELECT ID,
ROUND ( AVG (VeryActiveMinutes),2) AS Average_VeryActiveMinutes,
ROUND (AVG (FairlyActiveMinutes), 2) AS Average_FairlyActiveMinutes,
ROUND (AVG (LightlyActiveMinutes) /60.0,2) AS Average_LightlyActiveHours,
ROUND (AVG (SedentaryMinutes) / 60.0,2) AS Average_SedentaryHours
FROM  [dbo].[Daily_activity_weight]
Group by Id

/* Tracking Weight */

SELECT  
COUNT (DISTINCT Id) AS User_Tracking_Weight,
ROUND(AVG (WeightKg), 0) AS  Average_Weight,
MIN (WeightKg)  AS Minimum_Weight,
Max (WeightKg) AS Maximum_Weight
from [dbo].[Daily_activity_weight]


/*Tracking their Physical Activities*/

SELECT 
COUNT (DISTINCT Id) AS Users_Tracking_Activity,
ROUND (AVG (TotalSteps),2)  AS Average_steps,
ROUND (AVG (TotalDistance),2)  AS Average_Distance,
ROUND (AVG (Calories),2) AS Average_CaloriesBurned
From dbo.daily_activity_weight
```

**File: Sleep_Day**

First evaluate the data in Excel, before going for further analysis in SQL Server

+ Check the length of all IDs in the ID column to ensure consistency
+ Add a new column with the weekday using =Tex(B2, “ddddd”)
+ Separate Date and Time in different Columns with the MOD and format function
+ Set all numeric values with  zero decimal places 


**SQL**

``` 
/* Total Minutes Sleep per Weekday by User */

SELECT  Id,  
CONVERT(VARCHAR(20), SleepDay, 101) AS SleepDay,
SleepWeekday,
SUM(TotalMinutesAsleep) AS TotalMinAsleep
FROM dbo.Sleep_Day
GROUP BY Id, SleepDay, SleepWeekday
Order BY SleepDay ASC


/* Average, Minimum, and Maximum Minutes Asleep. In addition to the Average Time in Bed */

SELECT 
COUNT (DISTINCT Id) AS User_Tracking_Sleep,
ROUND (AVG (TotalMinutesAsleep) /60, 2) AS  Average_Hours_Asleep,
ROUND (MIN (TotalMinutesAsleep) /60.0,2) AS Minimum_Time_Asleep,
ROUND (Max (TotalMinutesAsleep) /60,2) AS Maximum_Hours_Asleep,
ROUND (AVG (TotalTimeInBed) / 60,2) AS Average_Hours_inBed
from dbo.sleep_day

``` 

**File date: Heartrate_PerUser**

The document was briefly analyzed in Excel to get a better idea of the type of data collected. However, when opening it,
a popup rises up stating the following “ This data set is too large for the Excel grid. If you save this workbook, you’ll
lose data that wasn’t loaded.” Therefore, further analysis was performed on SQL Server.


**SQL**

``` 
/*  Average Heart Rate per Hour for each Id on each Activity Date and Time */

Select 
DISTINCT Id,
CONVERT(VARCHAR(20), [ActivityDate], 101) AS ActivityDate,
         CONVERT(VARCHAR(20),[ActivityDate], 108) AS ActivityTime,
		Round (AVG (Heartrate),1)  As AVG_Heartrate_PerHour
		 FROM dbo.Heartrate_PerUser
		 Group By Id, ActivityDate
		 Order By AVG_Heartrate_PerHour DESC


/* Tracking the Average, Minimum, and Maximum Heart Rate per Id */

SELECT 
COUNT (DISTINCT Id) AS User_Tracking_HeartRate,
AVG (Heartrate) AS Average_HeartRate,
MIN (Heartrate) AS Minimum_HeartRate,
Max (Heartrate) AS Maximum_HeartRate
from [dbo].[heartrate_PerUser]

``` 

**File: METS and Intensity**

First, examine the tables with the necessary data in Excel, before going for further analysis in SQL Server.

The workbook  minute_METsNarrow was immediately imported to SQL because it was too large, and Excel
showed a message stating that future changes might not be saved. So, it was better for further analysis
to do it through SQL Server.

``` 
/* Average MET energy used in relation to Intensity*/

SELECT distinct HI.Id,
CONVERT(VARCHAR(20), HI.ActivityHour, 101) AS ActivityDate,
CONVERT(VARCHAR(20), HI.ActivityHour, 108) AS ActivityTime,  
 AVG(TotalIntensity)  AS Average_Intensity,
ROUND (AVG (MT.METs)/ 60,2)  AS Average_METs_perHour
FROM dbo.METS AS MT
JOIN dbo.Hourly_Intensity AS HI  
ON HI.ID = MT.Id AND HI.ActivityHour = MT.ActivityMinute 
GROUP BY HI.Id, HI.ActivityHour
ORDER BY  Average_Intensity DESC
``` 

**File : Daily_activity_weight  and Heartrate_avg_results**

``` 
/* This is AvgStepPerHour Against AVGHeartRate */

  SELECT  ST.Id,   CONVERT(VARCHAR(20), ST.ActivityDate, 101) AS ActivityDate, 
  CONVERT(VARCHAR(20), ST.ActivityDate, 108) AS ActivityTime,
 ROUND(TotalSteps /24.0,0) AS AVGStepPerHour, AVGHeartRatePerHour
FROM dbo.Heartrate_avg_results AS HR
RIGHT JOIN dbo.Daily_activity_weight_updated AS ST
ON HR.Id = ST.Id AND HR.ActivityDate = ST.ActivityDate
ORDER BY ST.ActivityDate ASC
``` 
:pushpin:  [Back to Summary](https://github.com/Hkarlis18/Bellabeat_Google_Analytics_Capstone/edit/main/README.md#summary)

## Analyze

The data was slipped into three areas of interest for a better analysis. Those areas included physical activity results, heart rate activity analysis, sleeping habits, and METs analysis. By analyzing these three areas of interest we can get an in-depth insight into how users are using their smart devices 
and what are their physical habits on a daily basis. 


**Key findings:**


+ More steps are not necessarily equal to more calories burned. Although most users tend to have an active routine, the average of calories burned is 2303, 
and 52% of the people are still overweight, showing an average of 134 kg.


+ The heart rate and step average indicate that users are 3 hours lightly active and only 20 minutes reasonably active. Whilst 81% of the time are in sedentary mode.


 + The average time in bed is 7 hours per day, while the maximum hours asleep was 13 hours, 5 hours more than the 8 hours recommended. 
 Finally, the average time asleep was 7 hours.


 +  33 users were proactively tracking the energy they used on a daily basis (METs and Intensity). The lower the intensity, the higher the METs expenditure, 
 and vice versa. The hours with the highest  energy expenditure were between 9:00 A.M. to 7:00 P.M. when people are awake and most active. 
 
 :pushpin:  [Back to Summary](https://github.com/Hkarlis18/Bellabeat_Google_Analytics_Capstone/edit/main/README.md#summary)
 
 ## Share 
 
 
 All visualizations for this case study were created by using Power Bi

![Bellabeat_Physical_Analysis](https://user-images.githubusercontent.com/123211885/218180927-461415fb-8afc-4c9c-94af-c0436476d961.png)


![Heart_Rate_Activity](https://user-images.githubusercontent.com/123211885/218182573-5e2ef35e-cbfa-434f-9e8f-8665bbd20483.png)


![Bellabeat_Sleeping__METs_Analysis](https://user-images.githubusercontent.com/123211885/218183915-edc7b7b0-81a9-49fe-84fc-6bdeb5e270c1.png)

:pushpin:  [Back to Summary](https://github.com/Hkarlis18/Bellabeat_Google_Analytics_Capstone/edit/main/README.md#summary)

## Act 


**Recommendations:**


+ According to the data, people seem to be spending too many hours in bed without resting.  Therefore, Bellabeat could add a new feature on the App to
help users to improve their sleeping habits through meditation programs or even breathing techniques.


+ In addition to providing insights about the health activity of each user, Bellabeat could create customized reports with schedules on how to improve 
the well-being of each user with suggestions of activities in areas such as exercise, sleeping, and eating habits. 


+ Most active users suffer from being overweight, Bellabeat could create achievement programs where users who accomplish certain goals could have access
to benefits within the brand like access to free classes, or discounts on certain products.


**Suggestions to improve in the future:**


+ Gather more current data for analysis. It’s also fundamental to use a data sample-accurate to the reality of the market to be able to represent the population 
as a whole.

+ Guarantee to have the appropriate sample size and make sure the participants have filled in the information necessary for the different areas to be studied. 
In this way, more detailed analyzes can be carried out when crossing results to better understand the habits of people.

+ Since Bellabeat offers several health-related services, it would be beneficial to narrow down each segment a little more, either by age group, 
location and by type of physical activity that is tracked in the app.


+ Implement in-depth marketing research in order to evaluate what strategies are using direct and indirect competition. In addition to reevaluating what strategies
were used in the past and didn't work and why.


:pushpin:  [Back to Summary](https://github.com/Hkarlis18/Bellabeat_Google_Analytics_Capstone/edit/main/README.md#summary)
