-- KHI CÓ NHIỀU CÂU LỆNH SQL SELECT PHỨC TẠP, HAY TA CẦN VIẾT LẠI NHIỀU LẦN
-- 1 CÂU SELECT NÀO ĐÓ, TA ĐẶT CHO CÂU LỆNH SQL SELECT NÀY 1 CÁI TÊN
-- SAU NÀY MÚN XÀI LẠI CÂU SQL SELECT NÀY CHỈ GỌI TÊN RA LÀ ĐC 

-- 1 CÂU LỆNH SELECT ~~~~~ 1 TABLE ĐC TRẢ VỀ KHI CHẠY
-- 1 CÂU LỆNH SELECT ------ ĐẶT CHO NÓ 1 CÁI TÊN ---- 1 TABLE ĐC TRẢ VỀ KHI CHẠY
-- NẾU TA MÚN NHÌN TABLE NÀY, CHẠY LẠI LỆNH SELECT NÀY

-- TA CHỈ VIỆC SELECT * FROM CÁI-TÊN-ĐÃ-ĐẶT

USE Northwind
SELECT * FROM Employees

-- Liệt kê các nhân viên ở London
SELECT * 
FROM Employees
WHERE City = 'London'

-- COI CÂU NÀY LÀ 1 TABLE, CHO NÓ 1 CÁI TÊN, SAU NÀY MÚN XEM LẠI DATA, SELECT CÁI TÊN

GO

CREATE VIEW VW_LondonEmployees
AS 
SELECT * FROM Employees WHERE City = 'London'

GO
--XÀI VIEW, COI MÀY LÀ TABLE, VÌ SAU LƯNG MÀY LÀ 1 CÂU SELECT CHỐNG LƯNG

SELECT * FROM VW_LondonEmployees
SELECT * FROM [Category Sales for 1997]

