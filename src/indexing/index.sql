-- Indexing
CREATE NONCLUSTERED INDEX idx_payment_record_patient_id ON [dbo].[PaymentRecord]([patientID]);

CREATE NONCLUSTERED INDEX idx_appointment_req_appointment_time ON [dbo].[AppointmentRequest]([appointmentTime]);
CREATE NONCLUSTERED INDEX idx_appointment_req_request_time ON [dbo].[AppointmentRequest]([requestTime]);

CREATE NONCLUSTERED INDEX idx_session_time ON [dbo].[Session]([time]);
CREATE NONCLUSTERED INDEX idx_session_patient_id ON [dbo].[Session]([patientID]);
CREATE NONCLUSTERED INDEX idx_session_dentist_id ON [dbo].[Session]([dentistID]);
