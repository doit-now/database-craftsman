--CREATE DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK

CREATE TABLE PhoneBookV3_2
(
   Nick nvarchar(30),  --ngoài cột này bị lặp lại, mình còn cần thêm cột
                       --fullname, tên cty, chức vụ
   --...CompanyName,...
   Phone char(11),  --chỉ 1 số phone hoy, CẦN GIẢI NGHĨA THÊM SỐ NÀY LÀ SỐ GÌ
   PhoneType nvarchar(20)  -- 090x   Home, 091x  Work
) 

--------------------------------------------------
-- TÁCH BẢNG
-- KHỐN NẠN, INFO BỊ PHÂN MẢNH, NẰM NHIỀU NƠI, PHẢI JOIN RỒI
-- NHẬP DATA COI CHỪNG BỊ VÊNH, XÓA DATA COI CHỪNG LẠC TRÔI,
-- PHÂN MẢNH PHẢI CÓ LÚC TÁI NHẬP (JOIN) JOIN TRÊN CỘT MẸ NÀO???
-- FK XUẤT HIỆN!!!!!
-- hok thích chơi fk dc ko??? được và ko đc
-- nếu chỉ cần join éo cần fk, cột = value, khớp là join, nối bảng, ghép ngang
-- nếu kèm thêm xóa, sửa, thêm, chết mẹ, lộn xộn ko nhất quán 

CREATE TABLE PersonV4_1
(
	Nick nvarchar(30),  --ngoài cột này bị lặp lại, mình còn cần thêm cột
                       --fullname, tên cty, chức vụ
    Title nvarchar(30),
	Company nvarchar(40)
)

CREATE TABLE PhoneBookV4_1
(   
   Phone char(11),  
   PhoneType nvarchar(20), 
   Nick nvarchar(30)  -- éo cần fk, chỉ cần join vẫn okie
) 

SELECT * FROM PersonV4_1
SELECT * FROM PhoneBookV4_1

INSERT INTO PersonV4_1 VALUES(N'hoangnt', 'Lecturer', 'FPTU HCMC')
INSERT INTO PersonV4_1 VALUES(N'annguyen', 'Student', 'FPTU HCMC')
INSERT INTO PersonV4_1 VALUES(N'binhle', 'Student', 'FPTU HLL')


INSERT INTO PhoneBookV4_1 VALUES('098x', 'Cell', N'hoangnt')

INSERT INTO PhoneBookV4_1 VALUES('090x', 'CELL', N'annguyen')
INSERT INTO PhoneBookV4_1 VALUES('091x', 'Home', N'annguyen')

INSERT INTO PhoneBookV4_1 VALUES('090x', 'work', N'binhle')
INSERT INTO PhoneBookV4_1 VALUES('091x', 'cell', N'binhle')
INSERT INTO PhoneBookV4_1 VALUES('092x', 'cell', N'binhle')

-- PHÂN TÍCH
-- *ƯU ĐIỂM
-- Count ngon, group by theo nick, theo loại phone
-- where theo loại phone ngon
-- Redundancy trên info của nick/full/cty/email/năm sinh... giải quyết xong ở bảng person

-- *NHƯỢC ĐIỂM
-- Tính ko nhất quán (inconsistency) của loại phone: có người gõ: Cell, CELL, cell éo sợ vì cùng là 1 kiểu
--                                                            gõ thêm: Di động, DĐ -> cả đám này là 1 theo logic
--                                                            máy hiểu khác nhau
-- query liệt kê các số di động của tất cả mọi người, toang khi WHERE
-- vì éo biêt đc có bao nhiêu loại chữ biểu diễn cho DI ĐỘNG
INSERT INTO PhoneBookV4_1 VALUES('093x', 'MOBILE', N'binhle')
INSERT INTO PhoneBookV4_1 VALUES('094x', 'Sugar Daddy', N'binhle')

--SQL. Liệt kê các số di động của bìnhle 
SELECT * FROM PhoneBookV4_1 
         WHERE PhoneType = 'Cell' OR  PhoneType = 'CELL' OR PhoneType = 'DĐ'
SELECT * FROM PhoneBookV4_1 
         WHERE PhoneType IN ('Cell', 'CELL', 'DĐ')
		 -- mày tính IN cái tập hợp này đến bao giờ khi người ta còn gõ từ khác
		 -- cùng biểu diễn khái niệm di động

-- QUY TẮC THÊM: CÓ NHỮNG LOẠI DỮ LIỆU BIẾT TRƯỚC LÀ NHIỀU, NHƯNG HỮU CÁI VALUE NHẬP
-- TỈNH THÀNH NHIỀU, CHỈ 63, QUỐC GIA NHIỀU 230, CHÂU LỤC NHIỀU 56, TRƯỜNG THPT, 500 TRƯỜNG
-- CÓ NÊN CHO NGƯỜI TA GÕ TAY HAY KO, K0, VÌ NÓ SẼ GÂY NÊN KO NHẤT QUÁN!!!!!
-- TỐT NHẤT CHO CHỌN, CHỌN PHẢI TỪ CÁI CÓ SẴN, SẴN, SẴN TỨC LÀ TỪ TABLE KHÁC 

-- KO CHO GÕ LUNG TUNG, GÕ TRONG CÁI ĐÃ CÓ - DÍNH 2 THỨ, TABLE KHÁC (ĐÃ NÓI TRÊN)
--                       FK ĐỂ ĐẢM BẢO CHỌN ĐÚNG TRONG ĐÓ THOY

