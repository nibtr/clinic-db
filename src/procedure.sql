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
@patientID CHAR(10)
AS
BEGIN
		BEGIN TRY
			BEGIN TRAN
			DECLARE @patientPhone CHAR(10);
			BEGIN
				DELETE FROM [dbo].[AppointmentRequest] 
				WHERE [dbo].[AppointmentRequest].patientPhone IN (SELECT @patientPhone = phone FROM PATIENT WHERE id = @patientID)
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
			DECLARE @PatientID INT;
			IF EXISTS (SELECT P.id FROM [dbo].[Patient] P WHERE P.phone = @patientPhone)
			BEGIN
				SELECT @PatientID = P.id FROM [dbo].[Patient] P INNER JOIN [dbo].[Session] S ON S.[patientID] = P.id WHERE P.phone = @patientPhone
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