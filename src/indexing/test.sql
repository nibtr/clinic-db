select * from PaymentRecord pr
join Patient p
on pr.patientID = p.id
where p.phone = '0123567180'

select * from dbo.[AppointmentRequest]
where appointmentTime >= '2023-08-26 00:00:00'
and appointmentTime < '2023-08-27 00:00:00'

select * from dbo.[AppointmentRequest]
where DATEDIFF(day, appointmentTime, '2023-08-26') = 0

select * from dbo.[Session]
where patientID = 1

select * from dbo.[PaymentRecord]
where patientID = 6969

select * from dbo.[Prescription]
where treatmentSessionID = 500

-- DBCC DROPCLEANBUFFERS
