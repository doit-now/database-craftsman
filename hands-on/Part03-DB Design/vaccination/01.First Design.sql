-- THIẾT KẾ ĐẦU TIÊN: GOM TẤT CẢ TRONG 1 TABLE
-- Đặc điểm chính là cột, value đđ chính là cell
-- Thông tin chích ngừa bao gồm: tên: An Nguyễn, cccd: 1234567789.., 

CREATE DATABASE DBDESIGN_VACCINATION
USE DBDESIGN_VACCINATION

CREATE TABLE VaccinationV1
(
	ID char(11) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10),  --sort heng, FullName là sort họ đó
	Phone varchar(11) NOT NULL UNIQUE, --constraint, cấm trùng nhưng hok là PK
	                                   --key ứng viên, candidate key
	InjectionInfo nvarchar(255) 
)
--cách thiết kế này lưu trữ các mũi chích của mình đc ko? - ĐƯỢC
SELECT * FROM VaccinationV1

INSERT INTO VaccinationV1 
   VALUES('00000000001', N'NGUYỄN', N'AN', '090X', N'AZ Ngày 28.9.2021 ĐH FPT | AZ Ngày 28.10.2021 BV LÊ VĂN THỊNH, Q. TĐ')

--PHÂN TÍCH:
--ƯU   : DỄ LƯU TRỮ, SELECT, CÓ NGAY, đa trị tốt trong vụ này!!!
--NHƯỢC: THỐNG KÊ ÉO ĐC, ÍT NHẤT ĐI CẮT CHUỖI, CĂNG !!!  BỊ CĂNG DO ĐA TRỊ

--SOLUTION: CẦN QUAN TÂM THỐNG KÊ, TÍNH TOÁN SỐ LIỆU (? MŨI, AZ CÓ BAO NGƯỜI...)
--TÁCH CỘT, TÁCH BẢNG
CREATE TABLE VaccinationV2
(
	ID char(11) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10),  --sort heng, FullName là sort họ đó
	Phone varchar(11) NOT NULL UNIQUE, --constraint, cấm trùng nhưng hok là PK
	                                   --key ứng viên, candidate key
	Dose1 nvarchar(100), --AZ, Astra, Astra.... 25.9.2021, DH FPT - COMPOSITE (phức hợp)
	Dose2 nvarchar(100)  --AZ, AZ, .....
)
--PHÂN TÍCH:
--*ƯU   : gọn gàng, select gọn gàng
--*NHƯỢC: NULL!!!, THÊM MŨI NHẮC 3, 4 HÀNG NĂM THÌ SAO???
--        CHỈ VÌ VÀI NGƯỜI, MÀ TA PHẢI CHỪA CHỖ NULL
--        THỐNG KÊ!!! CỘT COMPOSITE CHƯA CHO MÌNH ĐC THỐNG KÊ


-- MULTI-VALUED CELL : MỘT CELL CHỨA NHIỀU INFO ĐỘC LẬP BÌNH ĐẲNG VỀ NGỮ NGHĨA
--               Ví dụ: Address: 1/1 LL, Q.1, TP.HCM ; 1/1 Man Thiện, P.5, TP.TĐ
--                           thường trú                  tạm trú 
--               GÓI COMPO, NHIỀU ĐỒ TRONG 1 CELL
--               ĐỌC: CÓ 2 ĐỊA CHỈ

-- COMPOSITE VALUE CELL: Một value duy nhất, mỗi value này gom nhiều miếng nhỏ hơn
--                       nhiều miếng nhỏ hơn, mỗi miếng có 1 vai trò riêng
--                       gom chung lại thành 1 thứ khác
--                       Address: 1/1 Man Thiện, P.5, TP.HCM    
--                       FullName: Hoàng  Ngọc Trinh -> cả: tên gọi đầy đủ
--                                 first  last  midd 

--VÌ SỐ LẦN CHÍCH CÒN CÓ THỂ GIA TĂNG CHO TỪNG NGƯỜI, MŨI 2, MŨI NHẮC, MŨI THƯỜNG NIÊN
--AI CHÍCH NHIỀU THÌ NHIỀU DÒNG, HAY HƠN HẲN

CREATE TABLE PersonV3
(
	ID char(11) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10),  --sort heng, FullName là sort họ đó
	Phone varchar(11) NOT NULL UNIQUE, --constraint, cấm trùng nhưng hok là PK	
)

--COMPOSITE GỘP N INFO VÀO TRONG 1 CELL, DỄ, NHANH LÀ ƯU ĐIỂM, NHẬP 1 CHUỖI DÀI LÀ XONG
--               NHƯỢC ĐIỂM: ÉO THÔNG KÊ TỐT, ÉO SORT ĐC
--                           FullName sort làm sao
--COMPOSITE SẼ TÁCH CỘT, VÌ MÌNH ĐÃ CỐ TRƯỚC ĐÓ GOM N THỨ KHÁC NHAU ĐỂ LÀM RA 1 THỨ KHÁC 
--               TÁCH CỘT TRẢ LẠI ĐÚNG NGỮ NGHĨA CHO TỪNG THẰNG

CREATE TABLE VaccinationV3
(                                   --key ứng viên, candidate key
	Dose nvarchar(100), --AZ, Astra, Astra.... 25.9.2021, DH FPT - COMPOSITE (phức hợp)	
	PersonID char(11) REFERENCES PersonV3(ID)
)
--PHÂN TÍCH:
--ƯU   : CHÍCH THÊM NHÁT NÀO, THÊM DÒNG NHÁT ĐÓ, CHẤP 10 MŨI ĐỦ CHỖ LƯU, KO ẢNH HƯỞNG NGƯỜI CHƯA CHÍCH
--NHƯỢC: THỐNG KÊ ÉO ĐC
-- COMPOSITE TÁCH TIẾP THÀNH CỘT CỘT CỘT CỘT CỘT CỘT CỘT, TRẢ LẠI ĐÚNG Ý NGHĨA CHO TỪNG M
-- MIẾNG INFO NHỎ

CREATE TABLE PersonV4
(
	ID char(11) PRIMARY KEY,
	LastName nvarchar(30),
	FirstName nvarchar(10),  --sort heng, FullName là sort họ đó
	Phone varchar(11) NOT NULL UNIQUE, --constraint, cấm trùng nhưng hok là PK	
)

CREATE TABLE VaccinationV4
(                                   --key ứng viên, candidate key
	--Dose nvarchar(100), --AZ, Astra, Astra.... 25.9.2021, DH FPT - COMPOSITE (phức hợp)	
	-- tách cột hoy
	Dose int, -- liều chích số 1
	InjDate datetime, --giờ chích
	Vaccine nvarchar(50), --tên vaccine
	Lot nvarchar(20), 
	[Location] nvarchar(50),
	PersonID char(11) REFERENCES PersonV4(ID)
)

INSERT INTO PersonV4 VALUES('00000000001', N'NGUYỄN', N'AN', '0901x')
INSERT INTO PersonV4 VALUES('00000000002', N'LÊ', N'BÌNH', '090X')
select * from PersonV4

INSERT INTO VaccinationV4 
  VALUES(1, GETDATE(), 'AZ', NULL, NULL, '00000000001')

SELECT * FROM VaccinationV4

--IN RA XANH VÀNG CHO MỖI NGƯỜI
SELECT * FROM PersonV4 p LEFT JOIN VaccinationV4 v
                    ON p.ID = v.PersonID  

SELECT p.id, p.FirstName, COUNT(*) AS 'No Doses' FROM PersonV4 p LEFT JOIN VaccinationV4 v
                    ON p.ID = v.PersonID 
					GROUP BY p.id, p.FirstName --CHẾT MẸ COUNT(*)
					                           --BÌNH CÓ 1 DÒNG KHA KHÁ NULL CHƯA CHÍCH


SELECT p.id, p.FirstName, COUNT(v.Dose) AS 'No Doses' FROM PersonV4 p LEFT JOIN VaccinationV4 v
                    ON p.ID = v.PersonID 
					GROUP BY p.id, p.FirstName 	
	
-- ĂN TIỀN XANH ĐỎ	
SELECT p.id, p.FirstName, IIF(COUNT(v.Dose) = 0, 'NOOP', 
                             IIF(COUNT(v.Dose) = 1, 'YELLOW', 'GREEN')) 
							 AS STATUS
							 
FROM PersonV4 p LEFT JOIN VaccinationV4 v
                    ON p.ID = v.PersonID 
					GROUP BY p.id, p.FirstName 	

-- AN NGUYỄN TỪ VÀNG THÀNH XANH KHI CÓ THÊM MŨI CHÍCH NÀY
INSERT INTO VaccinationV4 
  VALUES(2, GETDATE(), 'AZ', NULL, NULL, '00000000001')

