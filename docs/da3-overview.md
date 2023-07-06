---
title: DA#3 - Overview
date-of-creation: 2023-07-03
date-last-updated: 2023-07-05
description: Tổng quan về mục tiêu nghiệp vụ và yêu cầu nghiệp vụ của đồ án
---

# DA#3 - Overview

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
  
Một ngày, một bệnh viện có thể sẽ có hàng trăm bệnh nhân, sau khi khám xong bệnh nhân sẽ có các đơn thuốc, lịch hẹn tái khám, giấy giới thiệu sang bệnh viện khác, quá trình điều trị, ... Do thời gian hạn chế, bệnh nhân không muốn chờ đợi nên họ mong muốn được đặt hẹn khám bệnh để khi đến bệnh viện có thể giảm tối đa thời gian chờ đợi ở bệnh viện

==> Chưa rõ là bệnh viện hay phòng khám

## 2. Users

### 2.1. Quản trị viên (Admin)

- Người dùng có quyền hạn cao nhất của ứng dụng
- Có thể sử dụng tất cả chức năng mà ứng dụng cung cấp

Các tính năng nổi bật: Quản lý (thay đổi) nhân sự, lịch trình, thủ tục, thông tin hành chính, ...

Loại tài khoản này thường được cấp cho chủ sở hữu phòng khám, hoặc quản lý cấp cao

### 2.2. Nhân viên (Staff)

- Người dùng sử dụng được hầu hết chức năng mà ứng dụng cung cấp, trừ các tính năng liên quan tới quản lý

Các tính năng nổi bật:

- Sắp xếp lịch hẹn giữa bệnh nhân và nha sĩ
- Theo dõi các yêu cầu hẹn từ bệnh nhân

Loại tài khoản này thường được cấp cho lễ tân phòng khám.

### 2.3. Nha sĩ (Dentist)

- Người dùng có quyền hạn chế nhất ứng dụng

Các tính năng nổi bật: Chỉnh sửa thông tin bệnh án, sơ đồ nha chu, tình trạng răng hàm, hồ sơ điều trị của bệnh nhân

Loại tài khoản này thường được cấp cho nha sĩ phòng khám

### 2.4. Bệnh nhân (Patient)
  
Các thông tin của bệnh nhân nằm rải rác ở phần [3. Business Requirements](#3-business-requirements-chưa-phân-loại-người-dùng) => Sẽ cập nhật riêng ra một doc mới.

## 3. Business Requirements (chưa phân loại người dùng)

- Đăng nhập, đăng xuất

### 3.1. Quản lý hồ sơ bệnh nhân:

- Đối tượng người dùng cho phép: Quản trị viên (admin), nhân viên (Staff), nha sĩ (Dentist)
- Xem danh sách bệnh nhân
- Thêm/cập nhật bệnh nhân
- Hồ sơ chi tiết bệnh nhân:
  - Thông tin cơ bản của bệnh nhân như tên, tuổi, giới tính, ...
  - Tổng tiền điều trị đã thanh toán
  - Thông tin tổng quan về sức khỏe răng miệng của bệnh nhân
  - Ghi chú về tình trạng dị ứng
  - Ghi chú về chống chỉ định thuốc của bệnh nhân
  - **Thông tin về kế hoạch điều trị, thông tin thanh toán của bệnh nhân:**
    - Thêm/xóa/cập nhật thông tin chống chỉ định thuốc của bệnh nhân
    - Cập nhật thông tin tình trạng sức khỏe răng miệng của bệnh nhân: Các bác sĩ có thể cập nhật thông tin tổng quan về tình trạng sức khỏe răng miệng của bệnh nhân vào hồ sơ chi tiết của bệnh nhân trong phần sức khỏe răng miệng.
    - Xem/thêm/cập nhật các kế hoạch điều trị của bệnh nhân:
      - Các bác sĩ có thể xem được danh sách các kế hoạch điều trị của bệnh nhân.
      - Hiển thị thông tin chi tiết của kế hoạch điều trị:
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
    - Lên kế hoạch điều trị của bệnh nhân: Gồm 3 bước:
      1. Chọn liệu trình (Treatment selection)
      2. Chọn danh mục điều trị
      3. Chọn răng

      - Tại bước chọn liệu trình, nhân viên sẽ thực hiện:
        - Chọn ngày điều trị
        - Chọn bác sĩ thực hiện
        - Trợ khám (nếu có)
        - Chọn danh mục điều trị
      - Sau khi chọn danh mục điều trị, phần mềm sẽ hiển thị tiếp các mã điều trị nằm trong danh mục đó để người dùng lựa chọn.
      - Tại bước chọn răng, người dùng chọn bằng cách tích vào răng đó -> chọn bề mặt răng cần điều trị. Các bề mặt răng như sau (các chi tiết không quan trọng)
        - Mặt trong (Lingual - L)
        - Mặt ngoài (Facial - F)
        - Mặt xa (Distal - D)
        - Mặt gần (Mesial - M)
        - Mặt đỉnh (Top - T)
        - Mặt chân răng (Root - R)
      - Sau khi lựa chọn đủ thông tin, nhấn hoàn tất
      - Người dùng có thể cập nhật lại thông tin điều trị này
    - Tại hồ sơ bệnh nhân, các nha sĩ có thể xem được danh sách các thanh toán của bệnh nhân bao gồm:
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
        - Nếu bệnh nhân thanh toán tiền mặt, nhân viên (Staff) sẽ cập nhật vào mục thanh toán trong hồ sơ bệnh nhân
      - Thêm/xóa/cập nhật đơn thuốc của bệnh nhân: Đối tượng người dùng cho phép: quản trị viên, nhân viên, nha sĩ
  
### 3.2. Quản lí cuộc hẹn

- Xem các cuộc hẹn trong từng ngày (đối tượng người dùng cho phép: quản trị viên, nhân viên, nha sĩ)
- Gồm các thông tin:
  - Thời gian hẹn
  - Tên bệnh nhân
  - Hẹn nha sĩ nào
  - Trợ khám nào
  - Phòng
  - Tình trạng (cuộc hẹn mới/tái khám)
- Nhân viên mới được quyền thêm/điều chỉnh/xóa cuộc hẹn
- Nha sĩ chỉ được phép xem thông tin cuộc hẹn (read-only)
- Lọc các cuộc hẹn trong ngày (Đối tượng người dùng cho phép: quản trị viên, nhân viên, nha sĩ)
  - **Lọc theo bệnh nhân (tên)**
  - **Lọc theo phòng khám** [^1]
  [^1]: Cần xem lại chỗ này vì chưa rõ là quản lí nhiều phòng khám hay chỉ 1 phòng khám
  - **Lọc các cuộc hẹn của riêng nha sĩ**: Nha sĩ có thể lựa chọn lọc các cuộc hẹn mà mình chịu trách nhiệm
- Thêm/xem/xóa/sửa các yêu cầu hẹn từ bệnh nhân (Đối tượng người dùng cho phép: quản trị viên, nhân viên)
  - Hiển thị: Tên bệnh nhân, ngày hẹn được yêu cầu, ghi chú và thời gian yêu cầu được gửi
  - Thêm mới: **cần tạo hồ sơ bệnh nhân**: ID, họ tên, sdt, email, địa chỉ, ngày sinh,...
  - Cập nhật trên bệnh nhân cũ:
    - Có thể mặc định lựa chọn bác sĩ mặc định nếu bác sĩ rảnh vào thời gian đó, không thì bác sĩ mới
    - Hệ thống hỗ trợ tự động tìm kiếm ngày làm việc gần nhất của nha sĩ mặc định của bệnh nhân
- **Mỗi nha sĩ có lịch làm việc riêng** => Chỉ hiển thị các bác sĩ có lịch làm việc trong thời gian bệnh nhân muốn hẹn
- Khi thay đổi ngày hẹn thì danh sách nha sĩ được chọn cũng sẽ được cập nhật
- Có thể xem danh sách các tái khám liên kết của bệnh nhân
- Thông tin mỗi tái khám bao gồm: 
  - Ngày chỉ định
  - Mã
  - Ghi chú.
- Nếu bệnh nhân tới tái khám thì cần xác nhận liên kết tái khám.

### 3.3 Quản lý dữ liệu hệ thống

- Xem danh sách nha sĩ (Đối tượng người dùng cho phép: quản trị viên, nhân viên, nha sĩ)
- Thêm/Cập nhật thông tin nha sĩ (Đối tượng người dùng cho phép: quản trị viên)
- Xem danh sách nhân viên (Đối tượng người dùng cho phép: quản trị viên, nhân viên, nha sĩ)
- Thêm/Cập nhật thông tin nhân viên (Đối tượng người dùng cho phép: quản trị viên)
- Xem danh sách nha sĩ và lịch trình làm việc tương ứng (Đối tượng người dùng cho phép: quản trị viên, nhân viên, nha sĩ):
  - Lịch trình làm việc theo ngày riêng lẻ, tuần, tháng
  - Lịch theo tháng cho biết những ngày trong tháng có thể làm việc
  - Lịch theo tuần đơn vị là mỗi thứ trong tuần
  - Lịch theo ngày riêng lẻ đơn vị là các ngày cụ thể
  - Trong mỗi ngày có thời gian có thể khám, thời gian không thể khám
  - Lễ tân, nhân viên (Staff) dựa vào lịch này để đặt lịch hẹn cho bệnh nhân
- Chỉ có quản trị viên mới có quyền thêm lịch làm việc cho nha sĩ
- Quản lý thuốc:
  - Xem danh sác thuốc (Đối tượng người dùng cho phép: quản trị viên, nhân viên, nha sĩ)
  - Thêm/cập nhật/xóa thuốc (Đối tượng người dùng cho phép: quản trị viên)
- Thống kê:
  - Báo cáo các điều trị từ ngày trong ngày, theo từng bác sĩ
  - Báo cáo các cuộc hẹn từ ngày đến ngày, theo từng bác sĩ
