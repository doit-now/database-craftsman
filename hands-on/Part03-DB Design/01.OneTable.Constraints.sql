--PHẦN NÀY THÍ NGHIỆM CÁC LOẠI RÀNG BUỘC - CONSTRAINTS - QUY TẮC GÀI TRÊN DATA

--1. RÀNG BUỘC PRIMARY KEY
-- tạm thời chấp nhận PK là 1 cột (tương lai có thể nhiều cột) mà giá trị
-- của nó trên mọi dòng/mọi cell của cột này ko trùng lại, mục đích dùng để
-- WHERE ra đc 1 dòng duy nhất
-- VALUE CỦA KEY CÓ THỂ ĐC TẠO RA THEO 2 CÁCH
-- CÁCH 1: TỰ NHẬP = TAY, DB ENGINE SẼ TỰ KIỂM TRA GIÙM MÌNH CÓ TRÙNG HAY KO?
--          NẾU TRÙNG DB ENGINE TỰ BÁO VI PHẠM PK CONSTRAINT - HỌC RỒI UI/UX

-- CÁCH 2: ÉO CẦN NHẬP = TAY CÁI VALUE CỦA PK, MÁY/DB ENGINE TỰ GENERATE CHO 
--         MÌNH 1 CON SỐ KO TRÙNG LẠI!!!!!! CON SỐ TỰ TĂNG, CON SỐ HEXA...
--
-- THỰC HÀNH
-- Thiết kế table lưu thông tin đăng kí event nào đó (giống đk qua Google Form)
-- thông tin cần lưu trữ: số thứ tự đăng kí, tên full name, email, 
-- ngày giờ đăng kí, số di động...
-- * Phân tích:
-- ngày giờ đki: ko bắt nhập, default
-- số thứ tự: nhập vào là bậy rồi!!! tự gán chứ!!!
-- email, phone: ko cho trùng heng, 1 email 1 lần đk
-- ...
USE DBDESIGN_ONETABLE

/*
CREATE TABLE Registration 
(
	SEQ int PRIMARY KEY, -- PHẢI TỰ NHẬP SỐ THỨ TỰ, VỚ VẨN
	FirstName nvarchar(10),
	LastName nvarchar(30),
	Email varchar(50),  -- CẤM TRÙNG LÀM SAO???
	Phone varchar(11),
	RegDate datetime DEFAULT GetDate() -- CONSTRAINT DEFAULT
)
*/
CREATE TABLE Registration 
(
	SEQ int PRIMARY KEY IDENTITY, -- PHẢI TỰ NHẬP SỐ THỨ TỰ, VỚ VẨN
	                              -- mặc định đi từ 1, nhảy ++ cho người sau
								  -- ghi rõ IDENTITY(1, 1)
								  -- IDENTITY(1, 5), từ 1, 6, 11, ...
	FirstName nvarchar(10),
	LastName nvarchar(30),
	Email varchar(50),  -- CẤM TRÙNG LÀM SAO???
	Phone varchar(11),
	RegDate datetime DEFAULT GetDate() -- CONSTRAINT DEFAULT
)
--ĐĂNG KÍ EVENT
INSERT INTO Registration VALUES (N'An', N'Nguyễn', 'an@...', '090x') 
--báo lỗi map đc các cột rõ ràng

INSERT INTO Registration VALUES (N'An', N'Nguyễn', 'an@...', '090x', null) 
SELECT * FROM Registration

INSERT INTO Registration(FirstName, LastName, Email, Phone) 
               VALUES (N'Bình', N'Lê', 'binh@...', '091x') 

-- XÓA 1 DÒNG CÓ AUTO GENERATED KEY, THÌ TABLE SẼ LỦNG SỐ, DB ENGINE KO LẤP CHỖ LỦNG
-- 1 2 3 4 5 6, XÓA 3, CÒN 1 2 4 5 6, ĐĂNG KÍ TIẾP TÍNH TỪ 7
