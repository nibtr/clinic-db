---
title: DA#3 - Transactions
date-of-creation: 2023-08-02
date-last-updated: 2023-08-03
description: Transactions Analysis
---

# List of Transactions

## Admin, Dentist, Staff

| Order | Functionality |
| ----- | ------------- |
| ALL1  | Login         |

## Admin

| Order | Functionality                 |
| ----- | ----------------------------- |
| ADM1  | Add staff details             |
| ADM2  | Update staff details          |
| ADM3  | Delete staff details          |
| ADM4  | View staff details            |
| ADM5  | Add dentist details           |
| ADM6  | Update dentist details        |
| ADM7  | Delete dentist details        |
| ADM8  | View dentist details          |
| ADM9  | Add room details              |
| ADM10 | Update room details           |
| ADM11 | Delete room details           |
| ADM12 | View room details             |
| ADM13 | Add drug details              |
| ADM14 | Update drug details           |
| ADM15 | Delete drug details           |
| ADM16 | View drug details             |
| ADM17 | Add procedure details         |
| ADM18 | Update procedure details      |
| ADM19 | Delete procedure details      |
| ADM20 | View procedure details        |
| ADM21 | Add category details          |
| ADM22 | Update category details       |
| ADM23 | Delete category details       |
| ADM24 | View category details         |
| ADM25 | Add schedule for a dentist    |
| ADM26 | Update schedule for a dentist |
| ADM27 | Delete schedule for a dentist |
| ADM28 | View schedule for a dentist   |
| ADM29 | Update account details        |
| ADM30 | View account details          |

## Staff

| Order | Functionality                                                |
| ----- | ------------------------------------------------------------ |
| STA1  | View patient's appointment requests                          |
| STA2  | Delete patient's appointment requests                        |
| STA3  | Check if a patient has done a session before                 |
| STA4  | Schedule a new appointment (examination session) for patient |
| STA5  | Schedule a new re-examination session for patient            |
| STA6  | View dentist's schedule                                      |
| STA7  | View list of available dentist for an appointment            |
| STA8  | View list of dentists                                        |
| STA9  | View list of rooms                                           |
| STA10 | View list of patients                                        |
| STA11 | View a patient's medical details                             |
| STA12 | Create a new detailed medical record for a patient           |
| STA13 | Update a detailed medical record for a patient               |
| STA14 | Create a new payment record for a patient                    |
| STA15 | Update a payment record for a patient                        |
| STA16 | View a patient's treatment plan (list of sessions)           |
| STA17 | View a patient's payment records                             |
| STA18 | View a patient's prescription                                |
| STA19 | View list of sessions for a day                              |
| STA20 | Filter appointments by patient                               |
| STA21 | Filter appointments by room                                  |
| STA22 | Filter appointments by dentist                               |
| STA23 | View a patient's list of re-examination sessions             |
| STA24 | Create a new treatment session for a patient                 |

## Dentist

| Order | Functionality                           |
| ----- | --------------------------------------- |
| DEN1  | View his/her schedule                   |
| DEN2  | View list of his/her sessions for a day |
| DEN3  | View a patient's medical details        |
| DEN4  | Update a patient's medical details      |
| DEN5  | View a patient's treatment plan         |
| DEN7  | View list of categories                 |
| DEN8  | View list of procedures of a category   |
| DEN9  | View a patient's payment records        |
| DEN10 | Create a prescription for a patient     |
| DEN11 | View a patient's prescription           |
| DEN12 | Update a patient's prescription         |
| DEN13 | Delete a patient's prescription         |
| DEN14 | View list of drugs                      |

## Patient

| Order | Functionality                         |
| ----- | ------------------------------------- |
| PAT1  | View list of categories               |
| PAT2  | View list of procedures of a category |
| PAT3  | Schedule a new appointment            |

# Transactions Frequency Assessment

Since the system is a clinic management system, transactions related to appointments and sessions are the most frequent and important transactions.

Below are the "considered-essential" transactions of the database.

- PAT3 :  Patients schedule a new appointment
- STA6 :  Staff views list of available dentists for an appointment (examination session) of a patient
- STA4 :  Staff schedules a new appointment (examination session) for patient
- STA24:  Staff creates a new treatment session for a patient
- STA5 :  Staff schedules a new re-examination session for patient
- STA3 :  Staff checks if a patient has done a session before
- STA14:  Staff creates a new payment record for a patient
- STA15:  Staff updates a payment record for a patient

# Cross-Reference Matrix

| Transaction/Table  | PAT3 |     |     |     | STA6 |     |     |     | STA4 |     |     |     |
| ------------------ | ---- | --- | --- | --- | ---- | --- | --- | --- | ---- | --- | --- | --- |
|                    |  I   |  U  |  D  |  R  |   I  |  U  |  D  |  R  |   I  |  U  |  D  |  R  |
| AppointmentRequest |  x   |     |     |     |      |     |     |  x  |      |     |     |     |
| Schedule           |      |     |     |     |      |     |     |  x  |      |     |     |     |
| Patient            |      |     |     |     |      |     |     |     |   x  |     |     |     |
| Session            |      |     |     |     |      |     |     |     |   x  |     |     |     |
| ExaminationSession |      |     |     |     |      |     |     |     |   x  |     |     |     |
| Room               |      |     |     |     |      |     |     |     |      |     |     |  x  |


| Transaction/Table    | STA5 |     |     |     | STA3 |     |     |     | STA14 |     |     |     |
| -------------------- | ---- | --- | --- | --- | ---- | --- | --- | --- | ----- | --- | --- | --- |
|                      | I    |  U  |  D  |  R  |  I   |  U  |  D  |  R  |   I   |  U  |  D  |  R  |
| Session              | x    |     |     |     |      |     |     |  x  |       |     |     |     |
| ReExaminationSession | x    |     |     |     |      |     |     |     |       |     |     |     |
| ExaminationSession   |      |     |     |     |      |     |     |     |       |     |     |     |
| PaymentRecord        |      |     |     |     |      |     |     |     |   x   |     |     |     |
| Room                 |      |     |     |  x  |      |     |     |     |       |     |     |     |


| Transaction/Table    | STA24 |     |     |     | STA15 |     |     |     |  404  |     |     |     |
| -------------------- | ----- | --- | --- | --- | ----- | --- | --- | --- | ----- | --- | --- | --- |
|                      |  I    |  U  |  D  |  R  |   I   |  U  |  D  |  R  |   I   |  U  |  D  |  R  |
| Session              |  x    |     |     |     |       |     |     |     |       |     |     |     |
| ReExaminationSession |       |     |     |     |       |     |     |     |       |     |     |     |
| ExaminationSession   |       |     |     |     |       |     |     |     |       |     |     |     |
| TreatmentSession     |  x    |     |     |     |       |     |     |     |       |     |     |     |
| PaymentRecord        |       |     |     |     |       |  x  |     |     |       |     |     |     |
| Room                 |       |     |     |  x  |       |     |     |     |       |     |     |     |


# Frequency Information

We estimated some frequency information of the database based on the information given in the requirements overview document, and have decided to use the following assumptions:

- The database will be used by a medium-to-large dental clinic, with around **80-100** patients per day.
- The clinic will be open from **8:00 to 12:00 and 13:00 to 17:00**, Monday to Saturday.
- On average, there will be around **20-25** appointment requests per day.
- The clinic will have around **15-20** dentists (including assistants), **8-12** staffs, and **12-15** rooms.
- An examination will take around **30** minutes, and a treatment will take around **1-2** hour(s).
- With the above assumptions, we estimated that there will be on average **8-9** patients per room per day.
