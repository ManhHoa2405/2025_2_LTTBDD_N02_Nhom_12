# SỔ THU CHI (EXPENSE TRACKER APP)

Đồ án môn học: **Lập trình cho thiết bị di động**  
Trường: **Đại học Phenikaa (Khoa Công nghệ thông tin)**

---

## Thông Tin Nhóm & Tác Giả
* **Giảng viên hướng dẫn:** ThS. Nguyễn Xuân Quế
* **Nhóm:** Nhóm 12
* **Sinh viên thực hiện:** Nguyễn Mạnh Hòa 
* **Mã sinh viên:** 23010254
* **Lớp:** Lập trình thiết bị di động

---

## Giới Thiệu Dự Án
**Sổ Thu Chi** là một ứng dụng di động đơn giản, trực quan giúp người dùng cá nhân ghi chép, theo dõi và quản lý các khoản chi tiêu hàng ngày một cách hiệu quả ngay trên thiết bị smartphone. Ứng dụng hoạt động hoàn toàn offline, đảm bảo tốc độ phản hồi tức thì và bảo mật dữ liệu cá nhân.

---

## Các Tính Năng Chính
* **Quản lý thu chi (CRUD):** Thêm mới, chỉnh sửa và xóa các khoản chi tiêu dễ dàng.
* **Tính toán tự động:** Tự động cộng dồn và hiển thị tổng số tiền đã chi tiêu theo thời gian thực (Real-time).
* **Đa ngôn ngữ (Localization):** Hỗ trợ chuyển đổi ngôn ngữ toàn bộ giao diện giữa **Tiếng Việt** và **Tiếng Anh** chỉ với một thao tác chạm.
* **Điều hướng mượt mà:** Sử dụng thanh điều hướng (`BottomNavigationBar`) kết hợp `IndexedStack` giúp giữ nguyên trạng thái cuộn trang khi chuyển đổi giữa các tab.
* **Lưu trữ Offline:** Dữ liệu được lưu trữ an toàn ngay trên bộ nhớ thiết bị, không bị mất khi đóng ứng dụng.

---

## Công Nghệ Sử Dụng
* **Framework:** Flutter
* **Ngôn ngữ:** Dart
* **Cơ sở dữ liệu cục bộ:** [Hive] & `hive_flutter` (NoSQL Database siêu nhẹ và tốc độ cao).
* **Quản lý trạng thái (State Management):** `setState` cơ bản kết hợp truyền tham số qua Widget.

---
