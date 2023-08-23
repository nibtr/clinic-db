---
title: DA#3 - Transactions
date-of-creation: 2023-08-02
date-last-updated: 2023-08-03
description: Transactions Analysis
---

# List of Transactions

Below are the list of functionalities (transactions) that the system will provide. The list is divided into 3 parts: Admin, Dentist, Staff. Each part will have a list of transactions that the user can perform, with their appropriate estimated frequency.

## Admin, Dentist, Staff

| Order | Functionality | Frequency |
| ----- | ------------- | --------- |
| ALL1  | Login         | 1-5/day   |

## Admin

| Order | Functionality                 | Frequency  |
| ----- | ----------------------------- | ---------- |
| ADM1  | Add staff details             | 0-1/year   |
| ADM2  | Update staff details          | 1/year     |
| ADM3  | Delete staff details          | 0-1/year   |
| ADM4  | View staff details            | 1/month    |
| ADM5  | Add dentist details           | 0-1/year   |
| ADM6  | Update dentist details        | 0-1/year   |
| ADM7  | Delete dentist details        | 0-1/year   |
| ADM8  | View dentist details          | 1/month    |
| ADM9  | Add room details              | 0-1/year   |
| ADM10 | Update room details           | 0-1/year   |
| ADM11 | Delete room details           | 0-1/year   |
| ADM12 | View room details             | 1-2/month  |
| ADM13 | Add drug details              | 15-20/week |
| ADM14 | Update drug details           | 10-15/week |
| ADM15 | Delete drug details           | 0-5/week   |
| ADM16 | View drug details             | 10-15/week |
| ADM17 | Add procedure details         | 0-1/month  |
| ADM18 | Update procedure details      | 0-1/month  |
| ADM19 | Delete procedure details      | 0-1/month  |
| ADM20 | View procedure details        | 5-10/week  |
| ADM21 | Add category details          | 0-1/month  |
| ADM22 | Update category details       | 0-1/month  |
| ADM23 | Delete category details       | 0-1/month  |
| ADM24 | View category details         | 8-12/week  |
| ADM25 | Add schedule for a dentist    | 1-2/year   |
| ADM26 | Update schedule for a dentist | 1-2/month  |
| ADM27 | Delete schedule for a dentist | 0-1/year   |
| ADM28 | View schedule for a dentist   | 0-1/week   |
| ADM29 | Update account details        | 0-1/year   |
| ADM30 | View account details          | 0-1/month  |

## Staff

| Order | Functionality                                                | Frequency  |
| ----- | ------------------------------------------------------------ | ---------- |
| STA1  | View patient's appointment requests                          | 20-30/hour |
| STA2  | Delete patient's appointment requests                        | 20-30/hour |
| STA3  | Check if a patient has done a session before                 | 10-15/hour |
| STA4  | Schedule a new appointment (examination session) for patient | 20-30/hour |
| STA5  | Schedule a new re-examination session for patient            | 5-8/hour   |
| STA6  | View dentist's schedule                                      | 30-40/hour |
| STA7  | View list of available dentist for an appointment            | 20-30/hour |
| STA8  | View list of dentists                                        | 20-30/hour |
| STA9  | View list of rooms                                           | 20-30/hour |
| STA10 | View list of patients                                        | 15-20/hour |
| STA11 | View a patient's medical details                             | 15-20/hour |
| STA12 | Create a new detailed medical record for a patient           | 8-12/day   |
| STA13 | Update a detailed medical record for a patient               | 8-12/day   |
| STA14 | Create a new payment record for a patient                    | 20-30/hour |
| STA15 | Update a payment record for a patient                        | 20-30/hour |
| STA16 | View a patient's treatment plan (list of sessions)           | 20-30/hour |
| STA17 | View a patient's payment records                             | 10-15/hour |
| STA18 | View a patient's prescription                                | 20-30/hour |
| STA19 | View list of sessions for a day                              | 20-30/hour |
| STA20 | Filter appointments by patient                               | 20-30/hour |
| STA21 | Filter appointments by room                                  | 20-30/hour |
| STA22 | Filter appointments by dentist                               | 20-30/hour |
| STA23 | View a patient's list of re-examination sessions             | 10-15/hour |
| STA24 | Create a new treatment session for a patient                 | 20-30/hour |

## Dentist

| Order | Functionality                           | Frequency |
| ----- | --------------------------------------- | --------- |
| DEN1  | View his/her schedule                   | 1-2/day   |
| DEN2  | View list of his/her sessions for a day | 8-12/day  |
| DEN3  | View a patient's medical details        | 8-12/day  |
| DEN4  | Update a patient's medical details      | 8-12/day  |
| DEN5  | View a patient's treatment plan         | 8-12/day  |
| DEN7  | View list of categories                 | 8-12/day  |
| DEN8  | View list of procedures of a category   | 8-12/day  |
| DEN9  | View a patient's payment records        | 8-12/day  |
| DEN10 | Create a prescription for a patient     | 8-12/day  |
| DEN11 | View a patient's prescription           | 8-12/day  |
| DEN12 | Update a patient's prescription         | 2-3/day   |
| DEN13 | Delete a patient's prescription         | 0-2/day   |
| DEN14 | View list of drugs                      | 12-15/day |

## Patient

| Order | Functionality                         | Frequency |
| ----- | ------------------------------------- | --------- |
| PAT1  | View list of categories               | 1-2/month |
| PAT2  | View list of procedures of a category | 1-2/month |
| PAT3  | Schedule a new appointment            | 1-2/month |

# Detailed Assessment

Since the system is a clinic management system, transactions related to appointments and sessions are the most frequent and important transactions. We estimated some frequency information of the database based on the information given in the requirements overview document, and have decided to use the following assumptions:

- The database will be used by a medium-to-large dental clinic, with around **80-100** patients per day.
- The clinic will be open from **8:00 to 12:00 and 13:00 to 17:00**, Monday to Saturday.
- On average, there will be around **70-80** appointment requests per day.
- The clinic will have around **15-20** dentists (including assistants), **8-12** staffs, and **12-15** rooms.
- An examination will take around **30** minutes, and a treatment will take around **1-2** hour(s).
- With the above assumptions, we estimated that there will be on average **8-9** patients per room per day.

## Data Volume Assessment

We have estimated that the following tables:

- Patient
- AppointmentRequest
- Session
- TreatmentSession
- ExaminationSession
- ReexaminationSession
- PaymentRecord

will hold the most data, which are also the most important tables of the system as they are related to the most frequent transactions of the database. In more details, we have estimated the following data volume for each of these tables:


| Table                | No of records (to date) | No of records/day | No of records/month |
| -------------------- | ----------------------- | ----------------- | ------------------- |
| Patient              | ~30000                  | 80-100            | 1600-2000           |
| AppointmentRequest   | ~100000                 | 25-30             | 500-600             |
| Session              | ~200000                 | 70-80             | 1400-1600           |
| TreatmentSession     | ~65000                  | 35-50             | 700-1000            |
| ExaminationSession   | ~60000                  | 25-35             | 600-800             |
| ReExaminationSession | ~50000                  | 20-25             | 200-300             |
| PaymentRecord        | ~100000                 | 35-50             | 700-1000            |

## Data Usage Assessment

Below are the "considered-essential" transactions of the database, which account for **80-90%** of the total transactions:

- PAT3 : Patients schedule a new appointment
- STA7 : Staff views list of available dentists for an appointment (examination session) of a patient
- STA4 : Staff schedules a new appointment (examination session) for patient
- STA24: Staff creates a new treatment session for a patient
- STA5 : Staff schedules a new re-examination session for patient
- STA3 : Staff checks if a patient has done a session before
- STA14: Staff creates a new payment record for a patient
- STA15: Staff updates a payment record for a patient
- STA24: Dentist creates a new treatment session for a patient


### Cross-Reference matrix

| Transaction/Table  | PAT3 |     |     |     | STA7 |     |     |     | STA4 |     |     |     |
| ------------------ | ---- | --- | --- | --- | ---- | --- | --- | --- | ---- | --- | --- | --- |
|                    | I    | U   | D   | R   | I    | U   | D   | R   | I    | U   | D   | R   |
| AppointmentRequest | x    |     |     |     |      |     |     | x   |      |     |     |     |
| Schedule           |      |     |     |     |      |     |     | x   |      |     |     |     |
| Personnel          |      |     |     |     |      |     |     | x   |      |     |     |     |
| Patient            |      |     |     |     |      |     |     |     | x    |     |     |     |
| Session            |      |     |     |     |      |     |     |     | x    |     |     |     |
| ExaminationSession |      |     |     |     |      |     |     |     | x    |     |     |     |

| Transaction/Table    | STA5 |     |     |     | STA3 |     |     |     | STA14 |     |     |     |
| -------------------- | ---- | --- | --- | --- | ---- | --- | --- | --- | ----- | --- | --- | --- |
|                      | I    | U   | D   | R   | I    | U   | D   | R   | I     | U   | D   | R   |
| Patient              |      |     |     | x   |      |     |     | x   |       |     |     | x   |
| Procedure            |      |     |     |     |      |     |     |     |       |     |     | x   |
| Session              | x    |     |     | x   |      |     |     | x   |       |     |     | x   |
| ReExaminationSession | x    |     |     |     |      |     |     |     |       |     |     |     |
| ExaminationSession   |      |     |     | x   |      |     |     |     |       |     |     |     |
| PaymentRecord        |      |     |     |     |      |     |     |     | x     |     |     |     |
| Procedure            |      |     |     |     |      |     |     |     |       |     |     | x   |

| Transaction/Table | STA24 |     |     |     | STA15 |     |     |     | 404 |     |     |     |
| ----------------- | ----- | --- | --- | --- | ----- | --- | --- | --- | --- | --- | --- | --- |
|                   | I     | U   | D   | R   | I     | U   | D   | R   | I   | U   | D   | R   |
| Session           | x     |     |     |     |       |     |     |     |     |     |     |     |
| TreatmentSession  | x     |     |     |     |       |     |     |     |     |     |     |     |
| PaymentRecord     |       |     |     |     |       | x   |     |     |     |     |     |     |

<!-- Conclusion here -->
Looking at the table we can see that:

- *Session* table spans accors 6 transactions, which is the most among all tables. This is because the *Session* table is the main table of the system, and is related to many other tables.
- *Patient* table spans across 4 transactions, which is the second most among all tables. This is because the *Patient* table is also the main table of the system, and is related to many other tables.
- *TreatmentSession*, *ExaminationSession*, *ReExaminationSession* are also important since they are inherited from the *Session* table, and join queries are to be expected when accessing these tables.
- *PaymentRecord* is also important since it is related to the most frequent transactions of the system.
- *AppointmentRequest* might not span across many transactions, but it is still important since it holds a large amount of data and is expected to be accessed frequently.

### Estimated number of references:

**Note**:

```md
- The tables and columns accessed by  the transaction and the type of access (read, write, update, delete).
- The columns used in any search conditions (WHERE clause).
- For a query, the columns that are involved in the join of 2 or more tables.
- The expected frequency at which the tranaction will run
- The performance goals for the transaction (response time, throughput, etc.)
```

#### PAT3

**Patients schedule a new appointment**

- Transaction volume:
  - Average: 7-8 per hour
  - Peak: 12-15 per hour (around 19:00 to 22:00), or 18-22 per hour (on weekends)
- Code:

```sql
-- code here
```

- Search condition: none
- Join columns: none
- Ordering column: none
- Grouping column: none
- Built-in functions: none
- Columns updated: none
- Expected response time: < 1s

| Trans | Relations          | Types of access | No of references |              |               |
| ----- | ------------------ | --------------- | ---------------- | ------------ | ------------- |
|       |                    |                 | Per transaction  | Avg per hour | Peak per hour |
| PAT3  | AppointmentRequest | I               | 1                | 7-8          | 12-15         |
| Total |                    |                 | 1                | 7-8          | 12-15         |

#### STA7

**Staff views list of available dentists for an appointment (examination session) of a patient**

- Transaction volume:
  - Average: 20-30 per hour
  - Peak: 40-50 per hour (on weekends, around 8:30 - 10:30 and 15:00 - 17:00)
- Code:

```sql
-- code here
```

- Search condition: `Schedule.[day] = toDay(AppointmentRequest.[appointmentTime])` (`toDay()` is a custom function that returns the day of the week of a given date)
- Check condition: none
- Join columns: `Personnel.[id] = Schedule.[dentistID]`
- Ordering column: none
- Grouping column: none
- Built-in functions: none
- Columns updated: none
- Expected response time: < 1s

| Trans | Relations          | Types of access | No of references |              |               |
| ----- | ------------------ | --------------- | ---------------- | ------------ | ------------- |
|       |                    |                 | Per transaction  | Avg per hour | Peak per hour |
| STA7  | AppointmentRequest | I               | 1                | 7-8          | 12-15         |
|       | Schedule           | R               | 7-10             | 140-300      | 280-600       |
|       | Personnel          | R               | 7-10             | 140-300      | 280-600       |
| Total |                    |                 | 15-21            | 287-608      | 572-1215      |

#### STA4

**Staff schedules a new appointment (examination session) for patient**

- Transaction volume:
  - Average: 20-30 per hour
  - Peak: 40-50 per hour (on weekends, around 8:30 - 10:30 and 15:00 - 17:00)
- Code:

```sql
-- code here
```

- Search condition: `Patient.[phone] = @patientPhone`
- Check condition: `EXIST(Patient.[id])`
- Join columns: none
- Ordering column: none
- Grouping column: none
- Built-in functions: none
- Columns updated: none
- Expected response time: < 1s

| Trans | Relations          | Types of access | No of references |              |               |
| ----- | ------------------ | --------------- | ---------------- | ------------ | ------------- |
|       |                    |                 | Per transaction  | Avg per hour | Peak per hour |
| STA4  | ExaminationSession | I               | 1                | 20-30        | 40-50         |
|       | Session            | I               | 1                | 20-30        | 40-50         |
|       | Patient            | I               | 1                | 20-30        | 40-50         |
| Total |                    |                 | 3                | 60-90        | 120-150       |

#### STA5

**Staff schedules a new re-examination session for patient**

- Transaction volume:
  - Average: 20-25 per hour
  - Peak: 35-40 per hour (on weekends, around 8:30 - 10:30 and 15:00 - 17:00)
- Code:

```sql
-- code here
```

- Search condition: `Patient.[id] = @patientId`
- Check condition: `Session.[type] = 'EXA'` (check existing examination session)
- Join columns: none
- Ordering column: none
- Grouping column: none
- Built-in functions: none
- Columns updated: none
- Expected response time: < 1s

| Trans | Relations            | Types of access | No of references |              |               |
| ----- | -------------------- | --------------- | ---------------- | ------------ | ------------- |
|       |                      |                 | Per transaction  | Avg per hour | Peak per hour |
| STA5  | ReExaminationSession | I               | 1                | 20-25        | 35-40         |
|       | Session              | I               | 1                | 20-25        | 35-40         |
|       | Patient              | R               | 1                | 20-25        | 35-40         |
|       | Session              | R               | 1                | 20-25        | 35-40         |
| Total |                      |                 | 4                | 80-100       | 140-160       |

#### STA3

**Staff checks if a patient has done a session before (view list of sessions of a given patient)**

- Transaction volume:
  - Average: 10-15/hour
  - Peak: 20-25/hour (on weekends, around 8:30 - 10:30 and 15:00 - 17:00)
- Code:

```sql
-- code here
```

- Search condition: `Patient.[phone] = @patientPhone`
- Check condition: `EXIST(Patient.[id])`
- Join columns: `Session.[patientID] = Patient.[id]`
- Ordering column: none
- Grouping column: none
- Built-in functions: none
- Columns updated: none
- Expected response time: < 1s

| Trans | Relations | Types of access | No of references |              |               |
| ----- | --------- | --------------- | ---------------- | ------------ | ------------- |
|       |           |                 | Per transaction  | Avg per hour | Peak per hour |
| STA3  | Session   | R               | 20-30            | 200-300      | 400-500       |
|       | Patient   | R               | 1                | 10-15        | 20-25         |
| Total |           |                 | 2                | 210-315      | 420-525       |

#### STA14

**Staff creates a new payment record for a patient**

- Transaction volume:
  - Average: 20-30/hour
  - Peak: 40-50/hour (on weekends, around 8:30 - 10:30 and 15:00 - 17:00)
- Code:

```sql
-- code here
```

- Search condition: `Procedure.[categoryId] = TreatmentSession.[categoryId]`
- Check condition: `EXIST(Patient.[id])`
- Join columns: 
- Ordering column: none
- Grouping column: none
- Built-in functions: none
- Columns updated: none
- Expected response time: < 1s

| Trans | Relations     | Types of access | No of references |              |               |
| ----- | ------------- | --------------- | ---------------- | ------------ | ------------- |
|       |               |                 | Per transaction  | Avg per hour | Peak per hour |
| STA14 | PaymentRecord | I               | 1                | 20-30        | 40-50         |

#### STA24

**Staff creates a new treatment session for a patient**

- Transaction volume:
  - Average: 20-30/hour
  - Peak: 40-50/hour (on weekends, around 8:30 - 10:30 and 15:00 - 17:00)
- Code:

```sql
-- code here
```

- Search condition: none
- Check condition: `EXIST(Patient.[id])`
- Join columns: none
- Ordering column: none
- Grouping column: none
- Built-in functions: none
- Columns updated: none
- Expected response time: < 1s

| Trans | Relations        | Types of access | No of references |              |               |
| ----- | ---------------- | --------------- | ---------------- | ------------ | ------------- |
|       |                  |                 | Per transaction  | Avg per hour | Peak per hour |
| STA24 | TreatmentSession | I               | 1                | 20-30        | 40-50         |
|       | Session          | I               | 1                | 20-30        | 40-50         |
| Total |                  |                 | 2                | 40-60        | 80-100        |

#### STA15

**Staff updates a payment record for a patient**

- Transaction volume:
  - Average: 20-30/hour
  - Peak: 40-50/hour (on weekends, around 8:30 - 10:30 and 15:00 - 17:00)
- Code:

```sql
-- code here
```

- Search condition: none
- Check condition: `EXIST(Patient.[id])`
- Join columns: none
- Ordering column: none
- Grouping column: none
- Built-in functions: none
- Columns updated: `PaymentRecord.[paid], PaymentRecord.[change] (if any), PaymentRecord.[method]`
- Expected response time: < 1s

| Trans | Relations     | Types of access | No of references |              |               |
| ----- | ------------- | --------------- | ---------------- | ------------ | ------------- |
|       |               |                 | Per transaction  | Avg per hour | Peak per hour |
| STA15 | PaymentRecord | U               | 1                | 20-30        | 40-50         |
| Total |               |                 | 1                | 20-30        | 40-50         |

