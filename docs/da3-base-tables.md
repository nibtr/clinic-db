---
title: DA#3 - Base Tables
date-of-creation: 2023-07-22
date-last-updated: 2023-07-29
description: Base tables for the database
---

# Base tables with data types and basic constraints

## Account Table

| Field Name    | Data Type     | Constraints             | Domain     | Default |
| ------------- | ------------- | ----------------------- | ---------- | ------- |
| `id`          | `int`         | `PRIMARY KEY`           | n > 0      | x       |
| `username`    | `char(10)`    | `UNIQUE`                | 0 < n < 11 | x       |
| `password`    | `char(60)`    | `NOT NULL`              | 0 < n < 61 | x       |
| `email`       | `varchar(50)` | `UNIQUE`                | 0 < n < 51 | x       |
| `personnelID` | `int`         | `FOREIGN KEY, NOT NULL` | n > 0      | x       |

For the *password*, we decided to use the following convention:

- The password is a 10-character string.
- The password is prefixed with a 3-letter code that indicates the type of the account (sta, den, adm).
- Followed by a `-` character.
- Followed by a 6-digit number that is generated randomly.
- The password is hashed using the `bcrypt` algorithm with 12 rounds.

For example: `sta-123456` will result in a hashed version `$2a$12$gEy/fBApnlR7CYu5hWQvWOQh9pt.vGPGCH3TTIdYLc4xqDODqVvwm` which is *60 characters long*.

## Personnel Table

| Field Name   | Data Type      | Constraints       | Domain     | Default |
| ------------ | -------------- | ----------------- | ---------- | ------- |
| `id`         | `int`          | `PRIMARY KEY`     | n > 0      | x       |
| `nationalID` | `char(12)`     | `UNIQUE`          | 0 < n < 13 | x       |
| `name`       | `nvarchar(50)` | `NOT NULL`        | 0 < n < 51 | x       |
| `dob`        | `date`         | `X`               | x          | x       |
| `gender`     | `char(1)`      | `X`               | x          | x       |
| `phone`      | `char(10)`     | `UNIQUE NOT NULL` | 0 < n < 11 | x       |
| `age`        | `int`          | `derived`         | n > 0      | x       |
| `type`       | `char(3)`      | `NOT NULL`        | x          | x       |

- `type` is a 3-character string that indicates the type of personnel:
  - `ADM`: Administrator
  - `DEN`: Dentist
  - `STA`: Staff
  - `AST`: Assistant
- `gender` is:
  - `M` for Male
  - `F` for Female
- `dob` format: `YYYY-MM-DD`
- We don't save `age` because it can be calculated from `dob`, and it's not a good idea either since we have to update it every year.
- Caculate `age` from `dob` using the following formula:

```sql
SELECT DATEDIFF(YEAR, dob, GETDATE()) - CASE WHEN (MONTH(dob) > MONTH(GETDATE())) OR (MONTH(dob) = MONTH(GETDATE()) AND DAY(dob) > DAY(GETDATE())) THEN 1 ELSE 0 END
```

## Patient Table

| Field Name             | Data Type       | Constraints       | Domain      | Default |
| ---------------------- | --------------- | ----------------- | ----------- | ------- |
| `id`                   | `int`           | `PRIMARY KEY`     | n > 0       | x       |
| `drugContraindication` | `nvarchar(500)` | `X`               | 0 < n < 501 | x       |
| `allergyStatus`        | `nvarchar(255)` | `X`               | 0 < n < 256 | x       |
| `nationalID`           | `char(12)`      | `UNIQUE`          | 0 < n < 13  | x       |
| `name`                 | `nvarchar(50)`  | `NOT NULL`        | 0 < n < 51  | x       |
| `dob`                  | `date`          | `X`               | x           | x       |
| `gender`               | `char(1)`       | `X`               | x           | x       |
| `phone`                | `char(10)`      | `UNIQUE NOT NULL` | 0 < n < 11  | x       |
| `age`                  | `int`           | `derived`         | n > 0       | x       |

- We don't save `age` because it can be calculated from `dob`, and it's not a good idea either since we have to update it every year.
- Caculate `age` from `dob` using the following formula:

```sql
SELECT DATEDIFF(YEAR, dob, GETDATE()) - CASE WHEN (MONTH(dob) > MONTH(GETDATE())) OR (MONTH(dob) = MONTH(GETDATE()) AND DAY(dob) > DAY(GETDATE())) THEN 1 ELSE 0 END
```

## Payment Record Table

| Field Name  | Data Type | Constraints             | Domain | Default |
| ----------- | --------- | ----------------------- | ------ | ------- |
| `id`        | `int`     | `PRIMARY KEY`           | n > 0  | x       |
| `date`      | `date`    | `NOT NULL`              | x      | x       |
| `total`     | `int`     | `NOT NULL`              | n > 0  | x       |
| `paid`      | `int`     | `NOT NULL`              | n >= 0 | 0       |
| `change`    | `int`     | `NOT NULL`              | n >= 0 | 0       |
| `method`    | `char(1)` | `X`                     | x      | x       |
| `patientID` | `int`     | `FOREIGN KEY, NOT NULL` | n > 0  | x       |

For the method, there are 2 options: 
- Cash: denoted by `C`
- Online: denoted by `O`

## Session Table

| Field Name    | Data Type        | Constraints             | Domain       | Default |
| ------------- | ---------------- | ----------------------- | ------------ | ------- |
| `id`          | `int`            | `PRIMARY KEY`           | n > 0        | x       |
| `time`        | `datetime2`      | `NOT NULL`              | x            | x       |
| `note`        | `nvarchar(1000)` | `X`                     | 0 < n < 1001 | x       |
| `status`      | `char(3)`        | `NOT NULL`              | x            | `SCH`   |
| `type`        | `char(3)`        | `NOT NULL`              | x            | `EXA `  |
| `patientID`   | `int`            | `FOREIGN KEY, NOT NULL` | n > 0        | x       |
| `roomID`      | `int`            | `FOREIGN KEY, NOT NULL` | n > 0        | x       |
| `dentistID`   | `int`            | `FOREIGN KEY, NOT NULL` | n > 0        | x       |
| `assistantID` | `int`            | `FOREIGN KEY`           | n > 0        | x       |

- `status` is a 3-character string that indicates the status of the session:
  - `SCH`: Scheduled
  - `CAN`: Cancelled
  - `RES`: Rescheduled
  - `COM`: Completed
  - `EXE`: Executing

- `type` is a 3-character string that indicates the type of the session:
  - `TRE`: Treatment
  - `EXA`: Examination
  - `REX`: Re-examination

## Treatment Session Table

| Field Name        | Data Type         | Constraints                | Domain       | Default |
| ----------------- | ----------------- | -------------------------- | ------------ | ------- |
| `id`              | `int`             | `PRIMARY KEY, FOREIGN KEY` | n > 0        | x       |
| `health_note`     | `nvarchar(1000)`* | `X`                        | 0 < n < 1001 | x       |
| `description`     | `nvarchar(1000)`* | `X`                        | 0 < n < 1001 | x       |
| `categoryID`      | `int`             | `FOREIGN KEY, NOT NULL`    | n > 0        | x       |
| `paymentRecordID` | `int`             | `FOREIGN KEY`              | n > 0        | x       |

## Examination Session Table

| Field Name | Data Type | Constraints                | Domain | Default |
| ---------- | --------- | -------------------------- | ------ | ------- |
| `id`       | `int`     | `PRIMARY KEY, FOREIGN KEY` | n > 0  | x       |

## Re-Examination Session Table

| Field Name             | Data Type | Constraints                | Domain | Default |
| ---------------------- | --------- | -------------------------- | ------ | ------- |
| `id`                   | `int`     | `PRIMARY KEY, FOREIGN KEY` | n > 0  | x       |
| `relatedExaminationID` | `int`     | `FOREIGN KEY, NOT NULL`    | n > 0  | x       |

## Room Table

| Field Name | Data Type     | Constraints   | Domain     | Default |
| ---------- | ------------- | ------------- | ---------- | ------- |
| `id`       | `int`         | `PRIMARY KEY` | n > 0      | x       |
| `code`     | `char(6)`     | `UNIQUE`      | 0 < n < 7  | x       |
| `name`     | `varchar(50)` | `NOT NULL`    | 0 < n < 51 | x       |

- The room code is a 6-character string that is generated following the convention:
  - The first 3 characters are the room type code (examination room, operating room, etc.).
  - Followed by a `-` character.
  - Next is a 2-digit number that is the room number.
  - For example: `EXA-01` is the code for the first examination room.

## Procedure Table

| Field Name    | Data Type       | Constraints             | Domain      | Default |
| ------------- | --------------- | ----------------------- | ----------- | ------- |
| `id`          | `int`           | `PRIMARY KEY`           | n > 0       | x       |
| `code`        | `char(3)`       | `UNIQUE`                | 0 < n < 4   | x       |
| `name`        | `nvarchar(50)`  | `NOT NULL`              | 0 < n < 51  | x       |
| `description` | `nvarchar(500)` | `X`                     | 0 < n < 501 | x       |
| `fee`         | `int`           | `NOT NULL`              | n > 0       | x       |
| `categoryID`  | `int`           | `FOREIGN KEY, NOT NULL` | n > 0       | x       |

- `code` is a 3-character string that is generated based on the name of the procedure. For example: `TA2` is the code for `Tooth Extraction`.

## Category Table

| Field Name    | Data Type       | Constraints   | Domain      | Default |
| ------------- | --------------- | ------------- | ----------- | ------- |
| `id`          | `int`           | `PRIMARY KEY` | n > 0       | x       |
| `code`        | `char(3)`       | `UNIQUE`      | 0 < n < 4   | x       |
| `name`        | `nvarchar(50)`  | `NOT NULL`    | 0 < n < 51  | x       |
| `description` | `nvarchar(255)` | `X`           | 0 < n < 256 | x       |

- `code` is a 3-character string that is generated based on the name of the category. For example: `GEN` is the code for `General`.

## Drug Table

| Field Name    | Data Type       | Constraints   | Domain      | Default |
| ------------- | --------------- | ------------- | ----------- | ------- |
| `id`          | `int`           | `PRIMARY KEY` | n > 0       | x       |
| `code`        | `char(17)`      | `UNIQUE`      | 0 < n < 18  | x       |
| `name`        | `varchar(50)`   | `NOT NULL`    | 0 < n < 51> | x       |
| `description` | `nvarchar(255)` | `X`           | 0 < n < 256 | x       |
| `price`       | `int`           | `NOT NULL`    | n > 0       | x       |

- Code is a 17-character string that is generated following the convention:
  - The first 3 characters are the national drug code (NDC)
  - Followed by a `-` character.
  - Next 6-digit number is the Labeler Code
  - Followed by a `-` character.
  - Next 4-digit number is the Product Code
  - Followed by a `-` character.
  - Next 2-digit number is the Package Code
  - For example: `NDC-45678-9012-34` is a valid code.

## Tooth Table

| Field Name | Data Type     | Constraints        | Domain             | Default |
| ---------- | ------------- | ------------------ | ------------------ | ------- |
| `id`       | `int`         | `PRIMARY KEY`      | n > 0              | x       |
| `type`     | `char(1)`     | `UNIQUE, NOT NULL` | `L, F, D, M, T, R` | x       |
| `name`     | `varchar(50)` | `NOT NULL`         | 0 < n < 51         | x       |

- The type is a single character that indicates the type of the tooth.
  - Lingual (L)
  - Facial (F)
  - Distal (D)
  - Mesial (M)
  - Top (T)
  - Root (R)

## Tooth_Session Table

| Field Name           | Data Type | Constraints                | Domain | Default |
| -------------------- | --------- | -------------------------- | ------ | ------- |
| `toothID`            | `int`     | `PRIMARY KEY, FOREIGN KEY` | n > 0  | x       |
| `treatmentSessionID` | `int`     | `PRIMARY KEY, FOREIGN KEY` | n > 0  | x       |
| `order`              | `int`     | `PRIMARY KEY`              | n > 0  | x       |

Order of indexes: `treatmentSessionID` -> `toothID` -> `order`

## Prescription Table

| Field Name           | Data Type        | Constraints             | Domain      | Default |
| -------------------- | ---------------- | ----------------------- | ----------- | ------- |
| `drugID`             | `int`            | `FOREIGN KEY, NOT NULL` | n > 0       | x       |
| `treatmentSessionID` | `int`            | `FOREIGN KEY, NOT NULL` | n > 0       | x       |
| `note`               | `nvarchar(500)`* | `X`                     | 0 < n < 501 | x       |

Order of indexes: `treatmentSessionID` -> `drugID`

## Appointment Request Table

| Field Name        | Data Type       | Constraints   | Domain      | Default |
| ----------------- | --------------- | ------------- | ----------- | ------- |
| `id`              | `int`           | `PRIMARY KEY` | n > 0       | x       |
| `appointmentTime` | `datetime2`     | `NOT NULL`    | x           | x       |
| `requestTime`     | `datetime2`     | `NOT NULL`    | x           | x       |
| `note`            | `nvarchar(255)` | `X`           | 0 < n < 256 | x       |
| `patientName`     | `nvarchar(50)`  | `NOT NULL`    | 0 < n < 51  | x       |
| `patientPhone`    | `char(10)`      | `NOT NULL`    | 0 < n < 11  | x       |
| `categoryName`    | `nvarchar(50)`  | `NOT NULL`    | 0 < n < 51  | x       |

## Day

| Field Name | Data Type | Constraints   | Domain          | Default |
| ---------- | --------- | ------------- | --------------- | ------- |
| `id`       | `int`     | `PRIMARY KEY` | n > 0           | x       |
| `day`      | `char(3)` | `UNIQUE`      | `SUN, MON, ...` | x       |

- The day is a 3-character string that indicates the day of the week:
  - Sunday (SUN)
  - Monday (MON)
  - Tuesday (TUE)
  - Wednesday (WED)
  - Thursday (THU)
  - Friday (FRI)
  - Saturday (SAT)

## Schedule Table

| Field Name  | Data Type | Constraints             | Domain | Default |
| ----------- | --------- | ----------------------- | ------ | ------- |
| `dayID`     | `int`     | `FOREIGN KEY, NOT NULL` | n > 0  | x       |
| `dentistID` | `int`     | `FOREIGN KEY, NOT NULL` | n > 0  | x       |

Order of indexes: `dayID` -> `dentistID`
