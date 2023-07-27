create database Testing_DB
go
use Testing_DB
go

BEGIN TRY

BEGIN TRAN;
CREATE TABLE [dbo].[Account] (
    [id] INT NOT NULL IDENTITY(1,1),
    [username] CHAR(10) UNIQUE,
    [password] CHAR(60) NOT NULL,
    [email] VARCHAR(50) UNIQUE,
    [role] CHAR(3) NOT NULL,
    [personelId] INT NOT NULL,
    CONSTRAINT [Account_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[Personel] (
    [id] INT NOT NULL IDENTITY(1,1),
    [nationalId] CHAR(12) UNIQUE,
    [name] NVARCHAR(50) NOT NULL,
    [dob] DATE,
    [gender] CHAR(1),
	[phone]	CHAR(10) UNIQUE,
	CONSTRAINT [Personel_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[Staff] (
    [id] INT,
	CONSTRAINT [Staff-pkey] PRIMARY KEY CLUSTERED ([id])
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
	[patientId] INT NOT NULL,
	[treatmentSessionId] INT NOT NULL,
	CONSTRAINT [PaymentRecord_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Session] (
    [id] INT NOT NULL IDENTITY(1,1),
    [time] DATETIME2 NOT NULL,
    [note] NVARCHAR(1000),
    [status] CHAR(6) DEFAULT 'do',
	[patientId] INT NOT NULL,
	[assistantId] INT,
	[dentistId] INT NOT NULL,
	[roomId] INT NOT NULL,
	CONSTRAINT [Session_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[TreatmentSession] (
    [id] INT NOT NULL,
    [health_note] NVARCHAR(1000),
    [description] NVARCHAR(1000),
	[categoryId] INT NOT NULL,
	CONSTRAINT [TreatmentSession_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[ExaminationSession] (
    [id] INT,
	CONSTRAINT [ExaminationSession_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[ReExaminationSession] (
    [id] INT,
	[relatedExamination] INT NOT NULL,
	CONSTRAINT [ReExaminationSession_pkey] PRIMARY KEY CLUSTERED ([id],[relatedExamination])
);	

CREATE TABLE [dbo].[Room] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(6) UNIQUE,
    [name] VARCHAR(50) NOT NULL,
	CONSTRAINT [Room_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Procedure] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(3) UNIQUE,
    [name] NVARCHAR(50) NOT NULL,
    [description] NVARCHAR(500),
    [fee] INT NOT NULL,
	[categoryId] INT NOT NULL,
	CONSTRAINT [Procedure_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Category] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(3) UNIQUE,
    [name] NVARCHAR(50) NOT NULL,
    [description] NVARCHAR(255),
	CONSTRAINT [Category_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Drug] (
    [id] INT NOT NULL IDENTITY(1,1),
    [code] CHAR(17) UNIQUE,
    [name] NVARCHAR(50) NOT NULL,
    [description] NVARCHAR(255),
    [price] INT NOT NULL,
	CONSTRAINT [Drug_pkey] PRIMARY KEY CLUSTERED ([id])
);

CREATE TABLE [dbo].[Tooth] (
    [id] INT NOT NULL IDENTITY(1,1),
    [type] CHAR(1) UNIQUE,
    [name] NVARCHAR(50) NOT NULL,
	CONSTRAINT [Tooth_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[ToothSession] (
    [toothId] INT,
	[treatmentSessionId] INT,
	[order] INT,
	CONSTRAINT [ToothSession_pkey] PRIMARY KEY CLUSTERED ([toothId],[treatmentSessionId],[order])
);	


CREATE TABLE [dbo].[Prescription] (
	[drugId] INT NOT NULL,
	[treatmentSessionId] INT NOT NULL,
    [note] NVARCHAR(500),
	CONSTRAINT [Prescription_pkey] PRIMARY KEY CLUSTERED ([drugId],[treatmentSessionId])
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
	[day] CHAR(3) UNIQUE,
	CONSTRAINT [Day_pkey] PRIMARY KEY CLUSTERED ([id])
);	

CREATE TABLE [dbo].[Schedule] (
    [dayId] INT NOT NULL,
    [dentistId] INT NOT NULL,
	CONSTRAINT [Schedule_pkey] PRIMARY KEY CLUSTERED ([dayId],[dentistId])
);	



-- Constraint in table Patient
ALTER TABLE [dbo].[Patient] ADD CONSTRAINT [FK_Patient_Personel] FOREIGN KEY ([id]) REFERENCES [dbo].[Personel]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- Constraint in table Account
ALTER TABLE [dbo].[Account] ADD CONSTRAINT [FK_Account_Personel] FOREIGN KEY ([personelId]) REFERENCES [dbo].[Personel]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;


-- Constraint in table Staff
AlTER TABLE [dbo].[Staff] ADD CONSTRAINT [FK_Staff_Personel] FOREIGN KEY ([id]) REFERENCES [dbo].[Personel]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- Constraint in table Dentist
AlTER TABLE [dbo].[Dentist] ADD CONSTRAINT [FK_Dentist_Personel] FOREIGN KEY ([id]) REFERENCES [dbo].[Personel]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Constraint in table Payment Record
AlTER TABLE [dbo].[PaymentRecord] ADD CONSTRAINT [FK_PaymentRecord_Patient] FOREIGN KEY ([patientId]) REFERENCES [dbo].[Patient]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[PaymentRecord] ADD CONSTRAINT [FK_PaymentRecord_TreatmentSession] FOREIGN KEY ([treatmentSessionId]) REFERENCES [dbo].[TreatmentSession]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Session
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Room] FOREIGN KEY ([roomId]) REFERENCES [dbo].[Room]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Patient] FOREIGN KEY ([patientId]) REFERENCES [dbo].[Patient]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Assistant] FOREIGN KEY ([assistantId]) REFERENCES [dbo].[Assistant]([id]) ON DELETE SET NULL ON UPDATE CASCADE;
AlTER TABLE [dbo].[Session] ADD CONSTRAINT [FK_Session_Dentist] FOREIGN KEY ([dentistId]) REFERENCES [dbo].[Dentist]([Id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Treatment Session
AlTER TABLE [dbo].[TreatmentSession] ADD CONSTRAINT [FK_TreatmentSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE NO ACTION;
AlTER TABLE [dbo].[TreatmentSession] ADD CONSTRAINT [FK_TreatmentSession_Category] FOREIGN KEY ([categoryId]) REFERENCES [dbo].[Category]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Procedure
AlTER TABLE [dbo].[Procedure] ADD CONSTRAINT [FK_Procedure_Category] FOREIGN KEY ([categoryId]) REFERENCES [dbo].[Category]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Prescription
AlTER TABLE [dbo].[Prescription] ADD CONSTRAINT [FK_Prescription_TreatmentSession] FOREIGN KEY ([treatmentSessionId]) REFERENCES [dbo].[TreatmentSession]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;
AlTER TABLE [dbo].[Prescription] ADD CONSTRAINT [FK_Prescription_Drug] FOREIGN KEY ([drugId]) REFERENCES [dbo].[Drug]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Tooth Session
AlTER TABLE [dbo].[ToothSession] ADD CONSTRAINT [FK_ToothSession_Tooth] FOREIGN KEY ([toothId]) REFERENCES [dbo].[Tooth]([id]) ON DELETE CASCADE ON UPDATE CASCADE;
AlTER TABLE [dbo].[ToothSession] ADD CONSTRAINT [FK_ToothSession_TreatmentSession] FOREIGN KEY ([treatmentSessionId]) REFERENCES [dbo].[TreatmentSession]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Examination Session
AlTER TABLE [dbo].[ExaminationSession] ADD CONSTRAINT [FK_ExaminationSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- Constraint in table Re-Examination Session
AlTER TABLE [dbo].[ReExaminationSession] ADD CONSTRAINT [FK_ReExaminationSession_Session] FOREIGN KEY ([id]) REFERENCES [dbo].[Session]([id]) ON DELETE CASCADE ON UPDATE CASCADE;
AlTER TABLE [dbo].[ReExaminationSession] ADD CONSTRAINT [FK_ReExaminationSession_ExaminationSession] FOREIGN KEY ([relatedExamination]) REFERENCES [dbo].[ExaminationSession]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Constraint in table Assistant
AlTER TABLE [dbo].[Assistant] ADD CONSTRAINT [FK_Assistant_Dentist] FOREIGN KEY ([id]) REFERENCES [dbo].[Dentist]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


-- Constraint in table Schedule
AlTER TABLE [dbo].[Schedule] ADD CONSTRAINT [FK_Schedule_Day] FOREIGN KEY ([dayId]) REFERENCES [dbo].[Day]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
AlTER TABLE [dbo].[Schedule] ADD CONSTRAINT [FK_Schedule_Dentist] FOREIGN KEY ([dentistId]) REFERENCES [dbo].[Dentist]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;


COMMIT TRAN;
END TRY



BEGIN CATCH
    ROLLBACK TRAN;
END CATCH;


--Use for drop the database
use master
go
alter database Testing_DB set single_user with rollback immediate
drop database Testing_DB

