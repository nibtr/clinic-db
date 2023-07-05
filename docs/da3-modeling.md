---
title: DA#3 - Modeling
date-of-creation: 2023-07-03
date-last-updated: 2023-07-05
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

- Tên
- Tuổi
- Giới tính
- Ngày sinh
- SDT
- Tổng tiền điều trị đã thanh toán *
- Thông tin tổng quan về sức khỏe răng miệng của bệnh nhân.
- Ghi chú về tình trạng dị ứng
- Thông tin chống chỉ định thuốc của bệnh nhân.

### Kế hoạch điều trị (Treatment Plan) (DANH SÁCH NHỮNG BUỔI ĐIỀU TRỊ CỦA BỆNH NHÂN)

- **Mã điều trị**
- Mô tả
- **Ngày điều trị**
- **Bác sĩ thực hiện**
- **Trợ khám (nếu có)**
- Ghi chú cho buổi điều trị
- Danh sách các răng cần thực hiện điều trị
- Trạng thái (màu):
  - Kế hoạch (xanh dương)
  - Đã hoàn thành (xanh lá)
  - Đã hủy (vàng)
- Liệu trình (FK)
- Răng (enum)

### Liệu trình (Treatment)

- **Ngày điều trị**
- **Bác sĩ thực hiện**
- **Trợ khám (nếu có)**
- Danh mục điều trị *

### Danh mục điều trị (Treatment Item)

- Mã danh mục điều trị
- Tên danh mục
- Mô tả

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

**My personal understanding about Treament plan**:

**Kế hoạch điều trị**:

| STT | Ngày điều trị | Liệu trình | Bệnh nhân |
| --- | ------------- | ---------- | --------- |
| 1   | 2021-07-03    | A-1        | BN-1      |
| 2   | 2021-07-10    | A-1        | BN-1      |
| 3   | 2021-07-17    | A-1        | BN-1      |
| ... | ...           | ...        | ...       |

**Liệu trình**:

| PK  | Tên liệu trình |
| --- | -------------- |
| A-1 | Bọc răng sứ    |
| A-2 | Chỉnh nha      |
| ... | ...            |


**Danh mục điều trị**:

| Mã danh mục | Tên danh mục | Mô tả  | Liệu trình |
| ----------- | ------------ | ------ | ---------- |
| DM-1        | Danh mục 1   | blabla | A-1        |
| DM-2        | Danh mục 2   | blabla | A-1        |
| DM-3        | Danh mục 3   | blabla | A-1        |
| ...         | ...          | ...    | ...        |