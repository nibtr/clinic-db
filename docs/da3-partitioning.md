---
title: DA#3 - Partition
date-of-creation: 2023-07-12
date-last-updated: 2023-07-12
description: Partition Process
---

# Overview

We take into account the following tables for partitioning since they hold the most data:

| Table                | No of records (to date) |
| -------------------- | ----------------------- |
| Patient              | ~30000                  |
| AppointmentRequest   | ~100000                 |
| Session              | ~200000                 |
| TreatmentSession     | ~65000                  |
| ExaminationSession   | ~60000                  |
| ReExaminationSession | ~50000                  |
| PaymentRecord        | ~100000                 |

## Use case 1:

**Session** table is partitioned by the `time` column, which is of `datetime2` value. We partition the table by 1 year intervals, i.e. 1 partition for each year. This is useful for the following reasons:

-  When the clinic wants to view the sessions for a particular year (for statistics, etc.), the query will only have to search through the partition for that year, instead of the entire table.
-  Statistics such as:
   -  Number of sessions per year
   -  Number of sessions per month in a year
   -  etc.
can be easily obtained by querying the partition for that year.
- The `time` column is also common is most queries, hence partitioning by `time` will speed up most queries.
- The data is smaller and more manageable, since the data is split into partitions.

Special use case such as view the total number of sessions ever held can be slow due to the need to query all partitions. However, this is not a common use case and can be a trade-off for the above benefits.

## Use case 2:

**AppointmentRequest** table is partitioned by the `appointmentTime` column, which is of `datetime2` value. We partition the table by 1 year intervals, i.e. 1 partition for each year. This is useful for the following reasons:

- When the clinic wants to view the appointment requests for a particular year (for statistics, etc.), the query will only have to search through the partition for that year, instead of the entire table.
- Statistics such as:
  - Number of appointment requests per year
  - Number of appointment requests per month in a year
  - etc.
can be easily obtained by querying the partition for that year.
- The `appointmentTime` column is also common is most queries, hence partitioning by `appointmentTime` will speed up most queries.
- The data is smaller and more manageable, since the data is split into partitions.

Special use case such as view the total number of appointment requests ever made can be slow due to the need to query all partitions. However, this is not a common use case and can be a trade-off for the above benefits.
