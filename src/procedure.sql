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
CREATE PROCEDURE viewAppointment			--STA1
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			BEGIN TRAN
			SELECT patientName, patientPhone FROM [dbo].[AppointmentRequest] 
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE delAppoint					--STA2
@appointmentID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		BEGIN
			DELETE FROM [dbo].[AppointmentRequest] 
			WHERE [dbo].[AppointmentRequest].id = @appointmentID
		END
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH
END
GO

CREATE PROCEDURE checkPatientIsExamined			--STA3
@patientPhone CHAR(10)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			BEGIN TRAN
			IF EXISTS (SELECT P.id FROM [dbo].[Patient] P WHERE P.phone = @patientPhone)
			BEGIN
				SELECT S.id, S.dentistID, S.patientID, S.status, S.time, S.type FROM [dbo].[Patient] P INNER JOIN [dbo].[Session] S ON S.[patientID] = P.id WHERE P.phone = @patientPhone
			END
			ELSE
			BEGIN
				RAISERROR('Patient not found.',16,1)
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE createNewExaminationSesion				--STA4
@patientPhone CHAR(10),
@note VARCHAR(1000),
@roomID INT,
@dentistID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		DECLARE @PatientID INT;
		DECLARE @SessionID INT;
		IF EXISTS (SELECT [dbo].[Patient].id, [dbo].[Patient].name FROM [dbo].[Patient] WHERE [dbo].[Patient].phone = @patientPhone)
		BEGIN
			SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].phone = @patientPhone;
			DECLARE @InsertedIDs TABLE (ID INT);
			INSERT INTO [dbo].[Session](time, patientID, note, type, roomID, dentistID) OUTPUT inserted.id INTO @InsertedIDs VALUES (GETDATE(), @PatientID, @note, 'EXA', @roomID, @dentistID);
			SELECT @SessionID = ID FROM @InsertedIDs;
			INSERT INTO [dbo].[ExaminationSession](id) VALUES (@SessionID)
		END
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH
END
GO


CREATE PROCEDURE createNewReExaminationSession			--STA5
@patientPhone CHAR(10),
@note VARCHAR(1000),
@roomID INT,
@dentistID INT,
@assistantID INT
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		DECLARE @PatientID INT;
		DECLARE @examSessionID INT;
		DECLARE @SessionID INT;
		DECLARE @time DATETIME2;
		SELECT top 1 @time = appointmentTime FROM AppointmentRequest WHERE dbo.AppointmentRequest.patientPhone = @patientPhone AND  appointmentTime < GETDATE() ORDER BY id DESC 
		SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].phone = @patientPhone
		IF @PatientID IS NOT NULL 
		BEGIN
			DECLARE @InsertedIDs TABLE (ID INT);
			IF EXISTS (SELECT [dbo].[Personnel].id FROM [dbo].[Personnel] WHERE [dbo].[Personnel].id = @assistantID AND [dbo].[Personnel].type = 'AST')
				BEGIN
					SELECT @examSessionID = MAX(id) FROM [dbo].[Session] WHERE [dbo].[Session].patientID = @PatientID AND [dbo].[Session].type = 'EXA'
					INSERT INTO [dbo].[Session](time, patientID, note, type, roomID, dentistID, assistantID) OUTPUT inserted.id INTO @InsertedIDs VALUES (@time, @PatientID, @note, 'REX', @roomID, @dentistID, @assistantID);
					SELECT @SessionID = ID FROM @InsertedIDs;
				END
				ELSE
				BEGIN
					SELECT @examSessionID = MAX(id) FROM [dbo].[Session] WHERE [dbo].[Session].patientID = @PatientID AND [dbo].[Session].type = 'EXA'
					INSERT INTO [dbo].[Session](time, patientID, note, type, roomID, dentistID) OUTPUT inserted.id INTO @InsertedIDs VALUES (@time, @PatientID, @note, 'REX', @roomID, @dentistID);
					SELECT @SessionID = ID FROM @InsertedIDs;
				END
			INSERT INTO [dbo].[ReExaminationSession] (id,relatedExaminationID) VALUES (@SessionID, @examSessionID);
		END
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		print('ERROR')
		ROLLBACK TRAN
	END CATCH
END
GO

CREATE PROCEDURE viewAvailableDentist			--STA7			-- FIX THIS PROC
@day INT
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		DECLARE @SessionID INT;
		DECLARE @Time DATETIME2;
		IF (@day IN (1,2,3,4,5,6,7))
		BEGIN
			SELECT *
			FROM [dbo].[SCHEDULE] S JOIN [dbo].[Personnel] P ON P.id = S.dentistID WHERE S.dayID = @day;
		END
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH
END
GO




CREATE PROCEDURE createNewPayment			--STA14
@patientPhone CHAR(10),
@total INT,
@change INT,
@paid INT
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		DECLARE @PatientID INT;
		SELECT @PatientID = [dbo].[Patient].id FROM [dbo].[Patient] WHERE [dbo].[Patient].phone = @patientPhone
		IF @PatientID IS NOT NULL
		BEGIN
			INSERT INTO [dbo].[PaymentRecord](date, total, paid, change, patientID) VALUES (CONVERT(DATE, GETDATE()), @total, @paid, @change, @PatientID)
		END
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH
END
GO

CREATE PROCEDURE updatePayment				--STA15
@patientPhone CHAR(10),
@paid INT,
@change INT,
@method CHAR(1),
@date DATETIME2
AS 
BEGIN
	BEGIN TRY
		BEGIN TRAN
		DECLARE @PatientID INT;
		DECLARE @TotalFee INT;
		SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].phone = @patientPhone
		IF @PatientID IS NOT NULL
		BEGIN
			UPDATE [dbo].[PaymentRecord]
			SET [dbo].[PaymentRecord].[paid] = @paid,
			[dbo].[PaymentRecord].[change] = @change,
			[dbo].[PaymentRecord].[method] = @method,
			[dbo].[PaymentRecord].[date] = CONVERT(DATE, GETDATE())
			WHERE [patientID] = @PatientID AND [date] = @date
		END
		ELSE
		BEGIN
			PRINT('ERROR')
		END
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH
END
GO

CREATE PROCEDURE viewPaymentRecord			--STA17
@patientID INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		IF EXISTS (SELECT [dbo].[PaymentRecord].id, [dbo].[PaymentRecord].date FROM [dbo].[PaymentRecord] WHERE [dbo].[PaymentRecord].patientID = @patientID)
		BEGIN
			SELECT * FROM [dbo].[PaymentRecord] WHERE [dbo].[PaymentRecord].patientID = @patientID
		END
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH
END
GO

CREATE PROCEDURE createNewSession				--STA24
@patientPhone CHAR(10),
@note VARCHAR(1000),
@room INT,
@dentistID INT,
@assistantID INT
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			DECLARE @SessionID INT;
			SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].phone = @patientPhone;
			IF @PatientID IS NOT NULL
			BEGIN
				DECLARE @InsertedIDs TABLE (ID INT);
				INSERT INTO [dbo].[Session](time, patientID, note, type, status, dentistID, assistantID, roomID) OUTPUT inserted.id INTO @InsertedIDs VALUES (CONVERT(DATETIME2,GETDATE()), @PatientID, @note, 'TRE','SCH', @dentistID, @assistantID, @room);
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
