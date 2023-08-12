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
| PaymentRecord        | ~200000                 |

<!-- ## Use case 1:

**PaymentRecord** table is partitioned by the `paid` column, which is of `int` value. The value of `paid` is either 0 by default, denoting unpaid, or the amount paid by the patient. The value of `paid` is updated to the amount paid by the patient when the patient pays for the treatment. Hence, we can partition the table by the value of `paid` to separate the paid and unpaid records. -->

## Use case 1:

**Session** table is partitioned by the `date` column, which is of `date` value. We partition the table by 1 year intervals, i.e. 1 partition for each year. This is useful for the following reasons:

-  When the clinic wants to view the sessions for a particular year (for statistics, etc.), the query will only have to search through the partition for that year, instead of the entire table.
-  Statistics such as:
   -  Number of sessions per year
   -  Number of sessions per month in a year
   -  etc.
can be easily obtained by querying the partition for that year.
- The `date` column is also common is most queries, hence partitioning by `date` will speed up most queries.
- The data is smaller and more manageable, since the data is split into partitions.

Special use case such as view the total number of sessions ever held can be slow due to the need to query all partitions. However, this is not a common use case and can be a trade-off for the above benefits.

## Use case 2:

**AppointmentRequest** table is partitioned by the `date` column, which is of `date` value. We partition the table by 1 year intervals, i.e. 1 partition for each year. This is useful for the following reasons: