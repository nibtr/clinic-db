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
@patientPhone CHAR(10)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @patientName NVARCHAR(50);
			IF EXISTS (SELECT [dbo].[AppointmentRequest].patientPhone FROM [dbo].[AppointmentRequest] WHERE [dbo].[AppointmentRequest].patientPhone = @patientPhone)
			BEGIN
				SELECT @patientName = patientName
				FROM [dbo].[AppointmentRequest] WHERE [dbo].[AppointmentRequest].patientPhone = @patientPhone
				DELETE FROM [dbo].[AppointmentRequest] 
				WHERE [dbo].[AppointmentRequest].patientPhone = @patientPhone AND [dbo].[AppointmentRequest].patientName = @patientName
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE checkPatientIsExamined			--STA3
@patientPhone CHAR(10)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			IF EXISTS (SELECT P.name, P.phone FROM [dbo].[Patient] P WHERE P.phone = @patientPhone)
			BEGIN
				SELECT @PatientID = P.id FROM [dbo].[Patient] P INNER JOIN [dbo].[Session] S ON S.[patientID] = P.id WHERE P.phone = @patientPhone
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
@patientName VARCHAR(50),
@patientPhone CHAR(10),
@note VARCHAR(1000)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			DECLARE @SessionID INT;
			IF EXISTS (SELECT [dbo].[Patient].id, [dbo].[Patient].name FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone)
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

CREATE PROCEDURE createNewReExaminationSession			--STA5
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
			IF EXISTS (SELECT [dbo].[Patient].id, [dbo].[Patient].name FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone)
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

CREATE PROCEDURE viewAvailableDentist			--STA6
@patientPhone CHAR(10)
AS 
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			DECLARE @SessionID INT;
			DECLARE @Time DATETIME2;

			IF EXISTS (SELECT [dbo].[Patient].id, [dbo].[Patient].name FROM [dbo].[Patient] WHERE [dbo].[Patient].phone = @patientPhone)
			BEGIN
				SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].phone = @patientPhone;
				SELECT @SessionID = id , @Time = time FROM [dbo].[Session] WHERE [patientID] = @PatientID AND [type] = 'EXA';
				SELECT P.id, P.name FROM [dbo].[Session] S INNER JOIN [dbo].[Personnel] P ON S.[dentistID] = P.[id]
				WHERE S.[time] >= DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0) -- Today's start
						AND S.[time] < DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()) + 1, 0) -- Tomorrow's start
						AND DATEDIFF(minute, S.[time], GETDATE()) > 30;
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO

CREATE PROCEDURE createNewPayment			--STA14
@patientName VARCHAR(50),
@patientPhone CHAR(10)
AS 
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			DECLARE @SessionID INT;
			DECLARE @TotalFee INT;
			IF EXISTS (SELECT [dbo].[Patient].id, [dbo].[Patient].name FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone)
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

CREATE PROCEDURE updatePayment				--STA15
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
			IF EXISTS (SELECT [dbo].[Patient].id, [dbo].[Patient].name FROM [dbo].[Patient] WHERE [dbo].[Patient].name = @patientName AND [dbo].[Patient].phone = @patientPhone)
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

CREATE PROCEDURE viewPayment			--STA17
@patientID INT
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF EXISTS (SELECT [dbo].[PaymentRecord].id, [dbo].[PaymentRecord].date FROM [dbo].[PaymentRecord] WHERE [dbo].[PaymentRecord].patientID = @patientID)
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

CREATE PROCEDURE createNewSession				--STA24
@patientPhone CHAR(10),
@note VARCHAR(1000)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			DECLARE @PatientID INT;
			DECLARE @SessionID INT;
			IF EXISTS (SELECT [dbo].[Patient].id, [dbo].[Patient].name FROM [dbo].[Patient] WHERE [dbo].[Patient].phone = @patientPhone)
			BEGIN
				SELECT @PatientID = id FROM [dbo].[Patient] WHERE [dbo].[Patient].phone = @patientPhone;
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

CREATE PROCEDURE updateAccDetail						--ADM29
@username CHAR(10),
@oldPass CHAR(60),
@newPass CHAR(60),
@role CHAR(3)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF EXISTS (SELECT A.username FROM [dbo].[Account] A INNER JOIN [dbo].[Personnel] P ON p.id = A.personnelID WHERE A.username = @username 
															AND A.password = @oldPass
															AND P.type = @role)
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

CREATE PROCEDURE viewAcc				--ADM30
@personnelID INT
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF EXISTS (SELECT username FROM [dbo].[Account] WHERE [dbo].[Account].personnelID = @personnelID)
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

CREATE PROCEDURE viewCategories						--PAT1
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

CREATE PROCEDURE viewProcedures					--PAT2
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

CREATE PROCEDURE createNewAppointment						--PAT3
@appointmentTime DATETIME2,
@note NVARCHAR(255),
@categoryName NVARCHAR(50),
@patientName NVARCHAR(50),
@patientPhone CHAR(10)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF NOT EXISTS (SELECT patientName, patientPhone FROM [dbo].[AppointmentRequest] WHERE [dbo].[AppointmentRequest].patientPhone = @patientPhone)
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

CREATE PROCEDURE updatePrescription								 --DEN12
@dentistID INT,
@patientID INT,
@newNote NVARCHAR(500)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF EXISTS (SELECT * FROM [dbo].[Session] S WHERE S.[dentistID] = @dentistID
															AND S.[patientID] = @patientID)
			BEGIN
				UPDATE P
				SET P.[note] = @newNote
				FROM [dbo].[Prescription] P
				INNER JOIN [dbo].[TreatmentSession] TS ON P.[treatmentSessionID] = TS.[id]
				INNER JOIN [dbo].[Session] S ON TS.[id] = S.[id]
				WHERE S.[patientID] = @patientID
				AND S.[dentistID] = @dentistID
			END
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
	COMMIT TRAN
END
GO