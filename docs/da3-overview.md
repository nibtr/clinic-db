---
title: DA#3 - Overview
date-of-creation: 2023-07-03
date-last-updated: 2023-07-09
description: Overview of business objectives and business requirements of the project
---

# DA#3 - Overview

## 1. Business Objectives

- Manage patient records
- Manage appointments
- Manage staffs
- Statistics
- Support patients to make appointments with the clinic
- Can exchange information through the messaging function in the application
- View your own medical records
- Support answering questions from customers about clinic information
- Promote, introduce the clinic

## 2. Users

### 2.1. Admin

- User with the highest authority of the application
- Able to use all the functionalities that the application provides

Some notable functionalities: Manage (change) personnel, schedule, procedures, administrative information, ...
This type of account is usually granted to the owner of the clinic, or senior management

### 2.2. Staff

User that can use most of the functionalities that the application provides, except for management-related functionalities

Some notable functionalities:

- Arrange appointments between patients and dentists
- Track appointment requests from patients

This type of account is usually granted to the receptionist of the clinic.

### 2.3. Dentist

- User with the lowest authority of the application

Some notable functionalities: Edit medical records, dental chart, dental status, patient's treatment records
This type of account is usually granted to the dentist of the clinic.

## 3. Business Requirements

### For all users

- Login/logout

### 3.1. Manage patient records

- Allowed users: Admin, Staff, Dentist
- View list of patients
- Add/update patient

#### Detailed patient information

- Basic information such as: name, age, gender, etc.
- Total treatment amount paid
- Overall information about the patient's oral health
- Note about allergies
- Note about **drug contraindications** of the patient
- Dentists can view a list of patient's payments including:
  - Name of the dentist in charge of the treatments
  - Total amount to be paid and date of payment
  - Detailed information of each payment including:
    - Transaction date
    - Payer
    - Total amount to be paid
    - Amount paid
    - Change
    - Payment type (cash or online)

#### Detailed information about patient's treatment plan

After the patient's first visit, the dentist will create a treatment plan for the patient. The treatment plan is a list of the patient's treatment sessions. Each treatment session (each instance in the treatment plan) will have the following information:

- Treatment date
- Dentist in charge
- Note for the treatment session
- Assistant (if any)
- Description (there will be available options to choose from (dropdown))
- Treatment category
- [Procedures](#procedure) (these are treatment items)
- Status:
  - Plan (blue)
  - Finished (green)
  - Cancelled (yellow)
- List of [teeth](#teeth) to be treated
- Payment information for the treatment session
- Prescription information for the treatment session

After selecting enough information, click complete. The dentist can update this treatment information. In addition, the dentist can update the patient's oral health status information:

- Add/delete/update patient's drug contraindications
- Update patient's oral health status
- View/add/update patient's treatment plans

#### Teeth

Each tooth has the following surfaces:

- Lingual (L)
- Facial (F)
- Distal (D)
- Mesial (M)
- Top (T)
- Root (R)

#### Procedure

Each procedure includes:

- Procedure code
- Description
- Fee

### 3.2. Manage appointments

- View appointments in each day (allowed users: admin, staff, dentist)
- Includes information:
  - Appointment time
  - Patient name
  - Dentist in charge
  - Assistant (if any)
  - Room
  - Status (new appointment/re-examination)
- Staff can add/update/delete appointments
- Dentist can only view appointment information (read-only)
- Filter appointments in a day (allowed users: admin, staff, dentist)
  - **Filter by patient (name)**
  - **Filter appointments of a specific dentist**: Dentist can choose to filter appointments that he/she is responsible for
- Add/view/delete/update appointment requests from patients (allowed users: admin, staff)
  - Display: Patient name, requested appointment date, note and time the request was sent
  - Add new: **need to create patient profile**: ID, name, phone number, email, address, date of birth,...
  - Update on existing patient:
    - Can choose the default dentist if the dentist is available at that time, otherwise choose another dentist
    - The system supports automatically finding the nearest working day of the patient's default dentist
- **Each dentist has their own working schedule** => Only display dentists who have working schedule at the time the patient wants to make an appointment
- When changing the appointment date, the selected dentist list will also be updated
- Can view a list of patient's linked re-examination appointments, (linked re-examination appointment is a re-examination appointment that is linked to a previous appointment, the list of linked re-examination appointments can be when clicking on a specific appointment will show the re-examination appointments linked to that appointment -> create a linked re-examination table)
- Information for each re-examination appointment includes (display information):
  - Appointment date
  - Code
  - Note
- If the patient comes for re-examination, the linked re-examination appointment needs to be confirmed (the patient only needs to confirm with the staff).

### 3.3 Manage system data

- View list of dentists (allowed users: admin, staff, dentist)
- Add/update dentist information (allowed users: admin)
- View list of staffs (allowed users: admin, staff, dentist)
- Add/update staff information (allowed users: admin)
- View list of dentists and corresponding working schedules (allowed users: admin, staff, dentist):
  - Working schedule by each individual day, week, month
  - Monthly schedule shows the days in the month that can the dentist can work
  - Weekly schedule unit is each day of the week
  - Daily schedule unit is specific days
  - Each day has a time that can be treated, a time that cannot be treated
  - Receptionist, staff (Staff) based on this schedule to make appointments for patients
- Only admin can add working schedule for dentists
- Manage drugs:
  - View list of drugs (allowed users: admin, staff, dentist)
  - Add/update/delete drugs (allowed users: admin)
- Statistics:
  - Report on treatments from date to date, by each dentist
  - Report on appointments from date to date, by each dentist
