---
title: DA#3 - Data generating
date-of-creation: 2023-08-15
date-last-updated: 2023-08-15
description: Detailed description of the data generating process
---

## Tool

We have decided to use [Red Gate SQL Data Generator](https://www.red-gate.com/products/dba/sql-data-generator/) to generate the data. The reason is that it is fairly easy to use and supports a wide range of data types. It also has a built-in feature to generate data based on other tables, which is useful for generating foreign keys.

![data gen](../assets/data-gen.png)

## Functionalities

The tool also provides preview of the data that will be generated, which is useful for checking if the data is generated correctly. In some cases where the type of data is genereted by regex pattern, this functionality is very useful.

![Alt text](../assets/data-gen-2.png)

The tool supports rollback in case there are errors during the data generation process. In case of a successful generation, the tool will generate a notification form with the number of rows generated for each table.

![Alt text](../assets/data-gen-4.png)

The results will in most cases be instantly visible in the database, but in some cases it is necessary to refresh the database in order to see the changes.

![Alt text](../assets/data-gen-3.png)

## Foreign Keys

The tool also supports generating data based on other tables. This is useful for generating foreign keys. The tool will automatically detect the foreign keys and will generate data based on the data in the referenced table.

We will discuss 2 cases of generating foreign keys:

- The first case is when the foreign key is a simple reference to another table. For example, the `Session` table has a foreign key to the `Patient` table, as you can see in the image below:

![Alt text](../assets/data-gen-5.png)

In this case, the tool will automatically detect the foreign key and will generate data based on the `Patient` table:

![Alt text](../assets/data-gen-6.png)

- The second case is when the foreign key is a reference to another table with a specific type. Take for example the following 4 tables: `Session`, `ExaminationSession`, `ReExaminationSession` and `TreatmentSession`. In which, `Session` is the parent relation and the rest are child relations who reference the `Session` table. There is a `type` field in the `Session` relation which can be used to help reference the exact type for the child relations:

![Alt text](../assets/data-gen-5.png)

The tool default foreign key is automatically referenced with the input table but we can opt in to change to a custom foreign key if we want to, by writing a custom query. In this case, we reference the `Session` table with `type = EXA` in the `ExaminationSession` table:

![Alt text](../assets/data-gen-7.png)

The other cases are similar to this one, by changing the `type` to the corresponding type of the child relation.

## Limitations

- Datetime data type can be a trouble in terms of correctness due to it being generated randomly. This can lead to some cases where the data is not consistent. For example, a session can have a start time that is later than the end time.
- The tool does not support generating data based on other tables if the table is empty. This can be a problem if the table is empty and the data is generated based on that table.

## Backups

After the processs of data generating is finished, we will create a backup of the database. This is done in order to have a backup of the database in case something goes wrong during the data analysis process. The backup will then be uploaded to the Google Drive and is shared internally with the team.
