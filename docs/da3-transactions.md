---
title: DA#3 - Transactions
date-of-creation: 2023-08-02
date-last-updated: 2023-08-02
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

## Dentist

| Order        | Functionality                                    |
| ------------ | ------------------------------------------------ |
| DEN1         | View his/her schedule                            |
| DEN2         | View list of his/her sessions for a day          |
| DEN3         | View a patient's medical details                 |
| DEN4         | Update a patient's medical details               |
| DEN5         | View a patient's treatment plan                  |
| **DEN6[^1]** | **Create a new treatment session for a patient** |
| DEN7         | View list of categories                          |
| DEN7         | View list of procedures of a category            |
| DEN8         | View a patient's payment records                 |
| DEN9         | Create a prescription for a patient              |
| DEN10        | View a patient's prescription                    |
| DEN11        | Update a patient's prescription                  |
| DEN12        | Delete a patient's prescription                  |
| DEN13        | View list of drugs                               |

## Patient

| Order | Functionality                         |
| ----- | ------------------------------------- |
| PAT1  | View list of categories               |
| PAT2  | View list of procedures of a category |
| PAT3  | Schedule a new appointment            |

# Transactions Frequency Assessment

Since the system is a clinic management system, transactions related to appointments and sessions are the most frequent and important transactions.

Below are the "considered-essential" transactions of the database.

- PAT3: Patients schedule a new appointment
- STA6: Staff views list of available dentists for an appointment (examination session) of a patient
- STA4: Staff schedules a new appointment (examination session) for patient
- **DEN6: Dentist creates a new treatment session for a patient** [^1]
- STA5: Staff schedules a new re-examination session for patient
- 

[^1]: **TODO:** Decide if this adding a new session is a functionality of the dentist or the staff
