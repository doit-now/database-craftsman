use Northwind

SELECT * FROM VnDict, EnDict -- tích Đề-các

SELECT * FROM VnDict CROSS JOIN EnDict -- tích Đề-các

SELECT * FROM VnDict vn, EnDict en     -- TÍCH ĐỀ-CÁC XONG, FILTER LẠI
         WHERE vn.Nmbr = en.Nmbr       -- THỰC DỤNG

SELECT * FROM VnDict, EnDict
         WHERE Nmbr = Nmbr    --BỐI RỐI TÊN

SELECT * FROM VnDict, EnDict
         WHERE VnDict.Nmbr = EnDict.Nmbr --NÊN ĐẶT ALIAS THÌ GIÚP NGẮN GỌN CÂU LỆNH


--CHUẨN THẾ GIỚI
SELECT * FROM VnDict INNER JOIN EnDict   -- NHÌN SÂU TABLE RỒI GHÉP, KO GHÉP BỪA BÃI
                     ON VnDict.Nmbr = EnDict.Nmbr --GHÉP CÓ TƯƠNG QUAN BÊN TRONG, THEO ĐIỂM TRUNG

SELECT * FROM VnDict JOIN EnDict   -- NHÌN SÂU TABLE RỒI GHÉP, KO GHÉP BỪA BÃI
                     ON VnDict.Nmbr = EnDict.Nmbr

-- CÓ THỂ DÙNG THÊM WHERE ĐC HAY KO??? KHI XÀI INNER, JOIN
-- JOIN CHỈ LÀ THÊM DATA ĐỂ TÍNH TOÁN, GỘP DATA LẠI NHIỀU HƠN, SAU ĐÓ ÁP DỤNG TBO
-- KIẾN THỨC SELECT ĐÃ HỌC

-- THÍ NGHIỆM THÊM CHO INNER JOIN, GHÉP NGANG CÓ XEM XÉT MÔN ĐĂNG HỘ ĐỐI HAY KO???
SELECT * FROM EnDict
SELECT * FROM VnDict

SELECT * FROM EnDict e, VnDict v 
         WHERE e.Nmbr = v.Nmbr 

SELECT * FROM EnDict e, VnDict v 
         WHERE e.Nmbr > v.Nmbr        -- GHÉP CÓ CHỌN LỌC, HOK XÀI DẤU =
		                              -- MÀ DÙNG DẤU > >= < <= !=
									  -- NON-EQUI JOIN
									  -- VẪN KO LÀ GHÉP BỪA BÃI  
--2Two 1Mot
--3Three 1Mot
--3Three 2Hai

SELECT * FROM EnDict e, VnDict v      --  THỰC DỤNG
         WHERE e.Nmbr != v.Nmbr   

SELECT * FROM EnDict e JOIN VnDict v   -- CHUẨN MỰC
         ON e.Nmbr != v.Nmbr 
