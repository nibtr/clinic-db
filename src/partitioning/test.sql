--To check the number of rows in each partition, you use the following query:
SELECT 
	p.partition_number AS partition_number,
	f.name AS file_group, 
	p.rows AS row_count
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'Session'
order by partition_number;

-- Confirm Filegroups
SELECT name as [File Group Name]
FROM sys.filegroups
WHERE type = 'FG'
GO -- Confirm Datafiles
SELECT name as [DB File Name],physical_name as [DB File Path] 
FROM sys.database_files
where type_desc = 'ROWS'
GO

--select data from a specific partition
SELECT *
FROM dbo.Session
WHERE $PARTITION.Session_by_year_function(time) = 1

--select data from a specific partition
SELECT *
FROM dbo.Session
WHERE $PARTITION.Session_by_year_function(time) = 6

--Get the partition number
SELECT $PARTITION.Session_by_year_function('2024-01-01') 

select * from session
where time >= '2021-01-01 00:00:00' and time < '2022-01-01 00:00:00'