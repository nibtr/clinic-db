select * from PaymentRecord pr
join Patient p
on pr.patientID = p.id
where p.phone = '0123567180'

select * from AppointmentRequest
where DATEDIFF(YEAR, requestTime, GETDATE()) = 1