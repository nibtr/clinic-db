---
title: DA#3 - Indexing
date-of-creation: 2023-08-15
date-last-updated: 2023-08-15
description: This document describes the indexing process of the database.
---

## Indexing 

### Appointment Request Table: 

**Create a non clustered index on `appointmentTime` and `requestTime`**

- *Appointment Request Table* is a large table with a lot of data and is added on a daily basis, staffs also need to query frequently to schedule appointments for patients.
- Staffs will usually rely on the `appointmentTime` of an appointment request to create a schedule, that is why it is necessary to index on `appointmentTime`.
- According to the business, every day, staffs will usually check the appointment requests made on the same day (`requestTime` = TODAY), so indexing on `requestTime` is necessary when the query frequency occurs daily.

Consider the following query. The query is used to find appointments that are requested on the same day. Although due to the randomness of the data, we change the year difference to 1 instead of 0:

```sql
select * from AppointmentRequest
where DATEDIFF(YEAR, requestTime, GETDATE()) = 1
```

Without index, the execution plan is as follows:

![Alt text](../assets/index-1.png)

![Alt text](image.png)

With index, the execution plan is as follows:

### Session Table:

**Create non clustered index on `time`, `patientID`, `dentistID`**

- *Session Table* is a large table (around 200000 rows) and is the most important table in the database. It is also the table that is queried the most frequently.
- Fields such as `time`, `patientID`, `dentistID` are fields that are rarely updated once created. Because of this, we can indexing on these fields to reduce the query time:
  - Indexing on `time` to reduce the query time of sessions, which include treatment sessions, examinations, re-examinations. According to the business, the query frequency of these sessions is very high and also occurs daily.
  - Indexing on `patientID`, `dentistID` to reduce the query time when joining the `Session` table with the `Patient` or `Personnel` table, as well as querying the `Session` table by `patientID`, `dentistID`, some of which include searching for the sessions of a patient, the sessions of a dentist, etc.
  - Create an index on `type` to reduce the query time when querying the `Session` table by `type`. By doing this, we can search for the type of a session (treatment session, examination, re-examination) faster. In addition, according to the database design, the *Treatment Session Table*, *Examination Table*, *Re-examination Table* are all inherited from the *Session Table*, so indexing on `type` is necessary when the query frequency of these tables is very high.

 <!-- hình minh chứng -->

### Payment Record Table:

**Create a non clustered index on `patientID`**

- *Payment Record Table* is a table with a 1-1 relationship with the *Treatment Session Table*, whose data is also very large.
- Indexing on the foreign key `patientID` will speed up the query when we want to get information related to the patient of a payment record, get the payment records of a patient, etc.

  <!-- hình minh chứng -->

### Prescription Table:

**Clustered index on `treatmentSessionID`, `drugID`**

- `treatmentSessionID` together with `drugID` form a composite primary key, so they already have a clustered index. However, sorting `treatmentSessionID` first plays an important role in speeding up the query when most of the conditions in the query use `treatmentSessionID` to compare or to search.

### ToothSession Table:

**Clustered index on `treatmentSessionID`, `toothID`**

Similar to the *Prescription Table*, `treatmentSessionID`, `toothID` have already been indexed as a composite primary key, but sorting `treatmentSessionID` first plays an important role when most of the conditions in the query use `treatmentSessionID` to compare or to search.
