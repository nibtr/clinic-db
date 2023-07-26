create database Testing_DB
go
use Testing_DB
go

BEGIN TRY

BEGIN TRAN;
CREATE TABLE [dbo].[Account] (
    [id] INT NOT NULL IDENTITY(1,1),
    [username] CHAR(10) NOT NULL,
    [password] CHAR(60) NOT NULL,
    [email] VARCHAR(50),
    CONSTRAINT [id] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[Personel] (
    [id] INT NOT NULL IDENTITY(1,1),
    [nationalId] CHAR(21) NOT NULL,
    [name] NVARCHAR(50) NOT NULL,
    [dob] DATE,
    [gender] CHAR(1),
	[phone]	CHAR(10),
	[accountId] INT,
	CONSTRAINT [Personel_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[Patient] (
    [id] INT,
    [drugContraindication] NVARCHAR(500) NOT NULL,
    [oralHealthStatus] NVARCHAR(500) NOT NULL,
    [allergyStatus] NVARCHAR(255),
    CONSTRAINT [Patient_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[PaymentRecord] (
    [id] INT NOT NULL IDENTITY(1,1),
    [date] DATE,
    [total] INT,
    [amountPaid] INT,
	[change] INT,
	[method] CHAR(1),
	[patientId] INT,
	[treatmentSessionId] INT,
	CONSTRAINT [PaymentRecord_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Session] (
    [id] INT NOT NULL IDENTITY(1,1),
    [time] DATETIME2,
    [note] NVARCHAR(1000),
    [status] CHAR(3),
	[patientId] INT,
	[assistantId] INT,
	[dentistId] INT,
	[roomId] INT,
	CONSTRAINT [Session_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Room] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(6),
    [name] VARCHAR(50),
	[amount] INT,
	CONSTRAINT [Room_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[TreatmentSession] (
    [id] INT NOT NULL,
    [health_note] NVARCHAR(1000),
    [description] NVARCHAR(1000),
	[categoryId] INT,
	CONSTRAINT [TreatmentSession_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Procedure] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(3),
    [name] NVARCHAR(50),
    [description] NVARCHAR(500),
    [fee] INT,
	[categoryId] INT,
	CONSTRAINT [Procedure_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Category] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(3),
    [name] NVARCHAR(50),
    [description] NVARCHAR(255),
	CONSTRAINT [Category_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Drug] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(17),
    [name] NVARCHAR(50),
    [description] NVARCHAR(255),
    [price] INT,
	CONSTRAINT [Drug_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[Tooth] (
    [id] INT NOT NULL IDENTITY(1,1),
    [type] CHAR(1),
    [description] NVARCHAR(255),
	CONSTRAINT [Tooth_pkey] PRIMARY KEY CLUSTERED ([type])
);	

CREATE TABLE [dbo].[Prescription] (
    [note] NVARCHAR(1000),
	[drugId] INT,
	[sessionId] INT,
	CONSTRAINT [Prescription_pkey] PRIMARY KEY CLUSTERED ([drugId],[sessionId])
);	

CREATE TABLE [dbo].[AppointmentRequest] (
    [id] INT NOT NULL IDENTITY(1,1),
    [appointmentTime] DATETIME2,
    [requestTime] DATETIME2,
    [note] NVARCHAR(255),
    [patientName] NVARCHAR(50),
    [patientPhone] CHAR(10),
	CONSTRAINT [AppointmentRequest_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Schedule] (
    [dayId] INT,
    [dentistId] INT,
	CONSTRAINT [Schedule_pkey] PRIMARY KEY CLUSTERED ([dayId],[dentistId])
);	

CREATE TABLE [dbo].[Staff] (
    [id] INT,
	CONSTRAINT [Staff-pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Dentist] (
    [id] INT NOT NULL IDENTITY(1,1),
    [dentistId] INT,
    [scheduleId] INT,
	[dayId] INT,
	[isAbScent] CHAR(1),
	CONSTRAINT [Dentist_pkey] PRIMARY KEY CLUSTERED ([dentistId])
);

CREATE TABLE [dbo].[Assistant] (
    [id] INT NOT NULL IDENTITY(1,1),
    [assistantId] INT,
	CONSTRAINT [Assistant_pkey] PRIMARY KEY CLUSTERED ([assistantId])
);	

CREATE TABLE [dbo].[ToothSession] (
    [toothType] CHAR(1),
	[treatmentSessionId] INT,
	[order] INT,
	CONSTRAINT [Account_pkey] PRIMARY KEY CLUSTERED ([toothType],[treatmentSessionId],[order])
);	

CREATE TABLE [dbo].[ExaminationSession] (
    [id] INT,
	CONSTRAINT [ExaminationSession_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[ReExaminationSession] (
    [id] INT,
	[relatedExamination] INT,
	CONSTRAINT [ReExaminationSession_pkey] PRIMARY KEY CLUSTERED ([id],[relatedExamination])
);	

CREATE TABLE [dbo].[Day] (
    [id] INT NOT NULL IDENTITY(1,1),
	[dentistId] INT,
	[day] VARCHAR(50),
	CONSTRAINT [Day_pkey] PRIMARY KEY CLUSTERED ([id])
);	


-- Constraint in table Patient
ALTER TABLE [dbo].[Patient] ADD CONSTRAINT [FK_Patient_Personel] FOREIGN KEY ([id]) REFERENCES [dbo].[Personel]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- Constraint in table Personel
ALTER TABLE [dbo].[Personel] ADD CONSTRAINT [FK_Personel_Account] FOREIGN KEY ([accountId]) REFERENCES [dbo].[Account]([id]) ON DELETE SET NULL ON UPDATE CASCADE;


-- Constraint in table Staff
AlTER TABLE [dbo].[Staff] ADD CONSTRAINT [FK_Staff_Personel] FOREIGN KEY ([id]) REFERENCES [dbo].[Personel]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- Constraint in table Payment Record
AlTER TABLE [dbo].[PaymentRecord] ADD CONSTRAINT [FK_PaymentRecord_Patient] FOREIGN KEY ([patientId]) REFERENCES [dbo].[Patient]([id]) ON DELETE SET NULL ON UPDATE CASCADE;
AlTER TABLE [dbo].[PaymentRecord] ADD CONSTRAINT [FK_PaymentRecord_TreatmentSession] FOREIGN KEY ([treatmentSessionId]) REFERENCES [dbo].[TreatmentSession]([id]) ON DELETE SET NULL ON UPDATE CASCADE;

-- Constraint in table Session
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Room] FOREIGN KEY ([roomId]) REFERENCES [dbo].[Room]([id]) ON DELETE SET NULL ON UPDATE CASCADE;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Patient] FOREIGN KEY ([patientId]) REFERENCES [dbo].[Patient]([id]) ON DELETE SET NULL ON UPDATE CASCADE;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Assistant] FOREIGN KEY ([assistantId]) REFERENCES [dbo].[Assistant]([assistantId]) ON DELETE SET NULL ON UPDATE CASCADE;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Dentist] FOREIGN KEY ([dentistId]) REFERENCES [dbo].[Dentist]([dentistId]) ON DELETE SET NULL ON UPDATE CASCADE;

-- Constraint in table Treatment Session
AlTER TABLE [dbo].[TreatmentSession] ADD CONSTRAINT [FK_TreatmentSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE NO ACTION;
AlTER TABLE [dbo].[TreatmentSession] ADD CONSTRAINT [FK_TreatmentSession_Category] FOREIGN KEY ([categoryId]) REFERENCES [dbo].[Category]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Procedure
AlTER TABLE [dbo].[Procedure] ADD CONSTRAINT [FK_Procedure_Category] FOREIGN KEY ([categoryId]) REFERENCES [dbo].[Category]([id]) ON DELETE SET NULL ON UPDATE CASCADE;

-- Constraint in table Prescription
AlTER TABLE [dbo].[Prescription] ADD CONSTRAINT [FK_Prescription_TreatmentSession] FOREIGN KEY ([sessionId]) REFERENCES [dbo].[TreatmentSession]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[Prescription] ADD CONSTRAINT [FK_Prescription_Drug] FOREIGN KEY ([drugId]) REFERENCES [dbo].[Drug]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Tooth Session
AlTER TABLE [dbo].[ToothSession] ADD CONSTRAINT [FK_ToothSession_TreatmentSession] FOREIGN KEY ([treatmentSessionId]) REFERENCES [dbo].[TreatmentSession]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[ToothSession] ADD CONSTRAINT [FK_ToothSession_Tooth] FOREIGN KEY ([toothType]) REFERENCES [dbo].[Tooth]([type]) ON DELETE CASCADE ON UPDATE CASCADE;

-- Constraint in table Examination Session
AlTER TABLE [dbo].[ExaminationSession] ADD CONSTRAINT [FK_ExaminationSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Re-Examination Session
AlTER TABLE [dbo].[ReExaminationSession] ADD CONSTRAINT [FK_ReExaminationSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE CASCADE ON UPDATE CASCADE;
AlTER TABLE [dbo].[ReExaminationSession] ADD CONSTRAINT [FK_ReExaminationSession_ExaminationSession] FOREIGN KEY ([relatedExamination]) REFERENCES [dbo].[ExaminationSession]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Constraint in table Assistant
AlTER TABLE [dbo].[Assistant] ADD CONSTRAINT [FK_Assistant_Dentist] FOREIGN KEY ([assistantId]) REFERENCES [dbo].[Dentist]([dentistId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


-- Constraint in table Dentist
AlTER TABLE [dbo].[Dentist] ADD CONSTRAINT [FK_Dentist_Personel] FOREIGN KEY ([dentistId]) REFERENCES [dbo].[Personel]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
AlTER TABLE [dbo].[Dentist] ADD CONSTRAINT [FK_Dentist_Schedule] FOREIGN KEY ([dayID],[scheduleId]) REFERENCES [dbo].[Schedule]([dayId],[dentistId]) ON DELETE SET NULL ON UPDATE CASCADE;
-- Constraint in table Day
AlTER TABLE [dbo].[Day] ADD CONSTRAINT [FK_Day_Schedule] FOREIGN KEY ([id],[dentistId]) REFERENCES [dbo].[Schedule]([dayId],[dentistId]) ON DELETE NO ACTION ON UPDATE NO ACTION;


COMMIT TRAN;
END TRY



BEGIN CATCH
    ROLLBACK TRAN;
END CATCH;


--Use for drop the database
--use master
--go
--alter database Testing_DB set single_user with rollback immediate
--drop database Testing_DB

