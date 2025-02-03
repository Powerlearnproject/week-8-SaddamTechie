CREATE TABLE Regions (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(100),
    UrbanRural VARCHAR(50)
);

CREATE TABLE HealthcareFacilities (
    FacilityID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    Services VARCHAR(255),
    Capacity INT,
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

CREATE TABLE MaternalMortality (
    RegionID INT,
    Year INT,
    MortalityRate FLOAT,
    PRIMARY KEY (RegionID, Year),
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);

CREATE TABLE Population (
    RegionID INT,
    Year INT,
    PopulationCount INT,
    PRIMARY KEY (RegionID, Year),
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);



-- Sample Data

INSERT INTO Regions (RegionID, RegionName, UrbanRural) VALUES
(1, 'Region A', 'Urban'),
(2, 'Region B', 'Rural'),
(3, 'Region C', 'Rural'),
(4, 'Region D', 'Urban'),
(5, 'Region E', 'Rural');



INSERT INTO HealthcareFacilities (FacilityID, Name, Location, Services, Capacity, RegionID) VALUES
(1, 'Clinic A', 'Location A', 'Maternal Care', 100, 1),
(2, 'Clinic B', 'Location B', 'General Care', 50, 2),
(3, 'Clinic C', 'Location C', 'Maternal Care', 80, 3),
(4, 'Clinic D', 'Location D', 'General Care', 120, 4),
(5, 'Clinic E', 'Location E', 'Maternal Care', 60, 5),
(6, 'Clinic F', 'Location F', 'General Care', 90, 1),
(7, 'Clinic G', 'Location G', 'Maternal Care', 70, 2),
(8, 'Clinic H', 'Location H', 'General Care', 110, 3),
(9, 'Clinic I', 'Location I', 'Maternal Care', 85, 4),
(10, 'Clinic J', 'Location J', 'General Care', 95, 5);




INSERT INTO MaternalMortality (RegionID, Year, MortalityRate) VALUES
(1, 2020, 0.6),
(1, 2021, 0.55),
(1, 2022, 0.5),
(2, 2020, 1.5),
(2, 2021, 1.3),
(2, 2022, 1.2),
(3, 2020, 1.8),
(3, 2021, 1.7),
(3, 2022, 1.6),
(4, 2020, 0.7),
(4, 2021, 0.65),
(4, 2022, 0.6),
(5, 2020, 2.0),
(5, 2021, 1.9),
(5, 2022, 1.8);





INSERT INTO Population (RegionID, Year, PopulationCount) VALUES
(1, 2020, 9500),
(1, 2021, 9800),
(1, 2022, 10000),
(2, 2020, 4800),
(2, 2021, 4900),
(2, 2022, 5000),
(3, 2020, 7500),
(3, 2021, 7700),
(3, 2022, 8000),
(4, 2020, 12000),
(4, 2021, 12500),
(4, 2022, 13000),
(5, 2020, 4500),
(5, 2021, 4600),
(5, 2022, 4700);








-- Data Retrieval
-- Retrieve maternal mortality rates by region
SELECT R.RegionName, M.MortalityRate
FROM MaternalMortality M
JOIN Regions R ON M.RegionID = R.RegionID
WHERE M.Year = 2022;

-- Retrieve healthcare facilities in rural areas
SELECT H.Name, H.Location, H.Services
FROM HealthcareFacilities H
JOIN Regions R ON H.RegionID = R.RegionID
WHERE R.UrbanRural = 'Rural';


-- Data Analysis
-- Compare maternal mortality rates between urban and rural areas
SELECT R.UrbanRural, AVG(M.MortalityRate) AS AvgMortalityRate
FROM MaternalMortality M
JOIN Regions R ON M.RegionID = R.RegionID
GROUP BY R.UrbanRural;

-- Identify regions with high mortality rates and low healthcare capacity
SELECT R.RegionName, M.MortalityRate, SUM(H.Capacity) AS TotalCapacity
FROM MaternalMortality M
JOIN Regions R ON M.RegionID = R.RegionID
JOIN HealthcareFacilities H ON R.RegionID = H.RegionID
WHERE M.MortalityRate > 1.0
GROUP BY R.RegionName, M.MortalityRate;