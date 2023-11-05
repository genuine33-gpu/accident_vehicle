DROP TABLE olist_customers_dataset;
Select * from accident;
Select * from vehicle;	


--Q1: Lets look at how many accidents have occurred in urban areas vs rural areas?
	
SELECT
	"Area",
	COUNT("AccidentIndex") AS "Total Accident"
FROM 
	accident
GROUP BY 
	"Area";

--Q2: Explore the highest number of accidents in week of days?

SELECT 
"Day", 
COUNT("AccidentIndex") AS "Total Accident" 
from accident
GROUP BY ("Day")
ORDER BY ("Total Accident" ) Desc;

--Q3: Search the average age of vehicles involved in accidents based on their type?
SELECT
"VehicleType",
AVG ("AgeVehicle") as "AVG Vehicle Age"
FROM vehicle
WHERE "VehicleType" IS NOT NULL 
AND "VehicleType" !=  'Data missing or out of range'
GROUP BY ("VehicleType")
HAVING
    AVG ("AgeVehicle") IS NOT NULL
ORDER BY "AVG Vehicle Age" DESC;



--Q4: Search the number of accidents based on vehicle type
SELECT
"VehicleType",
COUNT("AccidentIndex") as "Number of Accidents"
FROM vehicle
WHERE "VehicleType" IS NOT NULL
AND "VehicleType" != 'Data missing or out of range'
GROUP BY ("VehicleType")
HAVING
COUNT("AccidentIndex") > 0
ORDER BY "Number of Accidents" DESC;


--Q4: Categorize the age of vehicles involved in accidents?

SELECT 
    "AgeGroup",
    COUNT("AccidentIndex") AS "Total Accident" 
FROM (
    SELECT 
        "AccidentIndex",
        CASE 
            WHEN "AgeVehicle" BETWEEN 0 AND 5 THEN 'New'
            WHEN "AgeVehicle" BETWEEN 6 AND 10 THEN 'Regular'
            ELSE 'Old'
        END AS "AgeGroup"
    FROM 
        "vehicle"
) AS subquery
GROUP BY 
    "AgeGroup"
ORDER BY  "Total Accident"  DESC;



--Q5: Lets look at serious and fatal accidents?

SELECT "Severity", 
	COUNT("AccidentIndex") AS "Total Accident" 
	FROM "accident"
	WHERE "Severity" ='Serious' OR "Severity" ='Fatal'
GROUP BY "Severity";



--Q6: Lets look at fatal accidents based on weather conditions?

SELECT "WeatherConditions", 
	COUNT("AccidentIndex") AS "Total Accident" 
	FROM "accident"
	WHERE "Severity" ='Fatal'
GROUP BY "WeatherConditions"
ORDER BY  "Total Accident"   DESC;


--Q7: Relationships between journey purposes and fatal accidents?
SELECT 
    v."JourneyPurpose",
    COUNT(a."AccidentIndex") AS "Total Accident"
FROM 
    "accident" a

JOIN 
    "vehicle" v ON a."AccidentIndex" = v."AccidentIndex"
WHERE "Severity" ='Fatal'
GROUP BY 
    v."JourneyPurpose";


--Q8: Relationships between journey purposes and the severity of accidents?
SELECT 
    v."JourneyPurpose",
    COUNT(CASE WHEN a."Severity" = 'Fatal' THEN 1 END) AS "Fatal",
    COUNT(CASE WHEN a."Severity" = 'Serious' THEN 1 END) AS "Serious",
    COUNT(CASE WHEN a."Severity" = 'Slight' THEN 1 END) AS "Slight"
FROM 
    "accident" a
JOIN 
    "vehicle" v ON a."AccidentIndex" = v."AccidentIndex"
GROUP BY 
    v."JourneyPurpose";




















