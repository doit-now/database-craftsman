USE Northwind

-------------------------------------------------------------------------------------
-- LÍ THUYẾT
-- DB ENGINE hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột, gom data tính toán
-- trên đám data gom này - nhóm hàm gom nhóm  - AGGREGATE FUNCTIONS, AGGREGATION
-- COUNT() SUM() MIN() MAX() AVG()

-- * CÚ PHÁP CHUẨN
-- SELECT CỘT..., HÀM GOM NHÓM(),... FROM <TABLE>

-- * CÚ PHÁP MỞ RỘNG

-- SELECT CỘT..., HÀM GOM NHÓM(),... FROM <TABLE>...WHERE... GROUP BY (GOM THEO CỤM CỘT NÀO)

-- SELECT CỘT..., HÀM GOM NHÓM(),... FROM <TABLE>...WHERE... GROUP BY (GOM THEO CỤM CỘT NÀO) HAVING...

-- * HÀM COUNT(???) ĐẾM SỐ LẦN XUẤT HIỆN CỦA 1 CÁI GÌ ĐÓ???
--       COUNT(*):  ĐẾM SỐ DÒNG TRONG TABLE, ĐẾM TẤT CẢ CÁC DÒNG KO CARE TIÊU CHUẨN NÀO KHÁC
--       COUNT(*) FROM... WHERE ...
--                  CHỌN RA NHỮNG DÒNG THỎA TIÊU CHÍ WHERE NÀO ĐÓ TRƯỚC ĐÃ, RỒI MỚI ĐẾM
--                  FILTER RỒI ĐẾM  
--
--       COUNT(CỘT NÀO ĐÓ): 

-------------------------------------------------------------------------------------
--1. In ra danh sách các nhân viên
SELECT * FROM Employees

--2. Đếm xem có bao nhiêu nhân viên
SELECT COUNT(*) FROM Employees
SELECT COUNT(*) AS [Number of employees] FROM Employees

--3. Có bao nhiêu NV ở London
SELECT COUNT(*) FROM Employees WHERE City = 'London'
SELECT COUNT(*) AS NoempsinLondon FROM Employees WHERE City = 'London'

--4. Có bao nhiêu lượt thành phố xuất hiện - cứ xh tên tp là đếm, ko care lặp lại hay ko
SELECT COUNT(City) FROM Employees --9

--5. Đếm xem có bao nhiêu Region
SELECT COUNT(Region) FROM Employees --
-- PHÁT HIỆN HÀM COUNT(CỘT), NẾU CELL CỦA CỘT CHỨA NULL, KO TÍNH, KO ĐẾM

--6. Đếm xem có bao nhiêu khu vực null, có bao nhiêu dòng region null
SELECT COUNT(*) FROM Employees WHERE Region IS NULL -- đếm sự xh dòng chứa Region null

SELECT COUNT(Region) FROM Employees WHERE Region IS NULL --0 null ko đếm đc, ko value
SELECT * FROM Employees WHERE Region IS NULL

--7. Có bao nhiêu thành phố trong table NV
SELECT * FROM Employees

SELECT City FROM Employees --9
SELECT DISTINCT City FROM Employees --5
-- tui coi kết quả trên là 1 table, mất quá trời công sức lọc ra 5 tp

-- SUB QUERY MỚI, COI 1 CÂU SELECT LÀ 1 TABLE, BIẾN TABLE NÀY VÀO TRONG MỆNH ĐỀ FROM
-- NGÁO
SELECT * FROM   
         (SELECT DISTINCT City FROM Employees) AS CITIES   

SELECT COUNT(*) FROM   
         (SELECT DISTINCT City FROM Employees) AS CITIES   --5 

SELECT COUNT(*) FROM Employees --9 NV
SELECT COUNT(City) FROM Employees --9 City

SELECT COUNT(DISTINCT City) FROM Employees --5

--8. Đếm xem MỖI thành phố có bao nhiêu nhân viên
-- KHI CÂU HỎI CÓ TÍNH TOÁN GOM DATA (HÀM AGGREGATE) MÀ LẠI CHỨA TỪ KHÓA MỖI....
-- GẶP TỪ "MỖI", CHÍNH LÀ CHIA ĐỂ ĐẾM, CHIA ĐỂ TRỊ, CHIA CỤM ĐỂ GOM ĐẾM
SELECT * FROM Employees

--Seatle 2 | Tacoma 1 | Kirland 1 | Redmon 1 | London 4
-- Sự xuất hiện của nhóm
-- Đếm theo sự xh của nhóm, count++ trong nhóm thoy, sau đó reset ở nhóm mới
SELECT COUNT(City) FROM Employees GROUP BY City ---ĐẾM VALUE CỦA CITY, NHƯNG ĐẾM THEO NHÓM 
                                                -- CHIA CITY THÀNH NHÓM, RỒI ĐẾM TRONG NHÓM

SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City 
 
SELECT EmployeeID, City, COUNT(City) AS [No employess] FROM Employees GROUP BY City, EmployeeID
--vô nghĩa, chia nhóm theo key, mssv vô nghĩa


--CHỐT HẠ: KHI XÀI HÀM GOM NHÓM, BẠN CÓ QUYỀN LIỆT KÊ TÊN CỘT LẺ Ở SELECT 
--         NHƯNG CỘT LẺ ĐÓ BẮT BUỘC PHẢI XUẤT HIỆN TRONG MỆNH ĐỀ GROUP BY 
--         ĐỂ ĐẢM BẢO LOGIC: CỘT HIỂN THỊ | SỐ LƯỢNG ĐI KÈM, ĐẾM GOM THEO CỘT HIỂN THỊ MỚI LOGIC
-- CỨ THEO CỘT CITY MÀ GOM, CỘT CITY NẰM Ở SELECT HỢP LÍ 
-- MUỐN HIỂN THỊ SỐ LƯỢNG CỦA AI ĐÓ, GÌ ĐÓ, GOM NHÓM THEO CÁI GÌ ĐÓ 

-- NẾU BẠN GOM THEO KEY/PK, VÔ NGHĨA HENG, VÌ KEY HOK TRÙNG, MỖI THẰNG 1 NHÓM, ĐẾM CÁI GÌ???

-- MÃ SỐ SV  --- ĐẾM CÁI GÌ??? VÔ NGHĨA
-- MÃ CHUYÊN NGÀNH -- ĐẾM SỐ SV CHUYÊN NGÀNH!!!!!
-- MÃ QUỐC GIA --- ĐẾM SỐ ĐƠN HÀNG
-- ĐIỂM THI  -- ĐẾM SỐ LƯỢNG SV ĐẠT ĐC ĐIỂM ĐÓ
-- CÓ CỘT ĐỂ GOM NHÓM, CỘT ĐÓ SẼ DÙNG ĐỂ HIỂN THỊ SỐ LƯỢNG KẾT QUẢ


--IN RA MÃ NV
--1  London 1   
--2  Seatle 1
--3         1
--4
--5


SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City 

--9. HÃY CHO TUI BIẾT TP NÀO CÓ TỪ 2 NV TRỞ LÊN
-- 2 chặng làm
-- 9.1 Các tp có bao nhiêu nhân viên
-- 9.2 Đếm xong mỗi tp, ta bắt đầu lọc lại kết quả sau đếm
-- FILTER SAU ĐẾM, WHERE SAU ĐẾM, WHERE SAU KHI ĐÃ GOM NHÓM, AGGREGATE THÌ GỌI LÀ HAVING

SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City 
SELECT City, COUNT(*) AS [No employess] FROM Employees GROUP BY City

SELECT City, COUNT(*) AS [No employess] FROM Employees GROUP BY City
                                                       HAVING COUNT(*) >= 2


--10. Đếm số nhân viên của 2 thành phố Seatle và London
SELECT COUNT(*) FROM Employees WHERE City IN ('London', 'Seattle') --6 ĐỨA, SAI RỒI
SELECT COUNT(*) FROM Employees WHERE City IN ('London', 'Seattle') GROUP BY City --6 ĐỨA, SAI RỒI
SELECT City, COUNT(*) FROM Employees WHERE City IN ('London', 'Seattle') GROUP BY City --2 4

--11. Trong 2 tp, London Seattle, tp nào có nhiều hơn 3 nv
SELECT City, COUNT(*) FROM Employees 
                      WHERE City IN ('London', 'Seattle') 
					  GROUP BY City --
					  HAVING COUNT(*) >= 3

--12. Đếm xem có bao nhiêu đơn hàng đã bán ra
SELECT * FROM Orders
SELECT COUNT(*) AS [No Orders] FROM Orders --830

SELECT COUNT(OrderID) AS [No Orders] FROM Orders --830
--830 mã đơn khác nhau, đếm mã đơn, hay đếm cả cái đơn là như nhau
--nếu cột có value NULL ăn hành!!!!

--12.1. Nước Mĩ có bao nhiêu đơn hàng
-- đi tìm Mĩ mà đếm, lọc Mĩ rồi tính tiếp, WHERE MĨ
-- KO PHẢI LÀ CÂU GOM CHIA NHÓM, HOK CÓ MỖI QUỐC GIA BAO NHIÊU ĐƠN, 
-- MỖI QG CÓ BAO NHIÊU ĐƠN, COUNT THEO QUỐC GIA, GROUP BY THEO QUỐC GIA
SELECT COUNT(*) AS [No USA Orders] FROM Orders WHERE ShipCountry = 'USA'

--12.2. Mĩ Anh Pháp chiếm tổng cộng bao nhiêu đơn hàng - WHERE GOM CHUNG
SELECT COUNT(*) FROM Orders WHERE ShipCountry IN ('USA', 'UK', 'FRANCE') --255 CHO CẢ 3
SELECT COUNT(*) FROM Orders WHERE ShipCountry = 'USA' 
                                  AND ShipCountry = 'UK' 
								  AND ShipCountry = 'FRANCE'  --0

SELECT COUNT(*) FROM Orders WHERE ShipCountry = 'USA' 
                                  OR ShipCountry = 'UK' 
								  OR ShipCountry = 'FRANCE'  --255

--12.3. Mĩ Anh Pháp, mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry, COUNT(*) AS [No Orders] 
                             FROM Orders
							 WHERE ShipCountry IN ('USA', 'FRANCE', 'UK')
							 GROUP BY ShipCountry 
--12.4. Trong 3 quốc gia A P M, quốc gia nào có từ 100 đơn hàng trở lên
SELECT ShipCountry, COUNT(*) AS [No Orders] 
                             FROM Orders
							 WHERE ShipCountry IN ('USA', 'FRANCE', 'UK')
                             GROUP BY ShipCountry
							 HAVING COUNT(*) >= 100

--13. Đếm xem có bao nhiêu mặt hàng có trong kho
--14. Đếm xem có bao nhiêu lượt quốc gia đã mua hàng 
--15. Đếm xem có bao nhiêu quốc gia đã mua hàng (mỗi quốc gia đếm một lần)
--16. Đếm số lượng đơn hàng của mỗi quốc gia
--17. Quốc gia nào có từ 10 đơn hàng trở lên
--18. Đếm xem mỗi chủng loại hàng có bao nhiêu mặt hàng (bia rượu có 5 sp, thủy sản 10 sp)
--19. Trong 3 quốc gia A P M, quốc gia nào có nhiều đơn hàng nhất
--20. Quốc gia nào có nhiều đơn hàng nhất
--21. Thành phố nào có nhiều nhân viên nhất???
