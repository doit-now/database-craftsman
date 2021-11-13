-- Kiểu dữ liệu - data type là cách ta lưu loại dữ
-- liệu nào đó: số (nguyên, thực), 
-- chữ, câu/đoạn văn, ngày tháng, tiền ($...)
-- 1 NNLT sẽ hỗ trợ nhiều loại dữ liệu khác nhau - data types
-- 
-- Khi lập trình trong SQL Server, vì câu lệnh sẽ nằm trên nhiều dòng...
-- mình cần nhắc Tool này 1 câu: đừng nhìn lệnh riêng lẻ (nhiều dòng) mà hãy nhìn
-- nguyên cụm lệnh mới có ý nghĩa (BATCH)
-- Ta dùng lệnh GO để gom 1 cụm lệnh lập trình lại thành 1 đơn vị có ý nghĩa 


-- KHAI BÁO BIẾN
GO

DECLARE @msg1 AS nvarchar(30)

DECLARE @msg nvarchar(30) = N'Xin chào - Welcome to T-SQL'

--IN BIẾN CÓ 2 LỆNH
PRINT @msg   -- IN RA KẾT QUẢ BÊN CỬA SỔ CONSOLE GIỐNG LẬP TRÌNH 

SELECT @msg  -- IN RA KẾT QUẢ DƯỚI DẠNG TABLE

DECLARE @yob int -- = 2003

--GÁN GIÁ TRỊ CHO BIẾN
SET @yob = 2003
SELECT @yob = 2004  -- SELECT DÙNG 2 CÁCH: GÁN GIÁ TRỊ CHO BIẾN, IN GIÁ TRỊ CỦA BIẾN

PRINT @YOB

IF @YOB > 2003
	BEGIN  --{
		PRINT 'HEY, BOY/GIRL'
		PRINT 'HELLLO GEN Z'
	END    --}
ELSE
	PRINT 'HELLO LADY & GENTLEMENT'
GO