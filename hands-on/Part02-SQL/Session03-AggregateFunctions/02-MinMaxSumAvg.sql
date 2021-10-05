USE Northwind

-------------------------------------------------------------------------------------
-- LÍ THUYẾT
-- DB ENGINE hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột, gom data tính toán
-- trên đám data gom này - nhóm hàm gom nhóm  - AGGREGATE FUNCTIONS, AGGREGATION
-- COUNT() SUM() MIN() MAX() AVG()

-- * CÚ PHÁP CHUẨN
-- SELECT CỘT..., HÀM GOM NHÓM(),... FROM <TABLE>
-- SELECT CỘT,... HÀM GOM NHÓM(), ... FROM <TABLE> WHERE ... GROUP BY... HAVING (WHERE THỨ 2) 
-------------------------------------------------------------------------------------
-- THỰC HÀNH
-- 1. Liệt kê danh sách nhân viên
SELECT * FROM Employees

--2. Năm sinh nào là bé nhất (tuổi max)
SELECT MIN(BirthDate) FROM Employees
SELECT MAX(BirthDate) FROM Employees

--3. Ai sinh năm bé nhất, ai lớn tuổi nhất, in ra info
SELECT * FROM Employees WHERE BirthDate = (
											SELECT MIN(BirthDate) FROM Employees
                                          )

SELECT * FROM Employees WHERE BirthDate <= ALL (
											SELECT MIN(BirthDate) FROM Employees
                                          )

SELECT * FROM Employees WHERE BirthDate <= ALL (
											SELECT BirthDate FROM Employees
                                          )

--4.1. Trọng lượng nào là lớn nhất trong các đơn hàng đã bán
--4.2. Trong các đơn hàng, đơn hàng nào có trọng lượng nặng nhất/nhỏ nhất
SELECT MAX(Freight) FROM Orders -- ORDER BY Freight DESC
SELECT * FROM Orders WHERE Freight = (
										SELECT MAX(Freight) FROM Orders
                                     )

                                 -- >= ALL (TẤT CẢ CÁC TRỌNG LƯỢNG)
								 
--5. Tính tổng khối lượng của các đơn hàng đã vận chuyển
--830 đơn hàng
SELECT * FROM Orders --830
SELECT COUNT(*) FROM Orders --1 DÒNG 830
SELECT SUM(Freight) AS [Freight in total] FROM Orders

--6. TRUNG BÌNH CÁC ĐƠN HÀNG NẶNG BAO NHIÊU???
SELECT AVG(Freight) FROM Orders --78.2442

--7. Liệt kê các đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả
SELECT * FROM Orders 
         WHERE Freight >= (
		                    SELECT AVG(Freight) FROM Orders 
		                  )   --242 dòng

--8. Có bao nhiêu đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả
-- đáp án 242 only
SELECT COUNT(*) FROM (
                         SELECT * FROM Orders 
								  WHERE Freight >= (
													SELECT AVG(Freight) FROM Orders 
												   ) 
                     ) AS [AVG]


SELECT COUNT(*) FROM Orders
                WHERE Freight >= (
									SELECT AVG(Freight) FROM Orders
				                 ) 
--chỉ những thằng > trung bình thì mới đếm, HOK CHIA NHÓM À NHEN

-- NHẮC LẠI
-- CỘT XH TRONG SELECT HÀM Ý ĐẾM THEO CỘT NÀY, CỘT PHẢI XH TRONG GROUP BY

-- TỈNH ,  <ĐẾM CÁI GÌ ĐÓ CỦA TỈNH>  -> RÕ RÀNG PHẢI CHIA THEO TỈNH MÀ ĐẾM
                                     -- GROUP BY TỈNH 
-- CHUYÊN NGÀNH , <ĐẾM CỦA CHUYÊN NGÀNH>  -> CHIA THEO CN MÀ ĐẾM
                                          -- GROUP BY CHUYÊN NGÀNH
-- CÓ QUYỀN GROUP BY TRÊN NHIỀU CỘT

-- MÃ CHUYÊN NGÀNH, TÊN CHUYÊN NGÀNH <SL SV>  -> GROUP BY MÃ CN, TÊN CN

-- ÔN TẬP THÊM 
-- 1. In danh sách nhân viên
SELECT * FROM Employees ORDER BY Region

--2. Đếm xem mỗi khu vực có bao nhiêu nv
SELECT COUNT(*) FROM Employees   --9NV
SELECT COUNT(*) FROM Employees GROUP BY Region  -- 4 (NULL) 5 (WA) 
                                   --2 NHÓM REGION, 2 CỤM REGION: WA, NULL

SELECT COUNT(Region) FROM Employees GROUP BY Region --2 cụm Region NULL WA
-- 0 VÀ 5, DO NULL KO ĐC XEM LÀ VALUE ĐỂ ĐẾM, NHƯNG VẪN LÀ MỘT VALUE ĐỂ ĐC CHIA NHÓM
--                                            NHÓM KO GIÁ TRỊ 

SELECT Region, COUNT(Region) FROM Employees GROUP BY Region --sai do đếm null
SELECT Region, COUNT(*) FROM Employees GROUP BY Region --đúng do đếm dòng

--3. Khảo sát đơn hàng
SELECT * FROM Orders
-- Mỗi quốc gia có bao nhiêu đơn hàng
SELECT COUNT(*) FROM Orders
                GROUP BY ShipCountry
SELECT ShipCountry, COUNT(*) FROM Orders
                GROUP BY ShipCountry

--4. Quốc gia nào có từ 50 đơn hàng trở lên
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders
                GROUP BY ShipCountry
				HAVING COUNT(*) >= 50

--5. Quốc gia nào có NHIỀU ĐƠN HÀNG NHẤT

SELECT MAX([No orders]) FROM 

(SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders
                GROUP BY ShipCountry
) AS Cntry
-- lấy đc max rồi

SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders
                GROUP BY ShipCountry
				HAVING COUNT(*) >= 122

SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders
                GROUP BY ShipCountry
				HAVING COUNT(*) = (
									SELECT MAX([No orders]) FROM 
                                         (SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders
                                          GROUP BY ShipCountry
                                         ) AS Cntry
				                  )

--6. LIỆT KÊ CÁC ĐƠN HÀNG CỦA K/H MÃ SỐ VINET
SELECT * FROM Orders WHERE CustomerID = 'VINET'

--7. K/H VINET đã mua bao nhiêu lần???
SELECT COUNT(*), CustomerID FROM Orders
                            WHERE CustomerID = 'VINET'  --ERROR

SELECT CustomerID, COUNT(*) FROM Orders
                            WHERE CustomerID = 'VINET'  --CHIA THEO MÃ KH MÀ ĐẾM
							GROUP BY CustomerID
							-- ĐẾM XONG LOẠI ĐI CÁI THẰNG KO LÀ VINET

SELECT CustomerID, COUNT(*) FROM Orders                           
							GROUP BY CustomerID								 
							HAVING CustomerID = 'VINET'  --CHIA THEO MÃ KH MÀ ĐẾM