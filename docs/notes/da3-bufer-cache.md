---
title: DA#3 - Buffer Cache
date-of-creation: 2023-07-24
date-last-updated: 2023-07-24
description: SQL Server Buffer Cache
---

- Whenever data is written to or read from a SQL Server database, it will be copied into memory by the buffer manager.
- The buffer cache (also known as the buffer pool) will use as much memory as is allocated to it in order to hold as many pages of data as possible.
- When the buffer cache fills up, older and less used data will be purged in order to make room for newer data.

---

```sql
-- overview of the current state of memory usage
SELECT
	physical_memory_kb,
	virtual_memory_kb,
	committed_kb,
	committed_target_kb
FROM sys.dm_os_sys_info;
```

- physical_memory_kb: Total physical memory installed on the server.
- virtual_memory_kb: Total amount of virtual memory available to SQL Server. Ideally, we do not want to utilize this often as virtual memory (using a page file on disk or somewhere that isn’t memory) is going to be significantly slower than a memory.
- Committed_kb: The amount of memory currently allocated by the buffer cache for use by database pages.
- Committed_target_kb: This is the amount of memory the buffer cache “wants” to use. If the amount currently in use (indicated by committed_kb) is higher than this amount, then the buffer manager will begin to remove older pages from memory. If the amount currently in use is lower then the buffer manager will allocate more memory for our data.

---

```sql
--  information about the buffer cache
SELECT
    databases.name AS database_name,
    COUNT(*) * 8 / 1024 AS mb_used
FROM sys.dm_os_buffer_descriptors
INNER JOIN sys.databases
ON databases.database_id = dm_os_buffer_descriptors.database_id
GROUP BY databases.name
ORDER BY COUNT(*) DESC;
```

This query returns, in order from most pages in memory to fewest, the amount of memory consumed by each database in the buffer cache
This query can be a useful way to quickly determine which database accounts for the most memory usage in the buffer cache. On a multi-tenant architecture, or a server in which there are many key databases sharing resources, this can be a quick method to find a database that is performing poorly or hogging memory at any given time.

---

We can view overall totals as a page or byte count:

```sql
SELECT
	COUNT(*) AS buffer_cache_pages,
	COUNT(*) * 8 / 1024 AS buffer_cache_used_MB
FROM sys.dm_os_buffer_descriptors;
```

This returns a single row containing the number of pages in the buffer cache, as well as the memory consumed by them in megabytes.

---

The following query will return buffer pages and size by table:
```sql
SELECT
	objects.name AS object_name,
	objects.type_desc AS object_type_description,
	COUNT(*) AS buffer_cache_pages,
	COUNT(*) * 8 / 1024  AS buffer_cache_used_MB
FROM sys.dm_os_buffer_descriptors
INNER JOIN sys.allocation_units
ON allocation_units.allocation_unit_id = dm_os_buffer_descriptors.allocation_unit_id
INNER JOIN sys.partitions
ON ((allocation_units.container_id = partitions.hobt_id AND type IN (1,3))
OR (allocation_units.container_id = partitions.partition_id AND type IN (2)))
INNER JOIN sys.objects
ON partitions.object_id = objects.object_id
WHERE allocation_units.type IN (1,2,3)
AND objects.is_ms_shipped = 0
AND dm_os_buffer_descriptors.database_id = DB_ID()
GROUP BY objects.name,
		 objects.type_desc
ORDER BY COUNT(*) DESC;
```

System tables are excluded, and this will only pull data for the current database. Indexed views will be included as their indexes are distinct entities from the tables they are derived from. The join on sys.partitions contains two parts in order to account for indexes, as well as heaps. The data shown here include all indexes on a table, as well as the heap if there are none defined.

---

Similarly, we can split out this data by index, instead of by table, providing even further granularity on buffer cache usage:

```sql
SELECT
	indexes.name AS index_name,
	objects.name AS object_name,
	objects.type_desc AS object_type_description,
	COUNT(*) AS buffer_cache_pages,
	COUNT(*) * 8 / 1024  AS buffer_cache_used_MB
FROM sys.dm_os_buffer_descriptors
INNER JOIN sys.allocation_units
ON allocation_units.allocation_unit_id = dm_os_buffer_descriptors.allocation_unit_id
INNER JOIN sys.partitions
ON ((allocation_units.container_id = partitions.hobt_id AND type IN (1,3))
OR (allocation_units.container_id = partitions.partition_id AND type IN (2)))
INNER JOIN sys.objects
ON partitions.object_id = objects.object_id
INNER JOIN sys.indexes
ON objects.object_id = indexes.object_id
AND partitions.index_id = indexes.index_id
WHERE allocation_units.type IN (1,2,3)
AND objects.is_ms_shipped = 0
AND dm_os_buffer_descriptors.database_id = DB_ID()
GROUP BY indexes.name,
		 objects.name,
		 objects.type_desc
ORDER BY COUNT(*) DESC;
```

The results provide even more detail on how the buffer cache is being used, and can be valuable on tables with many indexes of varied use. The results can be useful when trying to determine the overall level of usage for a specific index at any given time. In addition, it allows us to gauge how much of an index is being read, compared to its overall size.

---

To collect the percentage of each table that is in memory, we can put that query into a CTE and compare the pages in memory vs the total for each table:

```sql
WITH CTE_BUFFER_CACHE AS (
	SELECT
		objects.name AS object_name,
		objects.type_desc AS object_type_description,
		objects.object_id,
		COUNT(*) AS buffer_cache_pages,
		COUNT(*) * 8 / 1024  AS buffer_cache_used_MB
	FROM sys.dm_os_buffer_descriptors
	INNER JOIN sys.allocation_units
	ON allocation_units.allocation_unit_id = dm_os_buffer_descriptors.allocation_unit_id
	INNER JOIN sys.partitions
	ON ((allocation_units.container_id = partitions.hobt_id AND type IN (1,3))
	OR (allocation_units.container_id = partitions.partition_id AND type IN (2)))
	INNER JOIN sys.objects
	ON partitions.object_id = objects.object_id
	WHERE allocation_units.type IN (1,2,3)
	AND objects.is_ms_shipped = 0
	AND dm_os_buffer_descriptors.database_id = DB_ID()
	GROUP BY objects.name,
			 objects.type_desc,
			 objects.object_id)
SELECT
	PARTITION_STATS.name,
	CTE_BUFFER_CACHE.object_type_description,
	CTE_BUFFER_CACHE.buffer_cache_pages,
	CTE_BUFFER_CACHE.buffer_cache_used_MB,
	PARTITION_STATS.total_number_of_used_pages,
	PARTITION_STATS.total_number_of_used_pages * 8 / 1024 AS total_mb_used_by_object,
	CAST((CAST(CTE_BUFFER_CACHE.buffer_cache_pages AS DECIMAL) / CAST(PARTITION_STATS.total_number_of_used_pages AS DECIMAL) * 100) AS DECIMAL(5,2)) AS percent_of_pages_in_memory
FROM CTE_BUFFER_CACHE
INNER JOIN (
	SELECT 
		objects.name,
		objects.object_id,
		SUM(used_page_count) AS total_number_of_used_pages
	FROM sys.dm_db_partition_stats
	INNER JOIN sys.objects
	ON objects.object_id = dm_db_partition_stats.object_id
	WHERE objects.is_ms_shipped = 0
	GROUP BY objects.name, objects.object_id) PARTITION_STATS
ON PARTITION_STATS.object_id = CTE_BUFFER_CACHE.object_id
ORDER BY CAST(CTE_BUFFER_CACHE.buffer_cache_pages AS DECIMAL) / CAST(PARTITION_STATS.total_number_of_used_pages AS DECIMAL) DESC;
```

This query compares what’s currently in the buffer cache vs. the total space used by any given table. This data can tell us which tables are hot spots in our database, and with some knowledge of their application usage, we can determine which ones simply have too much data residing in memory.

---

`DBCC DROPCLEANBUFFERS` is a command that should typically only be run in a non-production environment, and even then, only when there is no performance or load testing being conducted. The result of this command is that the buffer cache will end up mostly empty. This can be a useful development tool in that you can run a query in a performance testing environment over and over without any changes in speed/efficiency due to caching of data in memory. Drop the clean buffer data between executions and you’re in business

## Page Life Expectancy

When discussing memory performance in SQL Server, it is unlikely that we would go a few minutes before someone asks about page life expectancy (PLE for short). PLE is a measure of, on average, how long (in seconds) will a page remain in memory without being accessed, after which point it is removed. This is a metric that we want to be higher as we want our important data to remain in the buffer cache for as long as possible. When PLE gets too low, data is being constantly read from disk (aka: slow) into the buffer cache, removed from the cache, and likely read from disk again in the near future. This is the recipe for a slow (and frustrating) SQL Server!