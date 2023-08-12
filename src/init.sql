create database DentalClinicDev
go
use DentalClinicDev
go

BEGIN TRY

BEGIN TRAN;
CREATE TABLE [dbo].[Account] (
    [id] INT NOT NULL IDENTITY(1,1),
    [username] CHAR(10) UNIQUE NOT NULL,
    [password] CHAR(60) NOT NULL,
    [email] VARCHAR(50) UNIQUE NOT NULL,
    [personnelID] INT UNIQUE NOT NULL,
    CONSTRAINT [Account_pkey] PRIMARY KEY CLUSTERED ([id])
);
-- For the *password*, we decided to use the following convention:
-- - The password is a 10-character string.
-- - The password is prefixed with a 3-letter code that indicates the type of the account (sta, den, adm).
-- - Followed by a `-` character.
-- - Followed by a 6-digit number that is generated randomly.
-- - The password is hashed using the `bcrypt` algorithm with 12 rounds.
-- For example: `sta-123456` will result in a hashed version `$2a$12$gEy/fBApnlR7CYu5hWQvWOQh9pt.vGPGCH3TTIdYLc4xqDODqVvwm` which is *60 characters long*.

CREATE TABLE [dbo].[Personnel] (
    [id] INT NOT NULL IDENTITY(1,1),
    [nationalID] CHAR(12) UNIQUE NOT NULL,
    [name] NVARCHAR(50) NOT NULL,
    [dob] DATE,
    [gender] CHAR(1),
	[phone]	CHAR(10) UNIQUE NOT NULL,
	[type] CHAR(3) NOT NULL,
	CONSTRAINT [Personnel_pkey] PRIMARY KEY CLUSTERED ([id])
);
-- - `type` is a 3-character string that indicates the type of personnel:
--   - `ADM`: Administrator
--   - `DEN`: Dentist
--   - `STA`: Staff
--   - `PAT`: Patient
-- - We don't save `age` because it can be calculated from `dob`, and it's not a good idea either since we have to update it every year.
-- - Caculate `age` from `dob` using the following formula:
-- ```sql
-- SELECT DATEDIFF(YEAR, dob, GETDATE()) - CASE WHEN (MONTH(dob) > MONTH(GETDATE())) OR (MONTH(dob) = MONTH(GETDATE()) AND DAY(dob) > DAY(GETDATE())) THEN 1 ELSE 0 END
-- ```

CREATE TABLE [dbo].[Patient] (
    [id] INT,
    [drugContraindication] NVARCHAR(500),
    [allergyStatus] NVARCHAR(255),
    [nationalID] CHAR(12) UNIQUE NOT NULL,
    [name] NVARCHAR(50) NOT NULL,
    [dob] DATE ,
    [gender] CHAR(1),
    [phone] CHAR(10) UNIQUE NOT NULL,
    CONSTRAINT [Patient_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[PaymentRecord] (
    [id] INT NOT NULL IDENTITY(1,1),
    [date] DATE NOT NULL,
    [total] INT NOT NULL,
    [paid] INT NOT NULL,
	[change] INT NOT NULL,
	[method] CHAR(1),
	[patientID] INT NOT NULL,
	CONSTRAINT [PaymentRecord_pkey] PRIMARY KEY CLUSTERED ([id])
);
-- For the method, there are 2 options: 
-- - Cash: denoted by `C`
-- - Online: denoted by `O`

CREATE TABLE [dbo].[Session] (
    [id] INT NOT NULL IDENTITY(1,1),
    [time] DATETIME2 NOT NULL,
    [note] NVARCHAR(1000),
    [status] CHAR(3) DEFAULT 'SCH',
	[patientID] INT NOT NULL,
	[roomID] INT NOT NULL,
    [dentistID] INT NOT NULL,
    [assistantID] INT,
    [type] CHAR(3) NOT NULL,
	CONSTRAINT [Session_pkey] PRIMARY KEY CLUSTERED ([id])
);
-- - `status` is a 3-character string that indicates the status of the session:
--   - `SCH`: Scheduled
--   - `CAN`: Cancelled
--   - `RES`: Rescheduled
--   - `COM`: Completed
--   - `EXE`: Executing
-- - `type` is a 3-character string that indicates the type of the session:
--   - `TRE`: Treatment
--   - `EXA`: Examination
--   - `REX`: Re-examination

CREATE TABLE [dbo].[TreatmentSession] (
    [id] INT,
    [healthNote] NVARCHAR(1000),
    [description] NVARCHAR(1000),
	[categoryID] INT NOT NULL,
    [PaymentRecordID] INT,
	CONSTRAINT [TreatmentSession_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[ExaminationSession] (
    [id] INT,
	CONSTRAINT [ExaminationSession_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[ReExaminationSession] (
    [id] INT,
	[relatedExaminationID] INT NOT NULL,
	CONSTRAINT [ReExaminationSession_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Room] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(6) UNIQUE NOT NULL,
    [name] VARCHAR(50) NOT NULL,
	CONSTRAINT [Room_pkey] PRIMARY KEY CLUSTERED ([id])
);	
-- - The room code is a 6-character string that is generated following the convention:
--   - The first 3 characters are the room type code (examination room, operating room, etc.).
--   - Followed by a `-` character.
--   - Next is a 2-digit number that is the room number.
--   - For example: `EXA-01` is the code for the first examination room.

CREATE TABLE [dbo].[Procedure] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(3) UNIQUE NOT NULL,
    [name] NVARCHAR(50) NOT NULL,
    [description] NVARCHAR(500),
    [fee] INT NOT NULL,
	[categoryID] INT NOT NULL,
	CONSTRAINT [Procedure_pkey] PRIMARY KEY CLUSTERED ([id])
);
-- - `code` is a 3-character string that is generated based on the name of the procedure. For example: `TA2` is the code for `Tooth Extraction`.

CREATE TABLE [dbo].[Category] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(3) UNIQUE NOT NULL,
    [name] NVARCHAR(50) NOT NULL,
    [description] NVARCHAR(255),
	CONSTRAINT [Category_pkey] PRIMARY KEY CLUSTERED ([id])
);
-- - `code` is a 3-character string that is generated based on the name of the category. For example: `GEN` is the code for `General`.

CREATE TABLE [dbo].[Drug] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(17) UNIQUE NOT NULL,
    [name] VARCHAR(50) NOT NULL,
    [description] NVARCHAR(255),
    [price] INT NOT NULL,
	CONSTRAINT [Drug_pkey] PRIMARY KEY CLUSTERED ([id])
);
-- - Code is a 17-character string that is generated following the convention:
--   - The first 3 characters are the national drug code (NDC)
--   - Followed by a `-` character.
--   - Next 6-digit number is the Labeler Code
--   - Followed by a `-` character.
--   - Next 4-digit number is the Product Code
--   - Followed by a `-` character.
--   - Next 2-digit number is the Package Code
--   - For example: `NDC-45678-9012-34` is a valid code.

CREATE TABLE [dbo].[Tooth] (
    [id] INT NOT NULL IDENTITY(1,1),
    [type] CHAR(1) UNIQUE NOT NULL,
    [name] VARCHAR(50) NOT NULL,
	CONSTRAINT [Tooth_pkey] PRIMARY KEY CLUSTERED ([id])
);	
-- - The type is a single character that indicates the type of the tooth.
--   - Lingual (L)
--   - Facial (F)
--   - Distal (D)
--   - Mesial (M)
--   - Top (T)
--   - Root (R)

CREATE TABLE [dbo].[ToothSession] (
    [toothID] INT,
	[treatmentSessionID] INT,
	[order] INT,
	CONSTRAINT [ToothSession_pkey] PRIMARY KEY CLUSTERED ([treatmentSessionID], [toothID], [order])
);	

CREATE TABLE [dbo].[Prescription] (
	[drugID] INT NOT NULL,
	[treatmentSessionID] INT NOT NULL,
    [note] NVARCHAR(500),
	CONSTRAINT [Prescription_pkey] PRIMARY KEY CLUSTERED ([treatmentSessionID], [drugID])
);	

CREATE TABLE [dbo].[AppointmentRequest] (
    [id] INT NOT NULL IDENTITY(1,1),
    [appointmentTime] DATETIME2 NOT NULL,
    [requestTime] DATETIME2 NOT NULL,
    [note] NVARCHAR(255),
    [patientName] NVARCHAR(50) NOT NULL,
    [patientPhone] CHAR(10) NOT NULL,
    [categoryName] NVARCHAR(50) NOT NULL,
	CONSTRAINT [AppointmentRequest_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Day] (
    [id] INT NOT NULL IDENTITY(1,1),
	[day] CHAR(3) UNIQUE NOT NULL,
	CONSTRAINT [Day_pkey] PRIMARY KEY CLUSTERED ([id])
);
-- - The day is a 3-character string that indicates the day of the week:
--   - Sunday (SUN)
--   - Monday (MON)
--   - Tuesday (TUE)
--   - Wednesday (WED)
--   - Thursday (THU)
--   - Friday (FRI)
--   - Saturday (SAT)

CREATE TABLE [dbo].[Schedule] (
    [dayID] INT NOT NULL,
    [dentistID] INT NOT NULL,
	CONSTRAINT [Schedule_pkey] PRIMARY KEY CLUSTERED ([dayID],[dentistID])
);	

-- Constraint in table Account
ALTER TABLE [dbo].[Account] ADD CONSTRAINT [FK_Account_Personnel] FOREIGN KEY ([personnelID]) REFERENCES [dbo].[Personnel]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Payment Record
AlTER TABLE [dbo].[PaymentRecord] ADD CONSTRAINT [FK_PaymentRecord_Patient] FOREIGN KEY ([patientID]) REFERENCES [dbo].[Patient]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;


-- Constraint in table Session
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Room] FOREIGN KEY ([roomID]) REFERENCES [dbo].[Room]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Patient] FOREIGN KEY ([patientID]) REFERENCES [dbo].[Patient]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Personnel_dentistID] FOREIGN KEY ([dentistID]) REFERENCES [dbo].[Personnel]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Personnel_assistantID] FOREIGN KEY ([assistantID]) REFERENCES [dbo].[Personnel]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Constraint in table Treatment Session
AlTER TABLE [dbo].[TreatmentSession] ADD CONSTRAINT [FK_TreatmentSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
AlTER TABLE [dbo].[TreatmentSession] ADD CONSTRAINT [FK_TreatmentSession_Category] FOREIGN KEY ([categoryID]) REFERENCES [dbo].[Category]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[TreatmentSession] ADD CONSTRAINT [FK_TreatmentSession_PaymentRecord] FOREIGN KEY ([PaymentRecordID]) REFERENCES [dbo].[PaymentRecord]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
-- Constraint in table Procedure
AlTER TABLE [dbo].[Procedure] ADD CONSTRAINT [FK_Procedure_Category] FOREIGN KEY ([categoryID]) REFERENCES [dbo].[Category]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- Constraint in table Prescription
AlTER TABLE [dbo].[Prescription] ADD CONSTRAINT [FK_Prescription_TreatmentSession] FOREIGN KEY ([treatmentSessionID]) REFERENCES [dbo].[TreatmentSession]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[Prescription] ADD CONSTRAINT [FK_Prescription_Drug] FOREIGN KEY ([drugID]) REFERENCES [dbo].[Drug]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Tooth Session
AlTER TABLE [dbo].[ToothSession] ADD CONSTRAINT [FK_ToothSession_Tooth] FOREIGN KEY ([toothID]) REFERENCES [dbo].[Tooth]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[ToothSession] ADD CONSTRAINT [FK_ToothSession_TreatmentSession] FOREIGN KEY ([treatmentSessionID]) REFERENCES [dbo].[TreatmentSession]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Examination Session
AlTER TABLE [dbo].[ExaminationSession] ADD CONSTRAINT [FK_ExaminationSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Constraint in table Re-Examination Session
AlTER TABLE [dbo].[ReExaminationSession] ADD CONSTRAINT [FK_ReExaminationSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
AlTER TABLE [dbo].[ReExaminationSession] ADD CONSTRAINT [FK_ReExaminationSession_ExaminationSession] FOREIGN KEY ([relatedExaminationID]) REFERENCES [dbo].[ExaminationSession]([id]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- Constraint in table Schedule
AlTER TABLE [dbo].[Schedule] ADD CONSTRAINT [FK_Schedule_Day] FOREIGN KEY ([dayID]) REFERENCES [dbo].[Day]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
AlTER TABLE [dbo].[Schedule] ADD CONSTRAINT [FK_Schedule_Dentist] FOREIGN KEY ([dentistID]) REFERENCES [dbo].[Personnel]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Init some basic table
-- Personnel & Account for admin
INSERT INTO [dbo].[Personnel](nationalID, name, dob, gender, phone, type) values('123456789123', 'Admin', '2002-06-01', 'M', '0777058016', 'ADM')
INSERT INTO [dbo].[Account](username, password, email, personnelID) values('ADM-123456', '$2a$12$/k35hQ1YWbiBt3a0EAFFl.o4Ec2eHd1KqfAD3Sv3lyidWSxdEQy4i', 'admin@gmail.com', 1)

-- Day
INSERT INTO [dbo].[Day] values('SUN')
INSERT INTO [dbo].[Day] values('MON')
INSERT INTO [dbo].[Day] values('TUE')
INSERT INTO [dbo].[Day] values('WED')
INSERT INTO [dbo].[Day] values('THU')
INSERT INTO [dbo].[Day] values('FRI')
INSERT INTO [dbo].[Day] values('SAT')

--Tooth
INSERT INTO [dbo].[Tooth](type, name) values('L', 'Lingual')
INSERT INTO [dbo].[Tooth](type, name) values('F', 'Facial')
INSERT INTO [dbo].[Tooth](type, name) values('D', 'Distal')
INSERT INTO [dbo].[Tooth](type, name) values('M', 'Mesial')
INSERT INTO [dbo].[Tooth](type, name) values('T', 'Top')
INSERT INTO [dbo].[Tooth](type, name) values('R', 'Root')

--Room
INSERT INTO [dbo].[Room](code, name) values('EXA-01', 'Examination Room 1');
INSERT INTO [dbo].[Room](code, name) values('EXA-02', 'Examination Room 2');
INSERT INTO [dbo].[Room](code, name) values('EXA-03', 'Examination Room 3');
INSERT INTO [dbo].[Room](code, name) values('EXA-04', 'Examination Room 4');
INSERT INTO [dbo].[Room](code, name) values('EXA-05', 'Examination Room 5');
INSERT INTO [dbo].[Room](code, name) values('SPE-01', 'Special Room 1');
INSERT INTO [dbo].[Room](code, name) values('SPE-02', 'Special Room 2');
INSERT INTO [dbo].[Room](code, name) values('EME-01', 'Emergency Room 1');
INSERT INTO [dbo].[Room](code, name) values('EME-02', 'Emergency Room 2');
INSERT INTO [dbo].[Room](code, name) values('EME-03', 'Emergency Room 3');
INSERT INTO [dbo].[Room](code, name) values('EME-04', 'Emergency Room 4');

--Category
INSERT INTO [dbo].[Category](code, name) values('CA1', 'Boc rang su')
INSERT INTO [dbo].[Category](code, name) values('CA2', 'Cay ghep implant')
INSERT INTO [dbo].[Category](code, name) values('CA3', 'Nieng rang tham my')
INSERT INTO [dbo].[Category](code, name) values('CA4', 'Tay trang rang')
INSERT INTO [dbo].[Category](code, name) values('CA5', 'Nho rang khon')
INSERT INTO [dbo].[Category](code, name) values('CA6', 'Mat dan su Veneer')
INSERT INTO [dbo].[Category](code, name) values('CA7', 'Han tram rang')
INSERT INTO [dbo].[Category](code, name) values('CA8', 'Dieu tri tuy')

COMMIT TRAN;
END TRY

BEGIN CATCH
	PRINT(@@ERROR)
    ROLLBACK TRAN;
END CATCH;

--Use for drop the database
--use master
--go
--alter database DentalClinicDev set single_user with rollback immediate
--drop database DentalClinicDev
