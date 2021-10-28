CREATE DATABASE DBDESIGN_ONEMANY

USE DBDESIGN_ONEMANY

--TABLE 1 TẠO TRƯỚC, TABLE N TẠO SAU
CREATE TABLE MajorV1
(
	MajorID char(2) PRIMARY KEY, -- mặc định dbe tự tạo tên rb
	MajorName nvarchar(40) NOT NULL
	--...
)

--CHÈN DATA - MUA QUẦN ÁO BỎ VÔ TỦ
INSERT INTO MajorV1 VALUES ('SE', N'Kĩ thuật phần mềm')
INSERT INTO MajorV1 VALUES ('IA', N'An toàn thông tin')


DROP TABLE StudentV1
CREATE TABLE StudentV1
(
	StudentID char(8) NOT NULL,
	LastName nvarchar(40) NOT NULL,    
	FirstName nvarchar(10) NOT NULL,  
	DOB datetime NULL,
	Address nvarchar(50) NULL, 
	
	MajorID char(2)  -- tên cột khóa ngoại/tham chiếu ko cần trùng bên 1-Key
	             -- NHƯNG BẮT BUỘC TRÙNG 100% KIỂU DỮ LIỆU, CẦN THAM CHIẾU
				 -- DATA HOY

	CONSTRAINT PK_STUDENTV1 PRIMARY KEY (StudentID)
)

-- CHÈN DATA SINH VIÊN
SELECT * FROM STUDENTV1
SELECT * FROM MajorV1
INSERT INTO StudentV1 VALUES ('SE1', N'NGUYỄN', N'AN', NULL, NULL, 'SE')

-- THIẾT KẾ TRÊN SAI vì...KO CÓ THAM CHIẾU GIỮA MAJORID CỦA STUDENT VS. MAJOR PHÍA TRÊN
INSERT INTO StudentV1 VALUES ('SE2', N'LÊ', N'BÌNH', NULL, NULL, 'AH')

DROP TABLE MajorV2
CREATE TABLE MajorV2
(
	MajorID char(2) PRIMARY KEY, -- mặc định dbe tự tạo tên rb
	MajorName nvarchar(40) NOT NULL
	--...
)

DROP TABLE StudentV2
CREATE TABLE StudentV2
(
	StudentID char(8)  PRIMARY KEY,
	LastName nvarchar(40) NOT NULL,    
	FirstName nvarchar(10) NOT NULL,  
	DOB datetime NULL,
	Address nvarchar(50) NULL, 
	
	--MajorID char(2) REFERENCES MajorV2(MajorID)
	MajorID char(2) FOREIGN KEY REFERENCES MajorV2(MajorID) 
)   -- tớ chọn chuyên ngành ở trên kia kìa, xin tham chiếu trên kia

INSERT INTO MajorV2 VALUES ('SE', N'Kĩ thuật phần mềm')
INSERT INTO MajorV2 VALUES ('IA', N'An toàn thông tin')

INSERT INTO StudentV2 VALUES ('SE1', N'NGUYỄN', N'AN', NULL, NULL, 'SE')

-- THIẾT KẾ TRÊN SAI vì...KO CÓ THAM CHIẾU GIỮA MAJORID CỦA STUDENT VS. MAJOR PHÍA TRÊN
INSERT INTO StudentV2 VALUES ('SE2', N'LÊ', N'BÌNH', NULL, NULL, 'gd')

SELECT * FROM StudentV2

-- KO ĐC XÓA TABLE 1 NẾU NÓ ĐANG ĐC THAM CHIẾU BỞI THẰNG KHÁC
-- NẾU CÓ MỐI QUAN HỆ 1-N, XÓA N TRƯỚC RỒI XÓA 1 SAU

-------------------------------------------------------------
-- THÊM KĨ THUẬT VIẾT FK, Y CHANG CÁCH VIẾT CỦA PK


DROP TABLE MajorV3
CREATE TABLE MajorV3
(
	MajorID char(2) PRIMARY KEY, -- mặc định dbe tự tạo tên rb
	MajorName nvarchar(40) NOT NULL
	--...
)

DROP TABLE StudentV3

/*
CREATE TABLE StudentV3
(
	StudentID char(8)  PRIMARY KEY,
	LastName nvarchar(40) NOT NULL,    
	FirstName nvarchar(10) NOT NULL,  
	DOB datetime NULL,
	Address nvarchar(50) NULL, 
	
	MajorID char(2),
	CONSTRAINT FK_StudentV3_MajorV3 
	           FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID) 
)
*/

CREATE TABLE StudentV3
(
	StudentID char(8)  PRIMARY KEY,
	LastName nvarchar(40) NOT NULL,    
	FirstName nvarchar(10) NOT NULL,  
	DOB datetime NULL,
	Address nvarchar(50) NULL, 
	
	MajorID char(2) DEFAULT 'SE',
	CONSTRAINT FK_StudentV3_MajorV3 
	           FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID) 
			   ON DELETE SET DEFAULT
			   ON UPDATE CASCADE
)

-- CHO SV KO CHỌN CHUYÊN NGÀNH, HẮN HỌC GÌ??? HỌC SE ĐẤY

INSERT INTO StudentV3(StudentID, LastName, FirstName) 
               VALUES ('SE2', N'PHẠM', N'BÌNH')

--ALTER TABLE STUDENTV3 ADD CONSTRAINT... Ở TRÊN DONE


--// TA CÓ QUYỀN GỠ MỘT RÀNG BUỘC ĐÃ THIẾT LẬP!!!

ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3 

-- BỔ SUNG LẠI 1 RÀNG BUỘC KHÁC
--ALTER TABLE StudentV7 ADD CONSTRAINT PK_STUDENTV7 PRIMARY KEY (StudentID)

ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 
	           FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID) 


SELECT * FROM MAJORV3  --RỖNG
SELECT * FROM StudentV3 -- RỖNG

-- INSERT LÀ CHẾT, DO THAM CHIẾU KO TỒN TẠI
INSERT INTO StudentV3 VALUES ('SE1', N'NGUYỄN', N'AN', NULL, NULL, 'SE')

INSERT INTO MajorV3 VALUES ('SE', N'Kĩ thuật phần mềm')

INSERT INTO MajorV3 VALUES ('AH', N'Ahihi Đồ Ngok')

INSERT INTO StudentV3 VALUES ('AH1', N'LÊ', N'VUI VẺ', NULL, NULL, 'AH')

-- THAO TÁC MẠNH TAY TRÊN DATA/MÓN ĐỒ QUẦN ÁO TRONG TỦ - DML (UPDATE & DELELE)
DELETE FROM StudentV3 -- CỰC KÌ NGUY HIỂM KHI THIẾU WHERE, XÓA HẾT DATA!!!

DELETE FROM StudentV3 WHERE StudentID = 'ah1'

DELETE FROM MajorV3 WHERE MajorID = 'AH'

SELECT * FROM MAJORV3  --RỖNG
SELECT * FROM StudentV3 -- RỖNG

-- GÀI THÊM HÀNH XỬ KHI XÓA, SỬA DATA Ở RÀNG BUỘC KHÓA NGOẠI/DÍNH KHÓA CHÍNH LUÔN
-- HIỆU ỨNG DOMINO, SỤP ĐỔ DÂY CHUYỀN, 1 XÓA, N ĐI SẠCH  >>>>> CASCADE DELETE
--                                     1 SỬA, N BỊ SỬA THEO >>>>> CASCADE UPDATE

-- NGAY LÚC DESIGN TABLE/CREATE TABLE ĐÃ PHẢI TÍNH VỤ NÀY RỒI
-- VẪN CÓ THỂ SỬA SAU NÀY KHI CÓ DATA, CÓ THỂ CÓ TROUBLE
-- CỤM LỆNH: CREATE / ALTER / DROP

ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3  -- XÓA RB KHÓA NGOẠI BỊ THIẾU
--VIỆC GÀI THÊM RULE NHỎ LIÊN QUAN XÓA SỬA DATA

ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 
	           FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID) 
			   ON DELETE CASCADE
			   ON UPDATE CASCADE

-- UPDATE DML, MẠNH MẼ, SỬA DATA ĐANG CÓ
UPDATE MajorV3 SET MajorID = 'AK' --CẨN THẬN NẾU KO CÓ WHERE, TOÀN BỘ TABLE BỊ ẢNH HƯỞNG
                                  --TRỪ UPDATE CỘT KEY
UPDATE MajorV3 SET MajorID = 'AK' WHERE MajorID = 'AH'

--SỤP ĐỔ, XÓA 1, N ĐI SẠCH SẼ
--XÓA CHUYÊN NGÀNH AHIHI, XEM SAO??? CÒN SV NÀO HOK
DELETE FROM MajorV3 WHERE MajorID = 'AH'
DELETE FROM MajorV3 WHERE MajorID = 'AK'  -- SV AH1 LÊN ĐƯỜNG LUÔN

-- CÒN 2 CÁI GÀI NỮA LIÊN QUAN ĐẾN TÍNH ĐỒNG BỘ NHẤT QUÁN DATA/CONSISTENCY
-- SET NULL VÀ DEFAULT
-- KHI 1 XÓA, N VỀ NULL
-- KHI 1 XÓA, N VỀ DEFAULT

SELECT * FROM MAJORV3  --RỖNG
SELECT * FROM StudentV3 -- RỖNG

--***** CHỐT HẠ
-- XÓA BÊN 1 TỨC LÀ MẤT BÊN 1, KO LẼ SỤP ĐỔ CẢ ĐÁM BÊN N, KO HAY, NÊN CHỌN ĐƯA BÊN N VỀ NULL
-- UPDATE BÊN 1, BÊN 1 VẪN CÒN GIỮ DÒNG/ROW, BÊN N NÊN ĐỒNG BỘ THEO, ĂN THEO, CASCADE

ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3  -- XÓA RB KHÓA NGOẠI BỊ THIẾU
--VIỆC GÀI THÊM RULE NHỎ LIÊN QUAN XÓA SỬA DATA

ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 
	           FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID) 
			   ON DELETE SET NULL -- XÓA CHO MỒ CÔI, BƠ VƠ, NULL, TỪ TỪ TÍNH
			   ON UPDATE CASCADE  -- SỬA BỊ ẢNH HƯỞNG DÂY CHUYỀN

-- CHO SV BƠ VƠ CHUYÊN NGÀNH VỀ HỌC SE
UPDATE StudentV3 SET MajorID = 'SE' -- TOÀN TRƯỜNG HỌC SE ẤY, TOANG
UPDATE StudentV3 SET MajorID = 'SE' 
                WHERE StudentID = 'AH1' -- ĐÚNG

UPDATE StudentV3 SET MajorID = 'SE' 
                WHERE MajorID IS NULL