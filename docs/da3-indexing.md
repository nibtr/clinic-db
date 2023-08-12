# Indexing 

**Appointment Request** table: create non clustered index on `appointmentTime`, `requestTime` 
 - Appointment Request table là bảng có dữ liệu lớn  và được thêm mỗi ngày, các staff cũng cần phải query mỗi ngày để lên lịch khám cho các appointment request
 - Các staff sẽ dựa thường dựa vào `appointmentTime` của các appointment request để tạo lịch khám nên cần đánh index trên `appointmentTime`
 - Theo nghiệp vụ, mỗi ngày, các staff sẽ thường check các appointment request có trong ngày (`requestTime` = today) nên việc tạo index trên `request_time` là cần thiết khi tần suất query diễn ra hằng ngày

**Payment Record** table: create non clustered index on `patientID`
 - Payment Record table là bảng có quan hệ one to one với Treatment Session nên dữ liệu của bảng này cũng rất lớn 
 - Việc đánh index trên các khóa ngoại `patient_id` sẽ làm tăng tốc độ truy vấn khi muốn lấy các thông tin liên quan về patient của 1 payment record, lấy các payment record của 1 patient, ...
  <!-- hình minh chứng -->

**Session** table: 
 - create non clustered index on `time`, `patientID`, `dentistID`
    - Session table là bảng với dữ liệu lớn (200000 rows) cùng với tần suất query lớn. 
    - Các trường time, `patientID`, `dentistID` là các trường ít update
    - Việc đánh index ở trường `time` nhằm giảm thiểu thời gian truy vấn các buổi khám, tái khám, buổi điều trị theo thời gian (theo  nghiệp vụ thì việc truy vấn các buổi đó theo thời gian thường được diễn ra mỗi ngày và việc update `time` thường không diễn ra thường xuyên)
    - Đánh index ở trường `patientID` , `dentistID` nhằm giảm thiểu thời gian truy vấn khi join bảng `Session` với `Patient` hay `Personnel` cũng như truy vấn `Session` theo `patientID`, `dentistID`
 - create filter index on `type`
    - Theo logic ban đầu, treatment secssion, examination, re-examination có bảng chung là Session. Khi muốn lấy data của các treatment session, examination, re-examination thì cần query bảng Session theo `type`. Vì vậy, việc tạo filter index trên `type` là cần thiết khi tần suất read data theo `type` là rất lớn 
 <!-- hình minh chứng -->

**Prescription** table: clustered index on `treatmentSessionID`, `drugID`
 - `treatmentSessionID`, `drugID` đã được đánh khóa chính nên đã có cluster index nhưng việc sắp xếp `treatmentSessionID` đứng trước đóng vai trò quan trọng trong việc tăng tốc độ truy vấn khi mà các câu điều kiện trong truy vấn đa số sử dụng `treatmentSessionID` để so sánh, tìm kiếm

**ToothSession** table: clustered index on `treatmentSessionID`, `toothID`
 - Tương tự như bảng Prescription, `treatmentSessionID`, `toothID` đã được đánh khóa chính nên đã có cluster index nhưng việc để  `treatmentSessionID` đứng trước đóng vai trò quan trọng khi mà đa số các câu điều kiện trong truy vấn đa số sử dụng `treatmentSessionID` để so sánh, tìm kiếm