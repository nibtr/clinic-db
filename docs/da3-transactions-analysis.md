---
title: DA#3 - Transactions Analysis
date-of-creation: 2023-07-29
date-last-updated: 2023-07-29
description: Transactions Analysis of the database
---

# List of transactions

Below are the "considered-essential" transactions of the database.

1. Patient Schedule a new appointment
2. Check dentist's schedule availability to schedule a new appointment
3. Staff schedule a new appointment for a patient
4. Add new examination sessions for a patient
5. Add new treatment sessions for a patient
6. Add new re-examination sessions for a patient
7. Create new payment record for a patient

## Cross-reference matrix of transactions and data entities

| Transaction/Table  | (1) |     |     |     | (2) |     |     |     | (3) |     |     |     |
| ------------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|                    | I   | R   | U   | D   | I   | R   | U   | D   | I   | R   | U   | D   |
| AppointmentRequest | x   |     |     |     |     | x   |     |     |     | x   |     |     |
| Dentist            |     |     |     |     |     | x   |     |     |     | x   |     |     |
| Schedule           |     |     |     |     |     | x   |     |     |     |     |     |     |
| Personnel          |     |     |     |     |     |     |     |     | x   |     |     |     |
| Patient            |     |     |     |     |     |     |     |     | x   |     |     |     |
| Session            |     |     |     |     |     |     |     |     | x   |     |     |     |
| ExaminationSession |     |     |     |     |     |     |     |     | x   |     |     |     |
| Room               |     |     |     |     |     |     |     |     |     | x   |     |     |