use DentalClinicDev
GO
-- Account table
CREATE TRIGGER CheckPasswordLength
ON [dbo].[Account]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT password
        FROM inserted
        WHERE LEN([password]) <= 0 OR LEN([password]) > 61
    )
	BEGIN
        RAISERROR('Password length must be greater than 0 and less than 61 characters.', 16, 1)
        ROLLBACK;
	END
END;
GO

CREATE TRIGGER CheckUsernameLength
ON [dbo].[Account]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT username
        FROM inserted
        WHERE LEN([username]) <= 0 OR LEN([username]) > 11
    )
    BEGIN
        RAISERROR('Username length must be greater than 0 and less than 11 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckEmailLength
ON [dbo].[Account]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT email
        FROM inserted
        WHERE LEN([email]) <= 0 OR LEN([email]) > 51
    )
    BEGIN
        RAISERROR('Email length must be greater than 0 and less than 51 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

-- Personnel Table
CREATE TRIGGER CheckNationalIDLength
ON [dbo].[Personnel]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT nationalID
        FROM inserted
        WHERE LEN([nationalID]) <= 0 OR LEN([nationalID]) > 13
    )
    BEGIN
        RAISERROR('National ID length must be greater than 0 and less than 13 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckNameLength
ON [dbo].[Personnel]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT name
        FROM inserted
        WHERE LEN([name]) <= 0 OR LEN([name]) > 51
    )
    BEGIN
        RAISERROR('Name length must be greater than 0 and less than 13 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckPhoneLength
ON [dbo].[Personnel]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT phone
        FROM inserted
        WHERE LEN([phone]) <= 0 OR LEN([phone]) > 11
    )
    BEGIN
        RAISERROR('Phone length must be greater than 0 and less than 11 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

-- Patient Table
CREATE TRIGGER CheckPatientNationalIDLength
ON [dbo].[Patient]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT nationalID
        FROM inserted
        WHERE LEN([nationalID]) <= 0 OR LEN([nationalID]) > 13
    )
    BEGIN
        RAISERROR('National ID length must be greater than 0 and less than 13 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckPatientNameLength
ON [dbo].[Patient]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT name
        FROM inserted
        WHERE LEN([name]) <= 0 OR LEN([name]) > 51
    )
    BEGIN
        RAISERROR('Name length must be greater than 0 and less than 13 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckPatientPhoneLength
ON [dbo].[Patient]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT phone
        FROM inserted
        WHERE LEN([phone]) <= 0 OR LEN([phone]) > 11
    )
    BEGIN
        RAISERROR('Phone length must be greater than 0 and less than 11 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckPatientAllergyStatusLength
ON [dbo].[Patient]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT allergyStatus
        FROM inserted
        WHERE LEN([allergyStatus]) <= 0 OR LEN([allergyStatus]) > 256
    )
    BEGIN
        RAISERROR('Allergy Status length must be greater than 0 and less than 256 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckPatientDrugContraindicationLength
ON [dbo].[Patient]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT drugContraindication
        FROM inserted
        WHERE LEN([drugContraindication]) <= 0 OR LEN([drugContraindication]) > 501
    )
    BEGIN
        RAISERROR('Drug Contraindication length must be greater than 0 and less than 501 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

--Session Table
CREATE TRIGGER CheckSessionNoteLength
ON [dbo].[Session]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT note
        FROM inserted
        WHERE LEN([note]) <= 0 OR LEN([note]) > 1001
    )
    BEGIN
        RAISERROR('Note length must be greater than 0 and less than 1001 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

-- TreatmentSession Table
CREATE TRIGGER CheckHealthNoteLength
ON [dbo].[TreatmentSession]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT healthNote
        FROM inserted
        WHERE LEN([healthNote]) <= 0 OR LEN([healthNote]) > 1001
    )
    BEGIN
        RAISERROR('Health Note length must be greater than 0 and less than 1001 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckDescriptionLength
ON [dbo].[TreatmentSession]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT (description)
        FROM inserted
        WHERE LEN([description]) <= 0 OR LEN([description]) > 1001
    )
    BEGIN
        RAISERROR('Description length must be greater than 0 and less than 1001 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

--Room Table
CREATE TRIGGER CheckCodeLength
ON [dbo].[Room]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT code
        FROM inserted
        WHERE LEN([code]) <= 0 OR LEN([code]) > 7
    )
    BEGIN
        RAISERROR('Code length must be greater than 0 and less than 7 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckRoomNameLength
ON [dbo].[Room]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT name
        FROM inserted
        WHERE LEN([name]) <= 0 OR LEN([name]) > 51
    )
    BEGIN
        RAISERROR('Name length must be greater than 0 and less than 51 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

-- Procedure Table
CREATE TRIGGER CheckProcCodeLength
ON [dbo].[Procedure]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT code
        FROM inserted
        WHERE LEN([code]) <= 0 OR LEN([code]) > 4
    )
    BEGIN
        RAISERROR('Code length must be greater than 0 and less than 4 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckProcNameLength
ON [dbo].[Procedure]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT name
        FROM inserted
        WHERE LEN([name]) <= 0 OR LEN([name]) > 51
    )
    BEGIN
        RAISERROR('Name length must be greater than 0 and less than 51 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckProcDescriptionLength
ON [dbo].[Procedure]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT (description)
        FROM inserted
        WHERE LEN([description]) <= 0 OR LEN([description]) > 256
    )
    BEGIN
        RAISERROR('Description length must be greater than 0 and less than 256 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

-- Category Table
CREATE TRIGGER CheckCategoryCodeLength
ON [dbo].[Category]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT code
        FROM inserted
        WHERE LEN([code]) <= 0 OR LEN([code]) > 4
    )
    BEGIN
        RAISERROR('Code length must be greater than 0 and less than 4 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckCategoryNameLength
ON [dbo].[Category]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT name
        FROM inserted
        WHERE LEN([name]) <= 0 OR LEN([name]) > 51
    )
    BEGIN
        RAISERROR('Name length must be greater than 0 and less than 51 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckCategoryDescriptionLength
ON [dbo].[Category]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT (description)
        FROM inserted
        WHERE LEN([description]) <= 0 OR LEN([description]) > 256
    )
    BEGIN
        RAISERROR('Description length must be greater than 0 and less than 256 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

-- Drug Table
CREATE TRIGGER CheckDrugCodeLength
ON [dbo].[Drug]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT code
        FROM inserted
        WHERE LEN([code]) <= 0 OR LEN([code]) > 18
    )
    BEGIN
        RAISERROR('Code length must be greater than 0 and less than 18 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckDrugNameLength
ON [dbo].[Drug]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT name
        FROM inserted
        WHERE LEN([name]) <= 0 OR LEN([name]) > 51
    )
    BEGIN
        RAISERROR('Name length must be greater than 0 and less than 51 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckDrugDescriptionLength
ON [dbo].[Drug]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT (description)
        FROM inserted
        WHERE LEN([description]) <= 0 OR LEN([description]) > 256
    )
    BEGIN
        RAISERROR('Description length must be greater than 0 and less than 256 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

--Tooth Table
CREATE TRIGGER CheckToothNameLength
ON [dbo].[Tooth]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT name
        FROM inserted
        WHERE LEN([name]) <= 0 OR LEN([name]) > 51
    )
    BEGIN
        RAISERROR('Name length must be greater than 0 and less than 51 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

-- Prescription Table
CREATE TRIGGER CheckPrescriptionNoteLength
ON [dbo].[Prescription]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT note
        FROM inserted
        WHERE LEN([note]) <= 0 OR LEN([note]) > 501
    )
    BEGIN
        RAISERROR('Note length must be greater than 0 and less than 501 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

-- Appointment Request Table
CREATE TRIGGER CheckPatientNameLength
ON [dbo].[AppointmentRequest]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT patientName
        FROM inserted
        WHERE LEN([patientName]) <= 0 OR LEN([patientName]) > 51
    )
    BEGIN
        RAISERROR('Patient Name length must be greater than 0 and less than 51 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckCategoryNameLength
ON [dbo].[AppointmentRequest]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT categoryName
        FROM inserted
        WHERE LEN([categoryName]) <= 0 OR LEN([categoryName]) > 51
    )
    BEGIN
        RAISERROR('Category Name length must be greater than 0 and less than 51 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckPatientPhoneLength
ON [dbo].[AppointmentRequest]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT patientPhone
        FROM inserted
        WHERE LEN([patientPhone]) <= 0 OR LEN([patientPhone]) > 11
    )
    BEGIN
        RAISERROR('Patient phone length must be greater than 0 and less than 11 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO

CREATE TRIGGER CheckNoteLength
ON [dbo].[AppointmentRequest]
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT note
        FROM inserted
        WHERE LEN([note]) <= 0 OR LEN([note]) > 256
    )
    BEGIN
        RAISERROR('Note length must be greater than 0 and less than 256 characters.', 16, 1);
        ROLLBACK;
    END;
END;
GO
