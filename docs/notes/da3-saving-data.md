---
title: DA#3 - Overview
date-of-creation: 2023-07-26
date-last-updated: 2023-07-26
description: How SQL Server saves data
---

# How is data physically stored in SQL Server

Data in tables is stored in row and column format at the logical level, but physically it stores data in something called data pages. A data page is the fundamental unit of data storage in SQL Server and it is 8KB in size. When we insert any data in to a SQL Server database table, it saves that data to a series of 8 KB data pages.

![Data Page](https://www.pragimtech.com/blog/contribute/article_images/1220210328005839/how-is-data-stored-physically-in-sql-server.png)

# Note on Performance Tuning

- Query Optimization
- Indexing
- Partitioning
- Caching
