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
    [role] CHAR(3) NOT NULL,
    [personelID] INT UNIQUE NOT NULL,
    CONSTRAINT [Account_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[Personel] (
    [id] INT NOT NULL IDENTITY(1,1),
    [nationalId] CHAR(12) UNIQUE NOT NULL,
    [name] NVARCHAR(50) NOT NULL,
    [dob] DATE,
    [gender] CHAR(1),
	[phone]	CHAR(10) UNIQUE NOT NULL,
	CONSTRAINT [Personel_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[Staff] (
    [id] INT,
	CONSTRAINT [Staff_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Dentist] (
    [id] INT,
	CONSTRAINT [Dentist_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[Assistant] (
    [id] INT,
	CONSTRAINT [Assistant_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Patient] (
    [id] INT,
    [drugContraindication] NVARCHAR(500),
    [oralHealthStatus] NVARCHAR(500),
    [allergyStatus] NVARCHAR(255),
    CONSTRAINT [Patient_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[PaymentRecord] (
    [id] INT NOT NULL IDENTITY(1,1),
    [date] DATE NOT NULL,
    [total] INT NOT NULL,
    [paid] INT DEFAULT 0,
	[change] INT DEFAULT 0,
	[method] CHAR(1),
	[patientID] INT NOT NULL,
	[treatmentSessionID] INT NOT NULL,
	CONSTRAINT [PaymentRecord_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Session] (
    [id] INT NOT NULL IDENTITY(1,1),
    [time] DATETIME2 NOT NULL,
    [note] NVARCHAR(1000),
    [status] VARCHAR(6) DEFAULT 'do',
	[patientID] INT NOT NULL,
	[assistantID] INT,
	[dentistID] INT NOT NULL,
	[roomID] INT NOT NULL,
	CONSTRAINT [Session_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[TreatmentSession] (
    [id] INT,
    [healthNote] NVARCHAR(1000),
    [description] NVARCHAR(1000),
	[categoryID] INT NOT NULL,
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

CREATE TABLE [dbo].[Procedure] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(3) UNIQUE NOT NULL,
    [name] NVARCHAR(50) NOT NULL,
    [description] NVARCHAR(500),
    [fee] INT NOT NULL,
	[categoryID] INT NOT NULL,
	CONSTRAINT [Procedure_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Category] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(3) UNIQUE NOT NULL,
    [name] NVARCHAR(50) NOT NULL,
    [description] NVARCHAR(255),
	CONSTRAINT [Category_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Drug] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(17) UNIQUE NOT NULL,
    [name] VARCHAR(50) NOT NULL,
    [description] NVARCHAR(255),
    [price] INT NOT NULL,
	CONSTRAINT [Drug_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[Tooth] (
    [id] INT NOT NULL IDENTITY(1,1),
    [type] CHAR(1) UNIQUE NOT NULL,
    [name] VARCHAR(50) NOT NULL,
	CONSTRAINT [Tooth_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[ToothSession] (
    [toothID] INT,
	[treatmentSessionID] INT,
	[order] INT,
	CONSTRAINT [ToothSession_pkey] PRIMARY KEY CLUSTERED ([toothID],[treatmentSessionID],[order])
);	

CREATE TABLE [dbo].[Prescription] (
	[drugID] INT NOT NULL,
	[treatmentSessionID] INT NOT NULL,
    [note] NVARCHAR(500),
	CONSTRAINT [Prescription_pkey] PRIMARY KEY CLUSTERED ([drugID],[treatmentSessionID])
);	

CREATE TABLE [dbo].[AppointmentRequest] (
    [id] INT NOT NULL IDENTITY(1,1),
    [appointmentTime] DATETIME2 NOT NULL,
    [requestTime] DATETIME2 NOT NULL,
    [note] NVARCHAR(255),
    [patientName] NVARCHAR(50) NOT NULL,
    [patientPhone] CHAR(10) NOT NULL,
	CONSTRAINT [AppointmentRequest_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Day] (
    [id] INT NOT NULL IDENTITY(1,1),
	[day] CHAR(3) UNIQUE NOT NULL,
	CONSTRAINT [Day_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Schedule] (
    [dayID] INT NOT NULL,
    [dentistID] INT NOT NULL,
	CONSTRAINT [Schedule_pkey] PRIMARY KEY CLUSTERED ([dayID],[dentistID])
);	

-- Constraint in table Patient
ALTER TABLE [dbo].[Patient] ADD CONSTRAINT [FK_Patient_Personel] FOREIGN KEY ([id]) REFERENCES [dbo].[Personel]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Account
ALTER TABLE [dbo].[Account] ADD CONSTRAINT [FK_Account_Personel] FOREIGN KEY ([personelID]) REFERENCES [dbo].[Personel]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Staff
AlTER TABLE [dbo].[Staff] ADD CONSTRAINT [FK_Staff_Personel] FOREIGN KEY ([id]) REFERENCES [dbo].[Personel]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Dentist
AlTER TABLE [dbo].[Dentist] ADD CONSTRAINT [FK_Dentist_Personel] FOREIGN KEY ([id]) REFERENCES [dbo].[Personel]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Constraint in table Payment Record
AlTER TABLE [dbo].[PaymentRecord] ADD CONSTRAINT [FK_PaymentRecord_Patient] FOREIGN KEY ([patientID]) REFERENCES [dbo].[Patient]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[PaymentRecord] ADD CONSTRAINT [FK_PaymentRecord_TreatmentSession] FOREIGN KEY ([treatmentSessionID]) REFERENCES [dbo].[TreatmentSession]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Session
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Room] FOREIGN KEY ([roomID]) REFERENCES [dbo].[Room]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Patient] FOREIGN KEY ([patientID]) REFERENCES [dbo].[Patient]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Assistant] FOREIGN KEY ([assistantID]) REFERENCES [dbo].[Assistant]([id]) ON DELETE SET NULL ON UPDATE CASCADE;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Dentist] FOREIGN KEY ([dentistID]) REFERENCES [dbo].[Dentist]([Id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Treatment Session
AlTER TABLE [dbo].[TreatmentSession] ADD CONSTRAINT [FK_TreatmentSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
AlTER TABLE [dbo].[TreatmentSession] ADD CONSTRAINT [FK_TreatmentSession_Category] FOREIGN KEY ([categoryID]) REFERENCES [dbo].[Category]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Procedure
AlTER TABLE [dbo].[Procedure] ADD CONSTRAINT [FK_Procedure_Category] FOREIGN KEY ([categoryID]) REFERENCES [dbo].[Category]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- Constraint in table Prescription
AlTER TABLE [dbo].[Prescription] ADD CONSTRAINT [FK_Prescription_TreatmentSession] FOREIGN KEY ([treatmentSessionID]) REFERENCES [dbo].[TreatmentSession]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[Prescription] ADD CONSTRAINT [FK_Prescription_Drug] FOREIGN KEY ([drugID]) REFERENCES [dbo].[Drug]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Tooth Session
AlTER TABLE [dbo].[ToothSession] ADD CONSTRAINT [FK_ToothSession_Tooth] FOREIGN KEY ([toothID]) REFERENCES [dbo].[Tooth]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[ToothSession] ADD CONSTRAINT [FK_ToothSession_TreatmentSession] FOREIGN KEY ([treatmentSessionID]) REFERENCES [dbo].[TreatmentSession]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Examination Session
AlTER TABLE [dbo].[ExaminationSession] ADD CONSTRAINT [FK_ExaminationSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Re-Examination Session
AlTER TABLE [dbo].[ReExaminationSession] ADD CONSTRAINT [FK_ReExaminationSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[ReExaminationSession] ADD CONSTRAINT [FK_ReExaminationSession_ExaminationSession] FOREIGN KEY ([relatedExaminationID]) REFERENCES [dbo].[ExaminationSession]([id]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- Constraint in table Assistant
AlTER TABLE [dbo].[Assistant] ADD CONSTRAINT [FK_Assistant_Dentist] FOREIGN KEY ([id]) REFERENCES [dbo].[Dentist]([id]) ON DELETE CASCADE ON UPDATE NO ACTION;

-- Constraint in table Schedule
AlTER TABLE [dbo].[Schedule] ADD CONSTRAINT [FK_Schedule_Day] FOREIGN KEY ([dayID]) REFERENCES [dbo].[Day]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
AlTER TABLE [dbo].[Schedule] ADD CONSTRAINT [FK_Schedule_Dentist] FOREIGN KEY ([dentistID]) REFERENCES [dbo].[Dentist]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Init some basic table
INSERT INTO [dbo].[Day](day) values ('SUN')
INSERT INTO [dbo].[Day](day) values ('MON')
INSERT INTO [dbo].[Day](day) values ('TUE')
INSERT INTO [dbo].[Day](day) values ('WED')
INSERT INTO [dbo].[Day](day) values ('THU')
INSERT INTO [dbo].[Day](day) values ('FRI')
INSERT INTO [dbo].[Day](day) values ('SAT')

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
