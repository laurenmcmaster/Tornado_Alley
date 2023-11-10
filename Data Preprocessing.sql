
-- all data preprocessing was done using SQL 
-- i uploaded my cleaned dataset to my SQL Server
-- first remove NULL values
DELETE FROM Tornado_Project..tornado_data
WHERE Year IS NULL;

-- creating new column: season
ALTER TABLE Tornado_Project..tornado_data
ADD Season VARCHAR(10);

-- adding a season column to the original dataset
UPDATE Tornado_Project..tornado_data
SET Season = CASE
	WHEN Month BETWEEN 3 AND 5 THEN 'Spring'
	WHEN Month BETWEEN 6 AND 8 THEN 'Summer'
	WHEN Month BETWEEN 9 AND 11 THEN 'Fall'
	WHEN Month IN (1, 2, 12) THEN 'Winter'
END;

-- I picked 1985 because that is the halfway point in years of the dataset
-- Tornado Alley includes these states: Texas, Oklahoma, Kansas, Colorado, Nebraska, South Dakota, North Dakota, Iowa, Missouri, Arkansas, and Louisiana

------------------------------------------------------------------------
--------------TORNADO OCCURRENCES INSIDE TORNADO ALLEY-----------------

-- create a table for historical tornado occurrences inside Tornado Alley by year, state, and season
CREATE TABLE Historical_Tornado_Occurrences_Inside (
    Time_Period VARCHAR(10) DEFAULT 'Historical',
	Tornado_Alley VARCHAR(10) DEFAULT 'Inside',
    Year INT,
    State VARCHAR(2),
    Season VARCHAR(20),
    Tornado_Count INT
);

-- insert historical tornado occurrence data inside Tornado Alley into the table
INSERT INTO Historical_Tornado_Occurrences_Inside (Year, State, Season, Tornado_Count)
SELECT Year, State, Season, COUNT(*) AS Tornado_Count
FROM Tornado_Project..tornado_data
WHERE State IN ('TX', 'OK', 'KS', 'CO', 'NE', 'SD', 'ND', 'IA', 'MO', 'AR', 'LA')
AND Year < 1985
GROUP BY Year, State, Season;

-- see the data
SELECT *
FROM Historical_Tornado_Occurrences_Inside;


-- create a table for recent tornado occurrences inside Tornado Alley by year, state, and season
CREATE TABLE Recent_Tornado_Occurrences_Inside (
    Time_Period VARCHAR(10) DEFAULT 'Recent',
	Tornado_Alley VARCHAR(10) DEFAULT 'Inside',
    Year INT,
    State VARCHAR(2),
    Season VARCHAR(20),
    Tornado_Count INT
);

-- insert recent tornado occurrence data inside Tornado Alley into the table
INSERT INTO Recent_Tornado_Occurrences_Inside (Year, State, Season, Tornado_Count)
SELECT Year, State, Season, COUNT(*) AS Tornado_Count
FROM Tornado_Project..tornado_data
WHERE State IN ('TX', 'OK', 'KS', 'CO', 'NE', 'SD', 'ND', 'IA', 'MO', 'AR', 'LA')
AND Year >= 1985
GROUP BY Year, State, Season;

-- see the data
SELECT *
FROM Recent_Tornado_Occurrences_Inside;





------------------------------------------------------------------------
------------------TORNADO INTENSITY INSIDE TORNADO ALLEY----------------

-- create a table for historical intense tornado data inside Tornado Alley by state, year, and season
CREATE TABLE Historical_Intense_Tornadoes_Inside (
    Time_Period VARCHAR(10) DEFAULT 'Historical',
	Tornado_Alley VARCHAR(10) DEFAULT 'Inside',
    State VARCHAR(2),
    Year INT,
    Season VARCHAR(20),
    Intense_Tornado_Count INT,
    Max_Intensity INT
);

-- insert historical intense tornado data inside Tornado Alley into the table
INSERT INTO Historical_Intense_Tornadoes_Inside (State, Year, Season, Intense_Tornado_Count, Max_Intensity)
SELECT State, Year, Season, COUNT(*) AS Intense_Tornado_Count, MAX(f_rating) AS Max_Intensity
FROM Tornado_Project..tornado_data
WHERE State IN ('TX', 'OK', 'KS', 'CO', 'NE', 'SD', 'ND', 'IA', 'MO', 'AR', 'LA')
AND Year < 1985
AND (f_rating = 4 OR f_rating = 5)
GROUP BY State, Year, Season;

-- see the data
SELECT *
FROM Historical_Intense_Tornadoes_Inside;


-- create a table for more recent intense tornado data inside Tornado Alley
CREATE TABLE Recent_Intense_Tornadoes_Inside (
    Time_Period VARCHAR(10) DEFAULT 'Recent',
	Tornado_Alley VARCHAR(10) DEFAULT 'Inside',
    State VARCHAR(2),
    Year INT,
    Season VARCHAR(20),
    Intense_Tornado_Count INT,
    Max_Intensity INT
);


-- insert recent intense tornado data inside Tornado Alley into the table
INSERT INTO Recent_Intense_Tornadoes_Inside (State, Year, Season, Intense_Tornado_Count, Max_Intensity)
SELECT State, Year, Season, COUNT(*) AS Intense_Tornado_Count, MAX(f_rating) AS Max_Intensity
FROM Tornado_Project..tornado_data
WHERE State IN ('TX', 'OK', 'KS', 'CO', 'NE', 'SD', 'ND', 'IA', 'MO', 'AR', 'LA')
AND Year >= 1985
AND (f_rating = 4 OR f_rating = 5)
GROUP BY State, Year, Season;

-- see the data
SELECT *
FROM Recent_Intense_Tornadoes_Inside;





------------------------------------------------------------------------
--------------TORNADO OCCURRENCES OUTSIDE TORNADO ALLEY-----------------

-- create a table for historical tornado occurrences outside Tornado Alley by year, state, and season
CREATE TABLE Historical_Tornado_Occurrences_Outside (
    Time_Period VARCHAR(10) DEFAULT 'Historical',
	Tornado_Alley VARCHAR(10) DEFAULT 'Outside',
    Year INT,
    State VARCHAR(2),
    Season VARCHAR(20),
    Tornado_Count INT
);

-- insert historical tornado occurrence data outside Tornado Alley into the table
INSERT INTO Historical_Tornado_Occurrences_Outside (Year, State, Season, Tornado_Count)
SELECT Year, State, Season, COUNT(*) AS Tornado_Count
FROM Tornado_Project..tornado_data
WHERE State NOT IN ('TX', 'OK', 'KS', 'CO', 'NE', 'SD', 'ND', 'IA', 'MO', 'AR', 'LA')
AND Year < 1985
GROUP BY Year, State, Season;

-- see the data
SELECT *
FROM Historical_Tornado_Occurrences_Outside;


-- create a table for recent tornado occurrences outside Tornado Alley by year, state, and season
CREATE TABLE Recent_Tornado_Occurrences_Outside (
    Time_Period VARCHAR(10) DEFAULT 'Recent',
	Tornado_Alley VARCHAR(10) DEFAULT 'Outside',
    Year INT,
    State VARCHAR(2),
    Season VARCHAR(20),
    Tornado_Count INT
);

-- insert recent tornado occurrence data outside Tornado Alley into the table
INSERT INTO Recent_Tornado_Occurrences_Outside (Year, State, Season, Tornado_Count)
SELECT Year, State, Season, COUNT(*) AS Tornado_Count
FROM Tornado_Project..tornado_data
WHERE State NOT IN ('TX', 'OK', 'KS', 'CO', 'NE', 'SD', 'ND', 'IA', 'MO', 'AR', 'LA')
AND Year >= 1985
GROUP BY Year, State, Season;

-- see the data
SELECT *
FROM Recent_Tornado_Occurrences_Outside;





------------------------------------------------------------------------
--------------TORNADO INTENSITY OUTSIDE TORNADO ALLEY-------------------

-- create a table for historical intense tornado data outside Tornado Alley by state, year, and season
CREATE TABLE Historical_Intense_Tornadoes_Outside (
    Time_Period VARCHAR(10) DEFAULT 'Historical',
	Tornado_Alley VARCHAR(10) DEFAULT 'Outside',
    State VARCHAR(2),
    Year INT,
    Season VARCHAR(20),
    Intense_Tornado_Count INT,
    Max_Intensity INT
);

-- insert historical intense tornado data outside Tornado Alley into the table
INSERT INTO Historical_Intense_Tornadoes_Outside (State, Year, Season, Intense_Tornado_Count, Max_Intensity)
SELECT State, Year, Season, COUNT(*) AS Intense_Tornado_Count, MAX(f_rating) AS Max_Intensity
FROM Tornado_Project..tornado_data
WHERE State NOT IN ('TX', 'OK', 'KS', 'CO', 'NE', 'SD', 'ND', 'IA', 'MO', 'AR', 'LA')
AND Year < 1985
AND (f_rating = 4 OR f_rating = 5)
GROUP BY State, Year, Season;

-- see the data
SELECT *
FROM Historical_Intense_Tornadoes_Outside;


-- create a table for more recent intense tornado data outside Tornado Alley
CREATE TABLE Recent_Intense_Tornadoes_Outside (
    Time_Period VARCHAR(10) DEFAULT 'Recent',
	Tornado_Alley VARCHAR(10) DEFAULT 'Outside',
    State VARCHAR(2),
    Year INT,
    Season VARCHAR(20),
    Intense_Tornado_Count INT,
    Max_Intensity INT
);

-- insert recent intense tornado data outside Tornado Alley into the table
INSERT INTO Recent_Intense_Tornadoes_Outside (State, Year, Season, Intense_Tornado_Count, Max_Intensity)
SELECT State, Year, Season, COUNT(*) AS Intense_Tornado_Count, MAX(f_rating) AS Max_Intensity
FROM Tornado_Project..tornado_data
WHERE State NOT IN ('TX', 'OK', 'KS', 'CO', 'NE', 'SD', 'ND', 'IA', 'MO', 'AR', 'LA')
AND Year >= 1985
AND (f_rating = 4 OR f_rating = 5)
GROUP BY State, Year, Season;

-- see the data
SELECT *
FROM Recent_Intense_Tornadoes_Outside;





