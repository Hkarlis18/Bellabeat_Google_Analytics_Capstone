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

/* Analysing the Average Heart Rate per Hour for each Id on each Activity Date and Time */

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
--COUNT (DISTINCT Id) AS User_Tracking_HeartRate,
AVG (Heartrate) AS Average_HeartRate,
MIN (Heartrate) AS Minimum_HeartRate,
Max (Heartrate) AS Maximum_HeartRate
from [dbo].[heartrate_PerUser]


/* Average MET energy used in relation to Intensity*/

SELECT distinct MT.Id,
CONVERT(VARCHAR(20), MT.ActivityMinute, 101) AS ActivityDate,
CONVERT(VARCHAR(20), MT.ActivityMinute, 108) AS ActivityTime,  
CAST ( AVG(TotalIntensity) AS DECIMAL (2)) AS Average_Intensity,
AVG (MT.METs) AS Average_METs
FROM dbo.HourlyIntensities AS HI  
JOIN dbo.METS AS MT
ON HI.ID = MT.Id AND HI.ActivityDate = MT.ActivityMinute 
GROUP BY MT.Id, MT.ActivityMinute 
ORDER BY  Average_METS DESC


/*  Average Steps per Hour Against Average Heart Rate */

SELECT  ST.Id,   CONVERT(VARCHAR(20), ST.ActivityDate, 101) AS ActivityDate, 
CONVERT(VARCHAR(20), ST.ActivityDate, 108) AS ActivityTime ,
ROUND(TotalSteps /24.0,0) AS AVGStepPerHour, AVG_Heartrate_PerHour
FROM dbo.User_AVG_HeartRate_PerHour AS HR
RIGHT JOIN dbo.Daily_activity_weight AS ST
ON HR.Id = ST.Id AND HR.ActivityDate = ST.ActivityDate
ORDER BY ST.ActivityDate  ASC

