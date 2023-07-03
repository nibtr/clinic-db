---
title: DA#3 - Modeling
date-of-creation: 2023-07-03
date-last-updated: 2023-07-03
description: Mô hình hóa nghiệp vụ và yêu cầu nghiệp vụ của đồ án
---

# DA#3 - Modeling

## 1. Business Objectives

- Quản lý hồ sơ bệnh nhân
- Quản lý cuộc hẹn
- Quản lý nhân viên
- Thống kê
- Hỗ trợ bệnh nhân đặt lịch hẹn với phòng khám
- Có thể trao đổi thông qua chức năng nhắn tin trên ứng dụng
- Xem hồ sơ khám chữa bệnh của bản thân
- Hỗ trợ giải đáp thắc mắc của khách hàng về thông tin phòng khám
- Quảng bá, giới thiệu phòng khám

## 2. Phân tích chức năng theo phân loại người dùng

### 2.1. Quản trị viên (Admin)

- Người dùng có quyền hạn cao nhất của ứng dụng
- Có thể sử dụng tất cả chức năng mà ứng dụng cung cấp

## Possible Entities

*: Cần xác định thêm và mô tả chi tiết

### Hồ sơ bệnh nhân (Dental medical record)

- Thông tin cơ bản của bệnh nhân: tên, tuổi, giới tính, sdt, email, địa chỉ, ngày sinh, quốc tịch.
- Tổng tiền điều trị đã thanh toán cho riêng section đó
- Ghi chú về tình trạng dị ứng và chống chỉ định thuốc của bệnh nhân.
- Thông tin tổng quan về sức khỏe răng miệng của bệnh nhân.
### Kế hoạch điều trị (Treatment Plan)

- Mã điều trị
- Mô tả
- Ngày điều trị
- Bác sĩ thực hiện
- Trợ khám (nếu có)
- Ghi chú cho buổi điều trị
- Danh sách các răng cần thực hiện điều trị
- Các kế hoạch điều trị sẽ có màu khác nhau tùy theo trạng thái điều trị, gồm:
  - Kế hoạch (xanh dương)
  - Đã hoàn thành (xanh lá)
  - Đã hủy (vàng)

### Liệu trinh (Treatment)

### Thanh toán (Payment)

- Tên nha sĩ phụ trách các điều trị
- Tổng tiền cần thanh toán và ngày thực hiện thanh toán
- Thông tin chi tiết của mỗi thanh toán gồm:
  - Ngày giao dịch
  - Người thanh toán
  - Tổng tiền cần thanh toán
  - Tiền đã trả
  - Tiền thối
  - Loại thanh toán (tiền mặt hoặc online)
  - Ghi chú và danh sách các điều trị cần thanh toán, mỗi điều trị gồm:
    - Mã điều trị
    - Mô tả
    - Phí và ngày điều trị
    - Hình thức thanh toán (tiền mặt/online)

### Thuốc (Medicine)

- Mã thuốc

### Lịch hẹn (Appointment)

- Thời gian hẹn
- Tên bệnh nhân
- Hẹn nha sĩ nào
- Trợ khám nào
- Phòng
- Tình trạng (cuộc hẹn mới/tái khám)
- Danh mục điều trị
