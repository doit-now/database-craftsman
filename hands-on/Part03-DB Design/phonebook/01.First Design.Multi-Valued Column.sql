CREATE DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK

CREATE TABLE PhoneBookV1
(
   Nick nvarchar(30),
   Phone varchar(50)
)   -- 3 số phone gom vào 1 cột

SELECT * FROM PhoneBookV1
INSERT INTO PhoneBookV1 VALUES(N'hoangnt', '098x')
-- An có 2 số phone, làm sao lưu?
INSERT INTO PhoneBookV1 VALUES(N'annguyen', '090x, 091x')

-- Bình có 3 số phone, làm sao lưu? mày ko thấy tao để độ rộng
-- phone 50 à
INSERT INTO PhoneBookV1 VALUES(N'binhle', '090x ; 091x ; 092x')

--***** PHÂN TÍCH:
-- >>>>> ƯU ĐIỂM: SELECT PHONE LÀ RA ĐC TẤT CẢ CÁC SỐ DI ĐỘNG

-- >>>>> Cho tui biết số để bàn, ở nhà của anh binhle??? toang
-- >>>>> Đáp án: quy ước số đầu tiên là để bàn, số 2 là di động, 3 work
-- >>>>> khốn nạn vì quy ước ngầm, số nào là loại nào!!! khó nhớ cho
--       người nhập liệu
-- >>>>> In cho tui số di động của mọi người???   

INSERT INTO PhoneBookV1 VALUES(N'binhle', '090x | 091x | 092x')
INSERT INTO PhoneBookV1 VALUES(N'cuongvo', '090x, 091x, 092x')
INSERT INTO PhoneBookV1 VALUES(N'dungpham', '090x-091x - 092x')
-- >>>>> tiêu chí cắt chuỗi - DELIMITER DẤU PHÂN CÁCH KO NHẤT QUÁN
-- >>>>> quy ước ngầm về nhập dấu phân cách

-- đếm xem mỗi người có bao nhiêu số phone!!! COUNT() QUÁ QUEN
-- dấu phân cách khó khăn cho cắt để count!!!

-- KHÓ KHĂN XẢY RA KHI TA GOM NHIỀU VALUE CÙNG KIỂU, NGỮ NGHĨA VÀO 
-- TRONG 1 COLUMN (cột Phone lưu nhiều số phone cách nhau dấu cách)
-- gây khó khăn cho nhập dữ liệu (ko nhất quán dấu cách), khi select
-- count() thống kê theo tiêu chí (in số phone ở nhà)
-- update thêm phone mới, xóa số cũ, 

-- MỘT CELL MÀ CHỨA NHIỀU VALUE CÙNG KIỂU, ĐC GỌI LÀ CỘT ĐA TRỊ
-- MULTI-VALUED COLUMN -> TIỀM ẨN NHIỀU KHÓ KHĂN CHO VIỆC XỬ LÍ DATA

-- NẾU 1 TABLE CÓ CỘT ĐA TRỊ NGƯỜI TA NÓI RẰNG NÓ ÉO ĐẠT CHUẨN 1
-- LEVEL THIẾT KẾ CHÁN QUÁ - 1ST NORMALIZATION

-- CHUẨN 1, CHẤT LƯỢNG THIẾT KẾ TÍNH TỪ 1, 2, 3, ...

-- THIẾT KẾ KÉM THÌ PHẢI NÂNG CẤP, KO CHƠI ĐA TRỊ NỮA!!!
-- KO CHƠI GOM VALUE TRONG 1 CELL
-- 2 CHIẾN LƯỢC FIX
-- CHIỀU NGANG (thêm cột), CHIỀU DỌC (thêm dòng!!!!!)*****




