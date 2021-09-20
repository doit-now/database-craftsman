USE Northwind

---------------------------------------------------------------
-- LÍ THUYẾT
-- MỘT DB là nơi chứa data (bán hàng, thư viện, qlsv,...)
-- DATA đc lưu dưới dạng TABLE, tách thành nhiều TABLE (nghệ thuật design db, NF)
-- Dùng lệnh SELECT để xem/in dữ liệu từ table, cx hiển thị dưới dạng table
-- CÚ PHÁP CHUẨN: SELECT * FROM <TÊN-TABLE>
--                       * đại diện cho việc tui mún lấy all of columns  
-- CÚ PHÁP MỞ RỘNG:
--                SELECT TÊN-CÁC-CỘT-MUỐN-LẤY, CÁCH-NHAU-DẤU-PHẨY FROM <TÊN-TABLE>  

--                SELECT CÓ THỂ DÙNG CÁC HÀM XỬ LÍ CÁC CỘT ĐỂ ĐỘ LẠI THÔNG TIN HIỂN THỊ
--                FROM <TÊN-TABLE>  
-- Khi ta SELECT ít cột từ table gốc thì có nguy cơ dữ liệu sẽ bị trùng lại
-- Ko phải ta bị sai, ko phải người thiết kế table và người nhập liệu bị sai
-- Do chúng ta có nhiều info trùng nhau/đặc điểm trùng nhau, nên nếu chỉ tập trung vào data này
-- trùng nhau chắc chắn xảy ra
-- 100 triệu người dân VN đc quản lí info bao gồm: ID, Tên, DOB,.... Tỉnh thành sinh sống
--                                                 <>                        63 tỉnh
--                                                 <>                        63 tỉnh
-- LỆNH SELECT HỖ TRỢ LOẠI TRỪ DÒNG TRÙNG NHAU/TRÙNG 100%
-- SELECT DISTINCT TÊN-CÁC-CỘT FROM <TÊN-TABLE>
---------------------------------------------------------------

--1. Liệt kê danh sách nhân viên
SELECT * FROM Employees
--Phân tích: 9 người nhưng chỉ có 4 title. ~~~~ 100 triệu dân VN chỉ 63 tỉnh
SELECT TitleOfCourtesy FROM Employees   --9 DANH XƯNG
SELECT DISTINCT TitleOfCourtesy FROM Employees   --CHỈ LÀ 4

SELECT DISTINCT EmployeeID, TitleOfCourtesy FROM Employees   --
-- NẾU DISTINCT ĐI KÈM VỚI ID/KEY, NÓ VÔ DỤNG, KEY SAO TRÙNG MÀ LOẠI TRỪ

--2. In ra thông tin khách hàng
SELECT * FROM Customers --92 rows

--3. Có bao nhiêu quốc gia xuất hiện trong thông tin k/h, in ra
SELECT Country FROM Customers  --92 rows

SELECT DISTINCT Country FROM Customers  --22 rows