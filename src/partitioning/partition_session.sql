use DentalClinicDev
go

BEGIN TRY

BEGIN TRAN;

--First, create file groups will store the rows with the `time` column in the range of 2018 and 2023
ALTER DATABASE DentalClinicDev
ADD FILEGROUP Session_lt_2018
ALTER DATABASE DentalClinicDev
ADD FILEGROUP Session_2018_2019
ALTER DATABASE DentalClinicDev
ADD FILEGROUP Session_2019_2020
ALTER DATABASE DentalClinicDev
ADD FILEGROUP Session_2020_2021
ALTER DATABASE DentalClinicDev
ADD FILEGROUP Session_2021_2022
ALTER DATABASE DentalClinicDev
ADD FILEGROUP Session_2022_2023
ALTER DATABASE DentalClinicDev
ADD FILEGROUP Session_gt_2023

ALTER DATABASE DentalClinicDev    
ADD FILE (
  NAME = Session_lt_2018,
  FILENAME = 'C:\sql_partition\Session_lt_2018.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP Session_lt_2018;

ALTER DATABASE DentalClinicDev    
ADD FILE (
  NAME = Session_2018_2019,
  FILENAME = 'C:\sql_partition\Session_2018_2019.ndf',
      SIZE = 10 MB, 
      MAXSIZE = UNLIMITED, 
      FILEGROWTH = 1024 KB
) TO FILEGROUP Session_2018_2019;

ALTER DATABASE DentalClinicDev    
ADD FILE (
    NAME = Session_2019_2020,
    FILENAME = 'C:\sql_partition\Session_2019_2020.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP Session_2019_2020;

ALTER DATABASE DentalClinicDev    
ADD FILE (
    NAME = Session_2020_2021,
    FILENAME = 'C:\sql_partition\Session_2020_2021.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
) TO FILEGROUP Session_2020_2021;

ALTER DATABASE DentalClinicDev    
ADD FILE (
    NAME = Session_2021_2022,
    FILENAME = 'C:\sql_partition\Session_2021_2022.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
) TO FILEGROUP Session_2021_2022;

ALTER DATABASE DentalClinicDev    
ADD FILE (
    NAME = Session_2022_2023,
    FILENAME = 'C:\sql_partition\Session_2022_2023.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
) TO FILEGROUP Session_2022_2023;

ALTER DATABASE DentalClinicDev    
ADD FILE (
    NAME = Session_gt_2023,
    FILENAME = 'C:\sql_partition\Session_gt_2023.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
) TO FILEGROUP Session_gt_2023;

------------Create a partition function
CREATE PARTITION FUNCTION Session_by_year_function(datetime2)
AS RANGE RIGHT 
FOR VALUES ('2018-01-01', '2019-01-01', '2020-01-01', '2021-01-01', '2022-01-01', '2023-01-01');

--Create a partition scheme
CREATE PARTITION SCHEME Session_by_year_scheme
AS PARTITION Session_by_year_function
TO (
    Session_lt_2018,
    Session_2018_2019,
    Session_2019_2020,
    Session_2020_2021,
    Session_2021_2022,
    Session_2022_2023,
    Session_gt_2023
);

--CREATE NONCLUSTERED INDEX idx_Session_time
--ON dbo.Session
--(
--	[time]
--) ON [Session_by_year_scheme]([time])

COMMIT TRAN;
END TRY

BEGIN CATCH
	PRINT(@@ERROR)
    ROLLBACK TRAN;
END CATCH;