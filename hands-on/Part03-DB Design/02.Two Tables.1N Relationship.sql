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


CREATE TABLE MajorV2
(
	MajorID char(2) PRIMARY KEY, -- mặc định dbe tự tạo tên rb
	MajorName nvarchar(40) NOT NULL
	--...
)

DROP TABLE MajorV2

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
