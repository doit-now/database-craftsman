CREATE DATABASE DBDESIGN_ONETABLE
--CREATE DÙNG ĐỂ TẠO CẤU TRÚC LƯU TRỮ/DÀN KHUNG/THÙNG CHỨA DÙNG LƯU TRỮ DATA/INFO
--TƯƠNG ĐƯƠNG VIỆC XÂY PHÒNG CHỨA ĐỒ - DATABASE
--            MUA TỦ ĐỂ TRONG PHÒNG  - TABLE
--1 DB CHỨA NHIỀU TABLE - 1 PHÒNG CÓ NHIỀU TỦ
--                        1 NHÀ CÓ NHIỀU PHÒNG
--TẠO RA CẤU TRÚC LƯU TRỮ - CHƯA NÓI DATA BỎ VÀO - DDL (PHÂN NHÁNH CỦA SQL)

USE DBDESIGN_ONETABLE

--Tạo table lưu trữ hồ sơ sv: mã số (phân biệt các sv với nhau), tên, dob, địa chỉ...
--1 SV ~~~ 1 OBJECT ~~~ 1 ENTITY
--1 TABLE DÙNG LƯU TRỮ NHIỀU ENTITY
CREATE TABLE StudentV1
(
	StudentID char(8),
	LastName nvarchar(40),   --tại sao ko gộp fullname cho rồi???  
	FirstName nvarchar(10),  --n: lưu kí tự Unicode tiếng Việt
	DOB datetime,
	Address nvarchar(50)
)
--SQL Server | Oracle (Oracle/Java) | DB (IBM) | MySQL | PostgeSQL | SQLite | MS Access (Office)

-- THAO TÁC TRÊN DATA/MÓN ĐỒ TRONG TỦ/TRONG TABLE - DML/DQL (dành riêng cho SELECT)
select * from studentv1 --gõ thường okie
SELECT * FROM Studentv1 --gõ chuẩn 

-- ĐƯA DATA VÀO TABLE/MUA ĐỒ QUẦN ÁO BỎ VÀO TỦ
INSERT INTO StudentV1 VALUES('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh')  -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KO CHE THÔNG TIN

-- MỘT SỐ CỘT CHƯA THÈM NHẬP INFO, ĐƯỢC QUYỀN BỎ TRỐNG NẾU CỘT CHO PHÉP TRỐNG VALUE
-- DEFAULT KHI ĐÓNG CÁI TỦ/MUA TỦ/THIẾT KẾ TỦ, MẶC ĐỊNH NULL
INSERT INTO StudentV1 VALUES('SE123457', N'Lê', N'Bình', '2003-2-1', NULL)
-- TÊN THÀNH PHỐ LÀ NULL, WHERE = 'NULL' OKIE VÌ NÓ LÀ DATA
-- NULL Ở CÂU TRÊN WHERE ADDRESS IS NULL

INSERT INTO StudentV1 VALUES('SE123458', N'Võ', N'Cường', '2003-3-1', N'NULL')

-- TUI CHỈ MÚN LƯU VÀI INFO, KO ĐỦ SỐ CỘT, MIỄN CỘT CÒN LẠI CHO PHÉP BỎ TRỐNG
INSERT INTO StudentV1(StudentID, LastName, FirstName)
             VALUES('SE123459', N'Trần', N'Dũng')

INSERT INTO StudentV1(LastName, FirstName, StudentID)
             VALUES(N'Phạm', N'Em', 'SE123460')

INSERT INTO StudentV1(LastName, FirstName, StudentID)
             VALUES(NULL, NULL, NULL)

INSERT INTO StudentV1(LastName, FirstName, StudentID)
             VALUES(NULL, NULL, NULL)  -- SIÊU NGUY HIỂM, SV TOÀN INFO BỎ TRỐNG
			                           -- GÀI CÁCH ĐƯA DATA VÀO CÁC CỘT SAO CHO HỢP LÍ
									   -- CONSTRAINT TRÊN DATA/CELL/COLUMN 

SELECT * FROM Studentv1 

--CÚ NGUY HIỂM NÀY CÒN LỚN HƠN!!!!!!!!!!!!!!!!!!!!!!!
--TRÙNG MÃ SỐ KO CHẤP NHẬN ĐƯỢC, KO XĐ ĐC 1 SV -- GÀI RÀNG BUỘC DỮ LIỆU QUAN TRỌNG NÀY
--                                                CỘT MÀ VALUE CẤM TRÙNG TRÊN MỌI CELL CÙNG CỘT
--                                                DÙNG LÀM CHÌA KHÓA/KEY ĐỂ TÌM RA/MỞ RA/XĐ 
--                                                DUY NHẤT 1 INFO, DÒNG, 1 SV, 1 ENTITY, 1 OBJECT
--                                                CỘT NÀY ĐC GỌI LÀ PRIMARY KEY
INSERT INTO StudentV1(LastName, FirstName, StudentID)
             VALUES(N'Đỗ', N'Giang', 'SE123460')

SELECT * FROM StudentV1 WHERE StudentID = 'se123460'

--GÀI CÁCH ĐƯA DATA VÀO TABLE ĐỂ KO CÓ NHỮNG HIỆN TƯỢNG BẤT THƯỜNG, 1 DÒNG TRỐNG TRƠN, KEY TRÙNG
--KEY NULL - DEFAULT THIẾT KẾ CHO PHÉP NULL TẤT CẢ
--GÀI - CONSTRAINTS
CREATE TABLE StudentV2
(
	StudentID char(8) PRIMARY KEY, -- bao hàm luôn NOT NULL - bắt buộc đưa data, cấm trùng
	LastName nvarchar(40) NOT NULL,   --tại sao ko gộp fullname cho rồi???  
	FirstName nvarchar(10) NOT NULL,  --n: lưu kí tự Unicode tiếng Việt (* đỏ) registration/sign-up
	DOB datetime,
	Address nvarchar(50)
)

INSERT INTO StudentV2 VALUES('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh')  -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KO CHE THÔNG TIN

SELECT * FROM StudentV2

--thử coi qua mặt đc ko???
INSERT INTO StudentV2(StudentID, LastName, FirstName)
             VALUES(NULL, NULL, NULL) --gẫy

INSERT INTO StudentV2(StudentID, LastName, FirstName)
             VALUES('AHIHI', NULL, NULL) --gẫy

--coi có đc trùng mã số sv hay ko??? --gẫy luôn
INSERT INTO StudentV2 VALUES('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh')  -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KO CHE THÔNG TIN
-- thử tiếp PK
INSERT INTO StudentV2 VALUES('GD123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh')  -- ĐƯA HẾT VÀO CÁC CỘT, SV FULL KO CHE THÔNG TIN
SELECT * FROM StudentV2

INSERT INTO StudentV2 VALUES('SE123457', N'Lê', N'Bình', '2003-2-1', NULL) --OKIE

INSERT INTO StudentV1 VALUES('SE123458', N'Võ', N'Cường', NULL, NULL) -- OKIE

INSERT INTO StudentV2(StudentID, LastName, FirstName)
             VALUES('SE123459', N'Trần', N'Dũng')

INSERT INTO StudentV2
             VALUES(NULL, NULL, NULL, NULL, NULL)  -- GẪY 3 CHỖ NULL

CREATE TABLE StudentV3
(
	StudentID char(8) NOT NULL PRIMARY KEY, -- bao hàm luôn NOT NULL - bắt buộc đưa data, cấm trùng
	LastName nvarchar(40) NOT NULL,   --tại sao ko gộp fullname cho rồi???  
	FirstName nvarchar(10) NOT NULL,  --n: lưu kí tự Unicode tiếng Việt (* đỏ) registration/sign-up
	DOB datetime NULL,
	Address nvarchar(50) NULL -- thừa từ NULL, do default là vậy
)

CREATE TABLE StudentV4
(
	StudentID char(8) NOT NULL,
	LastName nvarchar(40) NOT NULL,   --tại sao ko gộp fullname cho rồi???  
	FirstName nvarchar(10) NOT NULL,  --n: lưu kí tự Unicode tiếng Việt (* đỏ) registration/sign-up
	DOB datetime NULL,
	Address nvarchar(50) NULL,             -- thừa từ NULL, do default là vậy
	PRIMARY KEY(StudentID)
)

--GENERATE TỪ ERD TRONG TOOL THIẾT KẾ
CREATE TABLE StudentV5 (
  StudentID char(8) NOT NULL, 
  LastName  varchar(50) NOT NULL, 
  FirstName varchar(10) NOT NULL, 
  PRIMARY KEY (StudentID)
)

SELECT * FROM StudentV5

INSERT INTO StudentV4 VALUES('SE123456', N'Nguyễn', N'An', '2003-1-1', N'... TP.Hồ Chí Minh') 
SELECT * FROM StudentV4

-- POWER DESIGNER VS. VISUAL PARADIGM 
--    ĐỨC-SAP

---------------------------------------------------------------------
-- HỌC THÊM VỀ CÁI CONSTRAINTS - TRONG ĐÓ PK CONSTRAINT
-- Ràng buộc là cách ta/db designer ép cell/cột nào đó value phải ntn
-- Đặt ra quy tắc/rule cho việc nhập data
-- Vì có nhiều quy tắc, nên tránh nhầm lẫn, dễ kiểm soát ta sẽ có quyền
-- đặt tên cho các quy tắc, constraint name
-- Ví dụ: Má ở nhà đặt quy tắc/nội quy cho mình
-- Rule #1: Vào SG học thật tốt nha con. Tốt: điểm tb >= 8.0 && ko rớt môn nào
--          && 9 học kì ra trường && ko đổi chuyên ngành
-- Rule #2: Tối đi chơi về nhà sớm. Sớm: trong tối cùng ngày, trước 10h khuya
-- Rule #3: ????
-- tên rb/quy tắc            nội dung/cái data đc gài vào
--   PK_?????                        PRIMARY KEY
-- Mặc định các DB Engine nó tự đặt tên cho các RB nó thấy khi bạn
-- gõ lệnh DDL
-- DB En cho mình cơ chế tự đặt tên RB
CREATE TABLE StudentV6
(
	StudentID char(8) NOT NULL,
	LastName nvarchar(40) NOT NULL,    
	FirstName nvarchar(10) NOT NULL,  
	DOB datetime NULL,
	Address nvarchar(50) NULL,            
	--PRIMARY KEY(StudentID) --tự db engine đặt tên cho rb
	CONSTRAINT PK_STUDENTV6 PRIMARY KEY (StudentID)
)

-- DÂN PRO ĐÔI KHI CÒN LÀM CÁCH SAU. NGƯỜI TA TÁCH HẲN VIỆC TẠO RB KHÓA CHÍNH, KHÓA NGOẠI
-- RA HẲN CẤU TRÚC TABLE, TỨC LÀ CREATE TABLE CHỈ CHỨA TÊN CẤU TRÚC - CỘT - DOMAIN
-- TẠO TABLE XONG RỒI CHỈNH SỬA TABLE - SỬA CÁI TỦ CHỨ KO PHẢI DATA TRONG TỦ

DROP TABLE StudentV7

CREATE TABLE StudentV7
(
	StudentID char(8) NOT NULL,
	LastName nvarchar(40) NOT NULL,    
	FirstName nvarchar(10) NOT NULL,  
	DOB datetime NULL,
	Address nvarchar(50) NULL,            
	--PRIMARY KEY(StudentID) --tự db engine đặt tên cho rb
	--CONSTRAINT PK_STUDENTV7 PRIMARY KEY (StudentID)
)

ALTER TABLE StudentV7 ADD CONSTRAINT PK_STUDENTV7 PRIMARY KEY (StudentID)

--XÓA 1 RÀNG BUỘC ĐC KO, ĐC, CHO ADD THÌ CHO DROP 
ALTER TABLE StudentV7 DROP CONSTRAINT PK_STUDENTV7

ALTER TABLE StudentV2 DROP CONSTRAINT PK__StudentV__32C52A7961A84D4E



