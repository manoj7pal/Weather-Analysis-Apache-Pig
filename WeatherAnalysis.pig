--Load Temperature Dataset
TEMP = LOAD 'datasets/Temperature' using PigStorage(' ') as (year: int, temp:int);

-- DUMP TEMP;

--Temp of year 2011
TEMP_2011 = FILTER TEMP BY year==2011;	

--Group by Year
GROUP_TEMP = GROUP TEMP BY year;

--Maximum Temp for each Year
MAX_TEMP_YEAR = FOREACH GROUP_TEMP GENERATE group as year, MAX(TEMP.temp);

--Average Temperature of each year
AVG_TEMP = FOREACH GROUP_TEMP GENERATE group as year, AVG(TEMP.temp) as Avg_Temp;

--Max Average Overall
DESC_AVG = ORDER AVG_TEMP BY Avg_Temp desc;
MAX_AVG = LIMIT DESC_AVG 1;

--Year - which crossed 45 degress
TEMP_45 = FILTER TEMP BY temp>45;
YEAR_45 = FOREACH TEMP_45 GENERATE year;
DIST_45_YEAR = DISTINCT YEAR_45;

