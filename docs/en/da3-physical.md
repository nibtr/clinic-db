---
title: DA#3 - Overview
date-of-creation: 2023-07-22
date-last-updated: 2023-07-22
description: Detailed physical implementation of the database
---

# Data types

We only account for the data types that are not foreign keys since they can be inferred from the referenced table.

## Account Table

| Field Name | Data Type     |
| ---------- | ------------- |
| `id`       | `int`         |
| `username` | `char(10)`    |
| `password` | `char(60)`    |
| `email`    | `varchar(50)` |

For the *password*, we decided to use the following convention:

- The password is a 10-character string.
- The password is prefixed with a 3-letter code that indicates the type of the account (sta, den, adm).
- Followed by a `-` character.
- Followed by a 6-digit number that is generated randomly.
- The password is hashed using the `bcrypt` algorithm with 12 rounds.

For example: `sta-123456` will result in a hashed version `$2a$12$gEy/fBApnlR7CYu5hWQvWOQh9pt.vGPGCH3TTIdYLc4xqDODqVvwm` which is *60 characters long*.

## Personel Table

| Field Name   | Data Type      |
| ------------ | -------------- |
| `id`         | `int`          |
| `nationalId` | `char(12)`     |
| `name`       | `nvarchar(50)` |
| `dob`        | `date`         |
| `gender`     | `char(1)`      |
| `phone`      | `char(10)`     |

We don't save `age` because it can be calculated from `dob`, and it's not a good idea either since we have to update it every year.

## Patient Table

| Field Name             | Data Type       |
| ---------------------- | --------------- |
| `id`                   | `int`           |
| `drugContraindication` | `nvarchar(500)` |
| `oralHealthStatus`     | `nvarchar(500)` |
| `allergyStatus`        | `nvarchar(255)` |

## Payment Record Table

| Field Name   | Data Type |
| ------------ | --------- |
| `id`         | `int`     |
| `date`       | `date`    |
| `total`      | `int`     |
| `amountPaid` | `int`     |
| `change`     | `int`     |
| `method`     | `char(1)` |

For the method, there are 2 options: cash or online, denoted by `c` and `o` respectively.

## Session Table

| Field Name | Data Type        |
| ---------- | ---------------- |
| `id`       | `int`            |
| `time`     | `datetime2`      |
| `note`     | `nvarchar(1000)` |
| `status`   | `char(3)`        |

## Room Table

| Field Name | Data Type     |
| ---------- | ------------- |
| `code`     | `char(6)`     |
| `name`     | `varchar(50)` |

The room code is a 6-character string that is generated following the convention:

- The first 3 characters are the room type code (examination room, operating room, etc.).
- Followed by a `-` character.
- Next is a 2-digit number that is the room number.

For example: `EXA-01` is the code for the first examination room.

## Treatment Session Table

| Field Name    | Data Type         |
| ------------- | ----------------- |
| `id`          | `int`             |
| `health_note` | `nvarchar(1000)`* |
| `description` | `nvarchar(1000)`* |

## Procedure Table

| Field Name    | Data Type       |
| ------------- | --------------- |
| `code`        | `char(3)`       |
| `name`        | `nvarchar(50)`  |
| `description` | `nvarchar(500)` |
| `fee`         | `int`           |

## Category Table

| Field Name    | Data Type       |
| ------------- | --------------- |
| `code`        | `char(3)`       |
| `name`        | `nvarchar(50)`  |
| `description` | `nvarchar(255)` |

## Drug Table

| Field Name    | Data Type       |
| ------------- | --------------- |
| `code`        | `char(17)`      |
| `name`        | `varchar(50)`   |
| `description` | `nvarchar(255)` |
| `price`       | `int`           |

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

| Field Name   | Data Type       |
| ------------ | --------------- |
| `type`       | `char(1)`       |
| `decription` | `nvarchar(255)` |

The type is a single character that indicates the type of the tooth.
- Lingual (L)
- Facial (F)
- Distal (D)
- Mesial (M)
- Top (T)
- Root (R)

## Prescription Table

| Field Name | Data Type         |
| ---------- | ----------------- |
| `note`     | `nvarchar(1000)`* |

## Appointment Request Table

| Field Name        | Data Type       |
| ----------------- | --------------- |
| `id`              | `int`           |
| `appointmentTime` | `datetime2`     |
| `requestTime`     | `datetime2`     |
| `note`            | `nvarchar(255)` |
| `patientName`     | `nvarchar(50)`  |
| `patientPhone`    | `char(10)`      |

## Schedule Table

| Field Name | Data Type |
| ---------- | --------- |
| `id`       | `int`     |
| `day`      | `char(3)` |
