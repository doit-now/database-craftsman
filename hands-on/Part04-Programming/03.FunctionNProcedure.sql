-- HÀM: 1 NHÓM CÂU LỆNH ĐC ĐẶT 1 TÊN, NHÓM LỆNH NÀY LÀM 1 VIỆC
-- GÌ ĐÓ. HÀM DÙNG ĐỂ RE-USE
-- HÀM CĂN BẬC 2, LẤY CĂN

-- TRONG LẬP TRÌNH CÓ 2 LOẠI HÀM: 
-- HÀM VOID: KO TRẢ VỀ 1 GIÁ TRỊ NÀO CẢ
-- HÀM CÓ TRẢ VỀ 1 GIÁ TRỊ (CHỈ 1): LỆNH RETURN

-- R.DBMS (CSDL DỰA TRÊN RELATION/TABLE) TA CÓ 2 LOẠI HÀM Y CHANG
-- STORED PROCEDURE ~~~~~ VOID
-- FUNCTION  ~~~~~ RETURN 

-- C: void f(int* a, int* b) {
--        
--    }
-- gọi hàm f()
-- int x = 10, y = 11;

-- f(&x, &y), khi trong hàm f mà làm gì với x, y, thì x ở ở 
-- bên ngoài bị ảnh hưởng luôn 
-- hàm thay đổi 2 giá trị x y ở bên ngoài, void mà lại đưa data ra 
-- ngoài qua con trỏ, truyền tham chiếu pass by reference

-- VIẾT HÀM IN RA CÂU CHÀO!!!
--CREATE PROCEDURE PR_Hello() {... code ...}

CREATE DATABASE DBDESIGN_PROGRAMMING
USE DBDESIGN_PROGRAMMING

GO

CREATE PROCEDURE PR_Hello_1
AS
	PRINT N'Xin chào - Welcome to my own first procedure!'

GO

-- DÙNG PROCEDURE - LÀ HÀM VOID, GỌI TÊN EM LÀ ĐỦ
GO

PR_Hello_1
dbo.PR_Hello_1

EXECUTE PR_Hello_1  --TUI MÚN THỰC THI, CHẠY THỦ TỤC/NHÓM LỆNH ĐÃ ĐẶT TÊN

EXEC PR_Hello_1
GO

CREATE PROC PR_Hello
AS
	PRINT N'Xin chào - Welcome to my own 2nd procedure!'

EXEC PR_Hello

---------------------------------------------
-- HÀM, PHẢI TRẢ VỀ GIÁ TRỊ!!!!! QUA LỆNH RETURN
GO

-- int f() {... code ...}

GO

DROP FUNCTION FN_Hello

CREATE FUNCTION FN_Hello() RETURNS nvarchar(50)
AS
BEGIN
	RETURN N'Xin chào - Welcom to my own first function!'
END

GO
-- LƯU Ý - Y CHANG BÊN LẬP TRÌNH. HÀM TRẢ VỀ GIÁ TRỊ THÌ ĐC QUYỀN DÙNG TRONG 
--         CÁC CÂU LỆNH KHÁC
--         GỌI HÀM MÀ KO KÈM THÊM GÌ KHÁC, ĐỪNG HỎI TẠI SAO MÀN HÌNH KO THẤY GÌ!!!
--         NHIỆM VỤ HÀM LÀ TRẢ VỀ GIÁ TRỊ, IN ÉO LÀ VIỆC CỦA HÀM, VIỆC KHÁC CŨNG THẾ
--         IN XEM HÀM XỬ LÍ RA SAO, THÌ PHẢI KÈM LỆNH IN VÀ LỆNH GỌI HÀM
--         sqrt(4);        -> ko kết quả khi chạy
--         Math.sqrt(4);   -> ko kết quả khi chạy
--         sout(Math.sqrt(4)) -> có kết quả chạy hàm

SELECT dbo.FN_Hello()
SELECT FN_Hello() --bắt buộc phải có dbo.tên-hàm 

SELECT GETDATE()   --HÀM DÙNG XỬ LÍ TRẢ VỀ KQ, PHẢI DÙNG KQ TRONG LỆNH NÀO ĐÓ

GETDATE()  --báo lỗi, phải ghép vào lệnh khác

PRINT dbo.FN_Hello()

--------------------------------------------------------------------
-- VIẾT HÀM - PROC ĐỔI TỪ ĐỘ C -> F, F = C * 1.8 + 32
-- THAM SỐ/ĐẦU VÀO/ARGUMENT

GO

CREATE PROC PR_C2F
@cDegree float
AS
BEGIN
	DECLARE @fDegree float = @cDegree * 1.8 + 32
	PRINT @fDegree
END

GO
-- xài, vì có tham số, cần truyền vào
EXEC PR_C2F @CDegree = 37
EXEC PR_C2F 37

--------------------------------
GO
 
CREATE FUNCTION FN_C2F(@cDegree float)
RETURNS float
AS
BEGIN
	DECLARE @fDegree float = @cDegree * 1.8 + 32
	RETURN @fDegree
END

GO
-- sử dụng hàm, hàm là phải viết kèm với lệnh khác
PRINT dbo.FN_C2F(37)
PRINT N'37 độ C là ' + CAST(dbo.FN_C2F(37) AS varchar(10)) + N' độ F' 

-- PROCEDURE LÀM ĐC NHIỀU VIỆC KHÁC:
-- VIẾT 1 PROCEDURE IN RA DANH SÁCH CÁC NHÂN VIÊN QUÊ Ở ĐÂU ĐÓ, ĐÂU ĐÓ ĐƯA VÀO PROC
-- VIEW: IN RA AI Ở LONDON
-- VIEW: IN RA AI Ở KIRKLAND,...
-- MỖI VIEW LÀ 1 SELECT VÀ LÀ 1 TABLE ĐỂ REUSE
-- PROCEDURE IN RA KẾT QUẢ NHƯ VIEW, KO REUSE LẠI (CHỈ IN RA) NHƯNG LẠI NHẬN ĐC THAM SỐ

USE Northwind

GO

CREATE PROC PR_EmployeeListByCity
@city nvarchar(30)
AS
	SELECT * FROM Employees WHERE City = @city
GO

SELECT * FROM Employees WHERE City = 'Redmond'

EXEC PR_EmployeeListByCity @city = 'Redmond'

EXEC PR_EmployeeListByCity 'Seattle'

EXEC PR_EmployeeListByCity 'London'

-- ỨNG DỤNG THÊM CỦA PROCEDURE, VIẾT PROC INSERT DATA

USE DBDESIGN_PROGRAMMING

CREATE TABLE [Event]
(
	ID int IDENTITY PRIMARY KEY,
	Name nvarchar(30) NOT NULL
)

INSERT INTO [Event] VALUES(N'Lời nói dối chân thật') 
SELECT * FROM Event

GO 

CREATE PROC PR_InsertEvent
@name nvarchar(30)
AS 
  INSERT INTO [Event] VALUES(@name)
  
GO

--CHÈN CÁC DÒNG VÀO TABLE
EXEC PR_InsertEvent @name = N'Bí quyết dùng source ở FE'

EXEC PR_InsertEvent N'Hồ Sen chờ ai'

SELECT * FROM Event

