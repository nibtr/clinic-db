use DentalClinicDev
go

BEGIN TRY

BEGIN TRAN;

--First, create file groups will store the rows with the `time` column in the range of 2018 and 2023
ALTER DATABASE DentalClinicDev
ADD FILEGROUP AppointmentRequest_lt_2018
ALTER DATABASE DentalClinicDev
ADD FILEGROUP AppointmentRequest_2018_2019
ALTER DATABASE DentalClinicDev
ADD FILEGROUP AppointmentRequest_2019_2020
ALTER DATABASE DentalClinicDev
ADD FILEGROUP AppointmentRequest_2020_2021
ALTER DATABASE DentalClinicDev
ADD FILEGROUP AppointmentRequest_2021_2022
ALTER DATABASE DentalClinicDev
ADD FILEGROUP AppointmentRequest_2022_2023
ALTER DATABASE DentalClinicDev
ADD FILEGROUP AppointmentRequest_gt_2023

ALTER DATABASE DentalClinicDev    
ADD FILE (
  NAME = AppointmentRequest_lt_2018,
  FILENAME = 'C:\sql_partition\AppointmentRequest_lt_2018.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP AppointmentRequest_lt_2018;

ALTER DATABASE DentalClinicDev    
ADD FILE (
  NAME = AppointmentRequest_2018_2019,
  FILENAME = 'C:\sql_partition\AppointmentRequest_2018_2019.ndf',
      SIZE = 10 MB, 
      MAXSIZE = UNLIMITED, 
      FILEGROWTH = 1024 KB
) TO FILEGROUP AppointmentRequest_2018_2019;

ALTER DATABASE DentalClinicDev    
ADD FILE (
    NAME = AppointmentRequest_2019_2020,
    FILENAME = 'C:\sql_partition\AppointmentRequest_2019_2020.ndf',
    SIZE = 10 MB, 
    MAXSIZE = UNLIMITED, 
    FILEGROWTH = 1024 KB
) TO FILEGROUP AppointmentRequest_2019_2020;

ALTER DATABASE DentalClinicDev    
ADD FILE (
    NAME = AppointmentRequest_2020_2021,
    FILENAME = 'C:\sql_partition\AppointmentRequest_2020_2021.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
) TO FILEGROUP AppointmentRequest_2020_2021;

ALTER DATABASE DentalClinicDev    
ADD FILE (
    NAME = AppointmentRequest_2021_2022,
    FILENAME = 'C:\sql_partition\AppointmentRequest_2021_2022.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
) TO FILEGROUP AppointmentRequest_2021_2022;

ALTER DATABASE DentalClinicDev    
ADD FILE (
    NAME = AppointmentRequest_2022_2023,
    FILENAME = 'C:\sql_partition\AppointmentRequest_2022_2023.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
) TO FILEGROUP AppointmentRequest_2022_2023;

ALTER DATABASE DentalClinicDev    
ADD FILE (
    NAME = AppointmentRequest_gt_2023,
    FILENAME = 'C:\sql_partition\AppointmentRequest_gt_2023.ndf',
        SIZE = 10 MB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
) TO FILEGROUP AppointmentRequest_gt_2023;

------------Create a partition function
CREATE PARTITION FUNCTION AppointmentRequest_by_year_function(datetime2)
AS RANGE RIGHT 
FOR VALUES ('2018-01-01', '2019-01-01', '2020-01-01', '2021-01-01', '2022-01-01', '2023-01-01');

--Create a partition scheme
CREATE PARTITION SCHEME AppointmentRequest_by_year_scheme
AS PARTITION AppointmentRequest_by_year_function
TO (
    AppointmentRequest_lt_2018,
    AppointmentRequest_2018_2019,
    AppointmentRequest_2019_2020,
    AppointmentRequest_2020_2021,
    AppointmentRequest_2021_2022,
    AppointmentRequest_2022_2023,
    AppointmentRequest_gt_2023
);

--CREATE NONCLUSTERED INDEX idx_AppointmentRequest_time
--ON dbo.AppointmentRequest
--(
--	[appointmentTime]
--) ON [AppointmentRequest_by_year_scheme]([time])

COMMIT TRAN;
END TRY

BEGIN CATCH
	PRINT(@@ERROR)
    ROLLBACK TRAN;
END CATCH;
