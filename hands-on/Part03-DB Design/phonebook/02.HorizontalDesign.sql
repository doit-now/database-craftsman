--CREATE DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK

CREATE TABLE PhoneBookV2_
(
   Nick nvarchar(30),
   --Phone varchar(50) --cấm đa trị, cấm gộp nhiều số phone trong 1 cell
   Phone1 char(11),  --chỉ 1 số phone hoy
   Phone2 char(11),
   Phone3 char(11)   --éo biết cột nào là loại phone nào, 1 3 3 vô hồn
)  

CREATE TABLE PhoneBookV2
(
   Nick nvarchar(30),
   --Phone varchar(50) --cấm đa trị, cấm gộp nhiều số phone trong 1 cell
   HomePhone char(11),  --chỉ 1 số phone hoy
   WorkPhone char(11),
   CellPhone char(11)   
)  
-- MỞ RỘNG TABLE THEO CHIỀU NGANG - THÊM CỘT!!!!!


SELECT * FROM PhoneBookV2
INSERT INTO PhoneBookV2 VALUES(N'hoangnt', NULL, NULL, '098x')

INSERT INTO PhoneBookV2 VALUES(N'annguyen', '090x',  '091x', NULL)

INSERT INTO PhoneBookV2 VALUES(N'binhle', '090x', '091x', '092x')

--***** PHÂN TÍCH:
-- >>>>> ƯU ĐIỂM: SELECT PHONE LÀ RA ĐC TẤT CẢ CÁC SỐ DI ĐỘNG luôn
--1.SQL. Cho tui biết các số di động của mọi người
SELECT Nick, CellPhone FROM PhoneBookV2
SELECT p.Nick, p.CellPhone FROM PhoneBookV2 p
-- >>>>> Cho tui biết số để bàn, ở nhà của anh binhle???
-- >>>>> In cho tui số di động của mọi người??? 

SELECT p.Nick, p.HomePhone, p.CellPhone FROM PhoneBookV2 p
        WHERE p.Nick = 'binhle'

-- >>>>> NHƯỢC ĐIỂM
--> Thống kê số lượng số điện thoại mỗi người xài, mấy sim??? ko trả lời đc
--> Data bị NULL, phí ko gian lưu trữ
--> NGƯỜI CÓ 4 PHONE, 5 PHONE THÌ SAO???
--> solution: thêm cột, càng thêm cột trừ hao về người có nhiều phone
-->           những người còn lại bị null càng nhiều
--> PHÍ VÌ CHỈ 1 VÀI NGƯỜI ĐẶC BIỆT NHIỀU PHONE MÀ TẤT CẢ ANH EM KHÁC ĐỀU ĐC
--> XEM CHUNG LÀ NHIỀU SỐ PHONE, PHÍ KO GIAN LƯU TRỮ
--> GIẢ SỬ VẪN QUYẾT TÂM THEO CỘT, NỞ CỘT RA, THÌ GIÁ PHẢI TRẢ SỬA CODE LẬP TRÌNH
--> SAU NÀY, VÌ TÊN CỘT MỚI ĐC THÊM VÔ KHI NÂNG CẤP APP, SỬA THÊM CÂU QUERY,

--> TRIẾT LÍ THIẾT KẾ: CỐ GẮNG GIỮ NGUYÊN CÁI TỦ, CHỈ THÊM ĐỒ, 
--                     KO THÊM CỘT CỦA TABLE, CHỈ CẦN THÊM DÒNG NẾU CÓ BIẾN ĐỘNG
--                     SỐ LƯỢNG

--> PHIÊN BẢN 3 - PHIÊN BẢN NGON BẮT ĐẦU, AI NHIỀU PHONE THÌ NHIỀU DÒNG, NHIỀU 
--> CELL THEO CHIỀU DỌC THÊM DÒNG
--> COUNT NGON LÀNH LUÔN, TRẢ LỜI NGAY ĐC CÂU BAO NHIÊU SIM BAO NHIÊU SÓNG





