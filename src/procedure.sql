use DentalClinicDev
go

-- PROC FOR STAFF:
-- STA1: View patient's appointment requests
-- STA2: Delete patient's appointment requests
-- STA3: Check if a patient has done a session before 
-- STA4: Staff schedules a new appointment (examination session) for patient
-- STA5: Staff schedules a new re-examination session for patient
-- STA6: Staff views list of available dentists for an appointment (examination session) of a patient
-- STA14: Staff creates a new payment record for a patient
-- STA15: Staff updates a payment record for a patient
-- STA17: View a patient's payment records 
-- STA24: creates a new treatment session for a patient


-- PROC FOR DENTIST:
-- DEN12: Update a patient's prescription

-- PROC FOR ADMIN:
-- ADM29: Update account details
-- ADM30: View account details 

-- PROC FOR PATIENT:
-- PAT1: View list of categories 
-- PAT2: View list of procedures of a category
-- PAT3: Schedule a new appointment





-- PROC OF STAFF
CREATE PROCEDURE STA1
@patientName NVARCHAR(50),
@patientPhone CHAR(10)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF EXISTS (SELECT * FROM [dbo].[AppointmentRequest] WHERE [dbo].[AppointmentRequest].patientName = @patientName AND [dbo].[AppointmentRequest].patientPhone = @patientPhone)
			BEGIN
				SELECT * FROM [dbo].[AppointmentRequest] WHERE [dbo].[AppointmentRequest].patientName = @patientName AND [dbo].[AppointmentRequest].patientPhone = @patientPhone
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE STA2
@patientName NVARCHAR(50),
@patientPhone CHAR(10),
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF EXISTS (SELECT * FROM [dbo].[AppointmentRequest] WHERE [dbo].[AppointmentRequest].patientName = @patientName AND [dbo].[AppointmentRequest].patientPhone = @patientPhone)
			BEGIN
				DELETE FROM [dbo].[AppointmentRequest] 
				WHERE [dbo].[AppointmentRequest].patientPhone = @patientPhone
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE STA3
@patientName VARCHAR(50),
@patientPhone CHAR(10)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			IF EXISTS (SELECT * FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone)
			BEGIN
				SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone
				SELECT * FROM [dbo].[Session] WHERE [dbo].[Session].patientID = @PatientID
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE STA4
@patientName VARCHAR(50),
@patientPhone CHAR(10),
@note VARCHAR(1000)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			DECLARE @SessionID INT;
			IF EXISTS (SELECT * FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone)
			BEGIN
				SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone;
				DECLARE @InsertedIDs TABLE (ID INT);
				INSERT INTO [dbo].[Session](time, patientID, note, type) OUTPUT inserted.id INTO @InsertedIDs VALUES (GETDATE(), @PatientID, @note, 'EXA');
				SELECT @SessionID = ID FROM @InsertedIDs;
				INSERT INTO [dbo].[ExaminationSession] (id) VALUES (@SessionID)
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE STA5
@patientName VARCHAR(50),
@patientPhone CHAR(10),
@note VARCHAR(1000)
AS 
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			DECLARE @examSessionID INT;
			DECLARE @SessionID INT;
			IF EXISTS (SELECT * FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone)
			BEGIN
				SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone;
				SELECT @examSessionID = id FROM [dbo].[Session] WHERE [dbo].[Session].patientID = @PatientID AND [dbo].[Session].type = 'EXA';
				DECLARE @InsertedIDs TABLE (ID INT);
				INSERT INTO [dbo].[Session](time, patientID, note) OUTPUT inserted.id INTO @InsertedIDs VALUES (GETDATE(), @PatientID, @note);
				SELECT @SessionID = ID FROM @InsertedIDs;
				INSERT INTO [dbo].[ReExaminationSession] (id,relatedExaminationID) VALUES (@SessionID, @examSessionID);
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE STA6
@patientName VARCHAR(50),
@patientPhone CHAR(10)
AS 
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			DECLARE @SessionID INT;

			IF EXISTS (SELECT * FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone)
			BEGIN
				SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone;
				SELECT @SessionID = id FROM [dbo].[Session] WHERE [patientID] = @PatientID AND [type] = 'EXA';
				SELECT * FROM [dbo].[PersonnelSession], [dbo].[Personnel] WHERE [sessionID] = @SessionID AND [dbo].[PersonnelSession].dentistID = [dbo].[Personnel].id
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE STA14
@patientName VARCHAR(50),
@patientPhone CHAR(10)
AS 
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			DECLARE @SessionID INT;
			DECLARE @TotalFee INT;
			IF EXISTS (SELECT * FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone)
			BEGIN
				SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone;
				SELECT @SessionID = id FROM [dbo].[Session] WHERE [patientID] = @PatientID AND [type] = 'EXA';
				SELECT @TotalFee = SUM(P.[fee])
					FROM [dbo].[Procedure] P
					INNER JOIN [dbo].[Category] C ON P.[categoryID] = C.[id]
					INNER JOIN [dbo].[TreatmentSession] TS ON C.[id] = TS.[categoryID]
					INNER JOIN [dbo].[Session] S ON TS.[id] = S.[id]
					WHERE S.[patientID] = @PatientID
					  AND S.[id] = @SessionID;
				INSERT INTO [dbo].[PaymentRecord](date, total, patientID, treatmentSessionID) VALUES (GETDATE(), @TotalFee, @PatientID, @SessionID)
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE STA15
@patientName VARCHAR(50),
@patientPhone CHAR(10),
@paid INT,
@change INT,
@method CHAR(1)
AS 
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			DECLARE @SessionID INT;
			DECLARE @TotalFee INT;
			IF EXISTS (SELECT * FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone)
			BEGIN
				SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone;
				UPDATE [dbo].[PaymentRecord]
				SET [dbo].[PaymentRecord].[paid] = @paid,
				[dbo].[PaymentRecord].[change] = @change,
				[dbo].[PaymentRecord].[method] = @method,
				[dbo].[PaymentRecord].[date] = GETDATE()
				WHERE [patientID] = @PatientID
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE STA17
@patientID INT
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF EXISTS (SELECT * FROM [dbo].[PaymentRecord] WHERE [dbo].[PaymentRecord].patientID = @patientID)
			BEGIN
				SELECT * FROM [dbo].[PaymentRecord] WHERE [dbo].[PaymentRecord].patientID = @patientID
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE STA24
@patientName VARCHAR(50),
@patientPhone CHAR(10),
@note VARCHAR(1000)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			DECLARE @SessionID INT;
			IF EXISTS (SELECT * FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone)
			BEGIN
				SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone;
				DECLARE @InsertedIDs TABLE (ID INT);
				INSERT INTO [dbo].[Session](time, patientID, note, type) OUTPUT inserted.id INTO @InsertedIDs VALUES (GETDATE(), @PatientID, @note, 'TRE');
				SELECT @SessionID = ID FROM @InsertedIDs;
				INSERT INTO [dbo].[ExaminationSession] (id) VALUES (@SessionID)
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

-- PROC OF ADMIN

CREATE PROCEDURE ADM29
@username CHAR(10),
@oldPass CHAR(60),
@newPass CHAR(60),
@role CHAR(3)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF EXISTS (SELECT * FROM [dbo].[Account] WHERE [dbo].[Account].username = @username 
															AND [dbo].[Account].password = @oldPass
															AND [dbo].[Account].personnelID = [dbo].[Personnel].id
															AND [dbo].[Personnel].type = @role)
			BEGIN
				UPDATE [dbo].[Account]
				SET [password] = @newPass
				WHERE [dbo].[Account].username = @username 
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE ADM30
@personnelID INT
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF EXISTS (SELECT * FROM [dbo].[Account] WHERE [dbo].[Account].personnelID = @personnelID)
			BEGIN
				SELECT * FROM [dbo].[Account] WHERE [dbo].[Account].personnelID = @personnelID
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO


-- PROC OF PATIENT

CREATE PROCEDURE PAT1
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			SELECT * FROM [dbo].[Category]
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE PAT2
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			SELECT * FROM [dbo].[Procedure] P JOIN [dbo].[Category] C ON P.[categoryID] = C.[id]
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE PAT3
@appointmentTime DATETIME2,
@note NVARCHAR(255),
@categoryName NVARCHAR(50),
@patientName NVARCHAR(50),
@patientPhone CHAR(10)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF NOT EXISTS (SELECT * FROM [dbo].[AppointmentRequest] WHERE [dbo].[AppointmentRequest].patientName = @patientName AND [dbo].[AppointmentRequest].patientPhone = @patientPhone)
			BEGIN
				INSERT INTO [dbo].[AppointmentRequest](appointmentTime, requestTime, note, patientName, patientPhone, categoryName)
				values (@appointmentTime, GETDATE(), @note, @patientName, @patientPhone, @categoryName);
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO


-- PROC OF DENTIST

CREATE PROCEDURE DEN12
@dentistID INT,
@patientID INT,
@newNote NVARCHAR(500)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF EXISTS (SELECT * FROM [dbo].[PersonnelSession] PS INNER JOIN [dbo].[Session] S ON S.[id] = PS.[SessionID] WHERE PS.[dentistID] = @dentistID
																														AND S.[patientID] = @patientID)
			BEGIN
				UPDATE P
				SET P.[note] = @newNote
				FROM [dbo].[Prescription] P
				INNER JOIN [dbo].[TreatmentSession] TS ON P.[treatmentSessionID] = TS.[id]
				INNER JOIN [dbo].[Session] S ON TS.[id] = S.[id]
				INNER JOIN [dbo].[PersonnelSession] PS ON S.[id] = PS.[sessionID]
				WHERE S.[patientID] = @patientID
				AND PS.[dentistID] = @dentistID
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO