---
title: DA#3 - Seminar
date-of-creation: 2023-07-03
date-last-updated: 2023-07-03
description: Tóm tắt nội dung Seminar DA#3 2023-06-17
---

# Seminar DA#3 2023-06-17

## Các ý chính

- Đáng lẽ là yêu cầu quản lí cho nhiều phòng khám nhưng vì dữ liệu lớn nên giáo viên chỉ yêu cầu cho một phòng khám.
- Giáo viên có nhắc tới **"Đa khoa":** Nội trú và Ngoại trú
- Mô tả trong yêu cầu có thể mở rộng thêm:
  - Chỗ nào điều chỉnh được cho yêu cầu rõ ràng hơn có thể điều chỉnh và mô tả lại yêu cầu.
- Chi tiết quy trình: Mô tả chi tiết lại các yêu cầu nghiệp vụ (mở rộng hoặc thu hẹp) từ các yêu cầu nghiệp vụ của đồ án.
- Cần ước lượng tần suất sử dụng dữ liệu (truy vấn: đọc, ghi, cập nhật, xóa) để thiết kế cơ sở dữ liệu phù hợp.
  - **Ví dụ:** Ước lượng tần suất truy vấn của bảng là khoảng bao nhiêu (1 ngày mấy lần? 1 năm mấy lần? ...)

**=> Gom nhóm các chức năng theo thời gian:**
- Những chức năng nào sử dụng theo ngày, theo tuần, theo tháng,... => Xếp thứ tự ưu tiên.
- Ước lượng cần hợp lí, không cần chính xác 100%.

Các giai đoạn của đồ án:

- Giai đoạn 1: Thiết kế ER -> Chuyển qua lược đồ quan hệ -> Đánh giá dạng chuẩn (chuẩn thấp cần nâng chuẩn)
- Giai đoạn 2: Thiết kế mức vật lí:
  - Viết câu truy vấn như thế nào?
  - Khai báo kiểu dữ liệu gì (để truy xuất nhanh)?
  - Có cài partition, index,... ?
  - Đánh giá được mức độ hiệu quả khi sử dụng index so với không sử dụng index.
  - Các ràng buộc có kiểm tra trong stored hay trigger?

**Chỉ cài ứng dụng trên những tính năng có ưu tiên cao**:
- Các tính năng có ưu tiên thấp có thể để sau.
- Giao diện đẹp, thân thiện, UX,...

**Nhóm cần sử dụng 1 công cụ quản lý phân công và theo dõi tiến độ nhóm**

*Được cộng điểm khi áp dụng các đề tài giáo viên cho tìm hiểu vào đồ án.*
