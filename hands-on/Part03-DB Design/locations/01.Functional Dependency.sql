CREATE DATABASE DBDESIGN_VNLOCATIONS

USE DBDESIGN_VNLOCATIONS

--Thiết kế csdl lưu đc thông tin phường/xã, quận/huyện, tỉnh/tp
--chính là 1 phần của địa chỉ đc tách ra cho nhu cầu thống kê
--nó là 1 phần của Composite field
--|SEQ|Dose|InjDate|Vacinne (FK LK)|Lot|Địa chỉ chích - compo|
--|SEQ|Dose|InjDate|Vacinne (FK LK)|Lot|Số nhà|Phường-Quận-Tỉnh|

--XÉT RIÊNG PHƯỜNG-QUẬN-TỈNH RÕ RÀNG 3 CỘT LOOKUP
CREATE TABLE Locations
(
	province nvarchar(30),
	district nvarchar(30),
	ward nvarchar(30)
)

select * from Locations


--PHÂN TÍCH TABLE
--1. TRÙNG LẶP CỤM INFO TỈNH-QUẬN

--2. LOOKUP TRÊN PROVINCE, DISTRICT (WARD)

--3. SỰ PHỤ THUỘC LOGIC GIỮA TỈNH VÀ DISTRICT (WARD)
--   FUNCTIONAL DEPENDENCY - FD - PHỤ THUỘC HÀM
--  CÓ 1 CÁI ÁNH XẠ, MỐI QUAN HỆ GIỮA A VÀ B, PROVINCE VS. DISTRICT
-- CỨ CHỌN TP.HCM -> Q1, Q2, Q3,...
--         ĐN     -> BH, LBT, LK,...

-- Y = F(X) = X^2, CỨ CHỌN F(2) -> 4

--TÁCH LOOKUP VÌ DỄ NHẤT
--RA 1 TABLE, PHẦN TABLE CÒN LẠI THÌ FK SANG LOOKUP

--Vaccination(liều, tên-vaccine) 
--                           FK sang Vaccine(tên-vaccine)


--CHỈ LOOKUP 63 TỈNH, KO CHO CHỌN LỘN XỘN

CREATE TABLE Province
(
	PName nvarchar(30) 
)

select * from PROVINCE
select * from Locations  --10581 dòng ứng với 10581 xã/phường khác nhau
                         --nhưng chỉ có 63 tỉnh thành lặp lại
						 
select distinct province from Locations --giống cục thống kê

--dùng nó để insert sang table lookup

INSERT INTO Province VALUES(N'Thành phố Cần Thơ')
INSERT INTO Province VALUES(N'Tỉnh Vĩnh Long')

DELETE FROM Province

--CÁCH INSERT THỨ 2
INSERT INTO Province VALUES (N'Tỉnh Vĩnh Long'), (N'Thành phố Cần Thơ')

--TUYỆT CHIÊU INSERT THỨ 3
--COPY PASTE ĐÃ HỌC CHO 10K DÒNG

--TUYỆT CHIÊU INSERT THỨ 4
--INSERT INTO Province VALUES CÓ 63 TỈNH LÀ NGON - TA XÀI KIỂU SUB-QUERY
--                            TRONG LỆNH INSERT


INSERT INTO Province SELECT DISTINCT province FROM Locations

SELECT * FROM Province

SELECT COUNT(*) FROM Locations --10581 XÃ PHƯỜNG
SELECT COUNT(province) FROM Locations --10581 
SELECT COUNT(DISTINCT province) FROM Locations --10581 

--TẠO TABLE LOOKUP QUẬN/HUYỆN
CREATE TABLE District
(
	DName nvarchar(30)
)

--có bao nhiêu quận ở VN
SELECT District FROM Locations --10581 quận đc lặp lại ứng với 10581 phường khác nhu

SELECT DISTINCT District FROM Locations  --683 DÒNG, 683 QUẬN KHÁC NHAU
--RẤT CẨN THẬN KHI CHƠI VỚI QUẬN/HUYỆN
--TIỀN GIANG, VĨNH LONG, TRÀ VINH, ĐỀU CÓ HUYỆN "CHÂU THÀNH"
--BẢNG DISTRICT CHỈ CÓ 1 CHÂU THÀNH, LÁT HỒI!!!

--PK CỦA District ko thể là TÊN QUẬN/HUYỆN ĐC!!!


SELECT COUNT(DISTINCT District) FROM Locations --683

--CHÈN VÀO TABLE QUẬN
INSERT INTO District SELECT DISTINCT District FROM Locations 
SELECT * FROM District

--CITY và DISTRICT CÓ SỰ PHỤ THUỘC LẪN NHAU, TỪ THẰNG NÀY SUY ĐC RA THẰNG KIA
--NHÌN QUẬN CÓ THỂ ĐOÁN T/P (CHIỀU NÀY KO CHẮC AN TOÀN)
--                           NHÌN CHÂU THÀNH, SAO ĐOÁN ĐC TỈNH??? ST, TV, VL  
--NHÌN T/P ĐOÁN RA QUẬN (HỢP LÍ VỀ SUY LUẬN) 
--                           VL -> MANG THÍT, VL, CHÂU THÀNH  
--                           ST -> ...            CHÂU THÀNH

--FD NÊN ĐỌC LÀ CITY -> DISTRICT
--TABLE CHỨA CÁC FD KIỂU PHỤ THUỘC NGANG GIỮA CÁC CỘT -> SUY NGHĨ TÁCH BẢNG
--TÁCH THẰNG VẾ TRÁI & PHẢI, RA TABLE KHÁC!!!, TÁCH XONG THÌ PHẢI FK CHO PHẦN
--CÒN LẠI

--SAU KHI TÁCH TA CÓ TRONG TAY 3 TABLE
--PROVINCE ( PName)

--       DISTRICT (DName, PName (FK lên trên))

--           WARD (WName phường nào, quận nào DName FK lên Quận)

--GIẢI PHÁP "DỞ" CHO HUYỆN CHÂU THÀNH CỦA 3 TỈNH MIỀN TÂY!!! TA SẼ LÀM SAU
--DÙNG NATURAL KEY, KEY TỰ NHIÊN - DÙNG TÊN CỦA TỈNH, HUYỆN LÀM KEY

--DÙNG KEY TỰ GÁN, TỰ TĂNG, KEY THAY THẾ, KEY GIẢ (SURROGATE KEY/ARTIFICIAL KEY)

--PHIÊN BẢN ĐẸP NHƯNG VẪN CÒN CHÚT CHÂU THÀNH!!!
DROP TABLE Province
DROP TABLE District

CREATE TABLE Province
(
	PName nvarchar(30) PRIMARY KEY
)

INSERT INTO Province SELECT DISTINCT province FROM Locations
SELECT * FROM Province

DROP TABLE District

CREATE TABLE District
(
	DName nvarchar(30) NOT NULL, --HOK CÓ 2 CHÂU THÀNH CỦA 3 TỈNH MIỀN TÂY
	-- Quận nào vậy
	-- và thuộc về Tỉnh/TP nào vậy
	PName nvarchar(30) NOT NULL REFERENCES Province(PName),
	PRIMARY KEY (DName, PName)

)                      --THAM CHIẾU ĐỂ KO NHẬP TỈNH KO TỒN TẠI, TỈNH AHIHI

/*
CREATE TABLE District
(
	DName nvarchar(30) PRIMARY KEY, --HOK CÓ 2 CHÂU THÀNH CỦA 3 TỈNH MIỀN TÂY
	-- Quận nào vậy

	-- và thuộc về Tỉnh/TP nào vậy
	PName nvarchar(30) REFERENCES Province(PName)
)  
*/

INSERT INTO District 


SELECT District, Province FROM Locations  --10581 PHƯỜNG XÃ BỊ CẮT CỘT P.X
SELECT * FROM Locations                   -- LẤY ĐỦ 3 CỘT

SELECT DISTINCT District, Province FROM Locations ORDER BY District
--699 quận, có rất nhiều Châu Thành của 6 tỉnh miền Tây
INSERT INTO DISTRICT 
                     SELECT DISTINCT District, Province 
                     FROM Locations ORDER BY District

SELECT * FROM DISTRICT


--hỏi thử: TPHCM có những Quận nào???
SELECT DName FROM District WHERE PName = N'Thành phố Hồ Chí Minh'

SELECT DName FROM District WHERE PName = N'Tỉnh Long An'
--


--THÀNH PHẦN ĐÔNG DATA NHẤT LÀ WARD/PHƯỜNG, CÓ 10581 DÒNG
--ỨNG VỚI VÔ SÔ LẶP LẠI CÁC QUẬN, FK 

--xã có trùng tên hem???
CREATE TABLE Ward
(
	WName nvarchar(30), 
	--xã phường ơi, bạn ở quận nào?
	DName nvarchar(30) --REFERENCES District(DName)
)

SELECT * FROM Locations --10581 Xã Phường, liệu rằng có trùng???
SELECT COUNT(DISTINCT ward) FROM Locations --đếm trùng xã đếm 1 lần
                           --7884, TRÙNG TÊN 3000 TÊN 
SELECT ward FROM Locations ORDER BY ward

INSERT INTO WARD SELECT Ward, district FROM Locations --10581
SELECT * FROM Ward

--CHO TUI XEM CÁC PHƯỜNG CỦA Q1. TPHCM
SELECT * FROM Ward WHERE DName = N'Quận 1'

--Huyện Châu Thành của Tiền Giang có những xã nào!!!!
--23 xã
SELECT w.WName, w.DName, d.PName FROM Ward w INNER JOIN 
                    District d ON w.DName = d.DName
					WHERE d.DName = N'Huyện Châu Thành'
					AND   d.PName = N'Tỉnh Tiền Giang' 
  

--Huyện Ba Tri của Bến Tre có những xã nào!!!!
--23 xã
SELECT w.WName FROM Ward w INNER JOIN 
                    District d ON w.DName = d.DName
					WHERE d.DName = N'Huyện Ba Tri'
					AND   d.PName = N'Tỉnh Bến Tre' 
 

SELECT * FROM Ward ORDER BY DName  
SELECT * FROM Ward WHERE DName = N'Huyện Châu Thành'