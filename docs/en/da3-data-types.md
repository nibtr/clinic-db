---
title: DA#3 - Overview
date-of-creation: 2023-07-22
date-last-updated: 2023-07-26
description: Data types and constraints for the tables
---

# Data types & Constraints

## Account Table

| Field Name   | Data Type     | Constraints             |
| ------------ | ------------- | ----------------------- |
| `id`         | `int`         | `PRIMARY KEY`           |
| `username`   | `char(10)`    | `UNIQUE`                |
| `password`   | `char(60)`    | `NOT NULL`              |
| `email`      | `varchar(50)` | `UNIQUE`                |
| `role`       | `char(3)`     | `NOT NULL`              |
| `personelID` | `int`         | `FOREIGN KEY, NOT NULL` |

For the *password*, we decided to use the following convention:

- The password is a 10-character string.
- The password is prefixed with a 3-letter code that indicates the type of the account (sta, den, adm).
- Followed by a `-` character.
- Followed by a 6-digit number that is generated randomly.
- The password is hashed using the `bcrypt` algorithm with 12 rounds.

For example: `sta-123456` will result in a hashed version `$2a$12$gEy/fBApnlR7CYu5hWQvWOQh9pt.vGPGCH3TTIdYLc4xqDODqVvwm` which is *60 characters long*.

Role is a 3-character string that indicates the role of the account (sta, den, adm).

## Personel Table

| Field Name   | Data Type      | Constraints   |
| ------------ | -------------- | ------------- |
| `id`         | `int`          | `PRIMARY KEY` |
| `nationalID` | `char(12)`     | `UNIQUE`      |
| `name`       | `nvarchar(50)` | `NOT NULL`    |
| `dob`        | `date`         | `X`           |
| `gender`     | `char(1)`      | `X`           |
| `phone`      | `char(10)`     | `UNIQUE`      |

We don't save `age` because it can be calculated from `dob`, and it's not a good idea either since we have to update it every year.

## Staff Table

| Field Name | Data Type | Constraints                |
| ---------- | --------- | -------------------------- |
| `id`       | `int`     | `PRIMARY KEY, FOREIGN KEY` |

## Dentist Table

| Field Name | Data Type | Constraints                |
| ---------- | --------- | -------------------------- |
| `id`       | `int`     | `PRIMARY KEY, FOREIGN KEY` |

## Assistant Table

| Field Name | Data Type | Constraints                |
| ---------- | --------- | -------------------------- |
| `id`       | `int`     | `PRIMARY KEY, FOREIGN KEY` |

## Patient Table

| Field Name             | Data Type       | Constraints                |
| ---------------------- | --------------- | -------------------------- |
| `id`                   | `int`           | `PRIMARY KEY, FOREIGN KEY` |
| `drugContraindication` | `nvarchar(500)` | `X`                        |
| `oralHealthStatus`     | `nvarchar(500)` | `X`                        |
| `allergyStatus`        | `nvarchar(255)` | `X`                        |

## Payment Record Table

| Field Name           | Data Type | Constraints             |
| -------------------- | --------- | ----------------------- |
| `id`                 | `int`     | `PRIMARY KEY`           |
| `date`               | `date`    | `NOT NULL`              |
| `total`              | `int`     | `NOT NULL`              |
| `paid`               | `int`     | `DEFAULT = 0`           |
| `change`             | `int`     | `DEFAULT = 0`           |
| `method`             | `char(1)` | `X`                     |
| `patientID`          | `int`     | `FOREIGN KEY, NOT NULL` |
| `treatmentSessionID` | `int`     | `FOREIGN KEY, NOT NULL` |

For the method, there are 2 options: cash or online, denoted by `c` and `o` respectively.

## Session Table

| Field Name    | Data Type        | Constraints                                     |
| ------------- | ---------------- | ----------------------------------------------- |
| `id`          | `int`            | `PRIMARY KEY`                                   |
| `time`        | `datetime2`      | `NOT NULL`                                      |
| `note`        | `nvarchar(1000)` | `X`                                             |
| `status`      | `varchar(6)`     | `DEFAULT = do` <!-- do, doing, done, cancel --> |
| `patientID`   | `int`            | `FOREIGN KEY, NOT NULL`                         |
| `assistantID` | `int`            | `FOREIGN KEY`                                   |
| `dentistID`   | `int`            | `FOREIGN KEY, NOT NULL`                         |
| `roomID`      | `int`            | `FOREIGN KEY, NOT NULL`                         |

## Treatment Session Table

| Field Name    | Data Type         | Constraints                |
| ------------- | ----------------- | -------------------------- |
| `id`          | `int`             | `PRIMARY KEY, FOREIGN KEY` |
| `health_note` | `nvarchar(1000)`* | `X`                        |
| `description` | `nvarchar(1000)`* | `X`                        |
| `categoryID`  | `int`             | `FOREIGN KEY, NOT NULL`    |

## Examination Session Table

| Field Name | Data Type | Constraints                |
| ---------- | --------- | -------------------------- |
| `id`       | `int`     | `PRIMARY KEY, FOREIGN KEY` |

## Re-Examination Session Table

| Field Name             | Data Type | Constraints                |
| ---------------------- | --------- | -------------------------- |
| `id`                   | `int`     | `PRIMARY KEY, FOREIGN KEY` |
| `relatedExaminationID` | `int`     | `FOREIGN KEY, NOT NULL`    |

## Room Table

| Field Name | Data Type     | Constraints   |
| ---------- | ------------- | ------------- |
| `id`       | `int`         | `PRIMARY KEY` |
| `code`     | `char(6)`     | `UNIQUE`      |
| `name`     | `varchar(50)` | `NOT NULL`    |

The room code is a 6-character string that is generated following the convention:

- The first 3 characters are the room type code (examination room, operating room, etc.).
- Followed by a `-` character.
- Next is a 2-digit number that is the room number.

For example: `EXA-01` is the code for the first examination room.

## Procedure Table

| Field Name    | Data Type       | Constraints             |
| ------------- | --------------- | ----------------------- |
| `id`          | `int`           | `PRIMARY KEY`           |
| `code`        | `char(3)`       | `UNIQUE`                |
| `name`        | `nvarchar(50)`  | `NOT NULL`              |
| `description` | `nvarchar(500)` | `X`                     |
| `fee`         | `int`           | `NOT NULL`              |
| `categoryID`  | `int`           | `FOREIGN KEY, NOT NULL` |

## Category Table

| Field Name    | Data Type       | Constraints   |
| ------------- | --------------- | ------------- |
| `id`          | `int`           | `PRIMARY KEY` |
| `code`        | `char(3)`       | `UNIQUE`      |
| `name`        | `nvarchar(50)`  | `NOT NULL`    |
| `description` | `nvarchar(255)` | `X`           |

The code is a 3-character string that is generated based on the name of the category.

## Drug Table

| Field Name    | Data Type       | Constraints   |
| ------------- | --------------- | ------------- |
| `id`          | `int`           | `PRIMARY KEY` |
| `code`        | `char(17)`      | `UNIQUE`      |
| `name`        | `varchar(50)`   | `NOT NULL`    |
| `description` | `nvarchar(255)` | `X`           |
| `price`       | `int`           | `NOT NULL`    |

Code is a 17-character string that is generated following the convention:

- The first 3 characters are the national drug code (NDC)
- Followed by a `-` character.
- Next 6-digit number is the Labeler Code
- Followed by a `-` character.
- Next 4-digit number is the Product Code
- Followed by a `-` character.
- Next 2-digit number is the Package Code

For example: `NDC-45678-9012-34` is a valid code.

## Tooth Table

| Field Name | Data Type     | Constraints   |
| ---------- | ------------- | ------------- |
| `id`       | `int`         | `PRIMARY KEY` |
| `type`     | `char(1)`     | `UNIQUE`      |
| `name`     | `varchar(50)` | `NOT NULL`    |

The type is a single character that indicates the type of the tooth.
- Lingual (L)
- Facial (F)
- Distal (D)
- Mesial (M)
- Top (T)
- Root (R)

## Prescription Table

| Field Name           | Data Type        | Constraints             |
| -------------------- | ---------------- | ----------------------- |
| `drugID`             | `int`            | `FOREIGN KEY, NOT NULL` |
| `treatmentSessionID` | `int`            | `FOREIGN KEY, NOT NULL` |
| `note`               | `nvarchar(500)`* | `X`                     |

## Appointment Request Table

| Field Name        | Data Type       | Constraints   |
| ----------------- | --------------- | ------------- |
| `id`              | `int`           | `PRIMARY KEY` |
| `appointmentTime` | `datetime2`     | `NOT NULL`    |
| `requestTime`     | `datetime2`     | `NOT NULL`    |
| `note`            | `nvarchar(255)` | `X`           |
| `patientName`     | `nvarchar(50)`  | `NOT NULL`    |
| `patientPhone`    | `char(10)`      | `NOT NULL`    |

## Day

| Field Name | Data Type | Constraints   |
| ---------- | --------- | ------------- |
| `id`       | `int`     | `PRIMARY KEY` |
| `day`      | `char(3)` | `UNIQUE`      |

The day is a 3-character string that indicates the day of the week (Mon, Tue, Wed, Thu, Fri, Sat, Sun).

## Schedule Table

| Field Name  | Data Type | Constraints             |
| ----------- | --------- | ----------------------- |
| `dayID`     | `int`     | `FOREIGN KEY, NOT NULL` |
| `dentistID` | `int`     | `FOREIGN KEY, NOT NULL` |
