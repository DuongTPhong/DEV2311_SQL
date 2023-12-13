--1. Tạo csdl bằng lệnh T-SQL
-- syntax: CREATE DATABASE
-- tạo csdl đơn giản:
use master
Go	
CREATE DATABASE DEV2311LM_SQL
Go
-- Tạo CSDL với các thuộc tính cơ bản
CREATE DATABASE DEV2311LM_SQL
ON
(NAME = DEV2311LM_SQL_DATA,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.KHACHSAN\MSSQL\DATA\DEV2311LM_SQL.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
(NAME = DEV2311LM_SQL_log,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.KHACHSAN\MSSQL\DATA\DEV2311LM_SQL_log.ldf',
    SIZE = 5 MB,
    MAXSIZE = 25 MB,
    FILEGROWTH = 5 MB);
GO
--2. Tạo bảng và các ràng buộc dữ liệu trên bảng
-- Các kiểu dữ liệu thường dùng
/*
	-- Kiểu số: (số nguyên / số thực)
		++ Số nghuyên: tinyint / smallInt / int / bigInt
		++ Số thực: float / double / decimal / numeric
	-- Kiểu chuỗi: (non unicode / unicode) 
		++ non unicode: char / varchar / text
		++ unicode: nchar / nvarchar / ntext

		++ fixed length: char / nchar
		++ dynamic length: varchar / nvarchar
	-- Kiểu ngày giờ: smallDateTime / Datetime / date / time ...
	-- Kiểu logic: bit 
	-- Kiểu nhị phân: binary / 

	-- Tham khảo thêm: keyword (Datatype in SQL server)
*/

/*
	Các ràng buộc dữ liệu trên đối tượng table (column)
	-- null / not null
	-- Duy nhất: primary key / unique / thuộc tính identity / kiểu dữ liệu uniqueidentifier
	-- Ràng buộc tham chiếu (Khóa ngoại): foreign key
	-- Ràng buộc miền giá trị (Domain): DataType / check constraint
	-- Thuộc tính Default: 
	* ràng buộc phức tạp: => trigger
*/
-- Tạo cấu trúc bảng dữ liệu:
-- Syntax: CREATE TABLE
 USE [DEV2311LM_SQL]
GO
-- 2.1 Tạo bảng đơn giản:
CREATE TABLE TABLE1
(
	COL1 INT,
	COL2 VARCHAR(100)
)
GO
-- 2.2 Tạo bảng với ràng buộc khóa chính (Primary key)
-- VATTU(MAVTU, TENVTU, DVTINH, PHANTRAM)
CREATE TABLE VATTU
(
	MAVTU CHAR(4) CONSTRAINT PK_VATTU PRIMARY KEY,
	TENVTU NVARCHAR(200) NOT NULL,
	DVTINH NVARCHAR(20),
	PHANTRAM REAL
)
GO
-- note: tạo bảng dữ liệu với khóa chính trên 2 hay nhiều cột
CREATE TABLE TABLE2
(
	COL1 INT,
	COL2 INT,
	COL3 NVARCHAR(100),
	CONSTRAINT PK_TABLE1 PRIMARY KEY (COL1, COL2)
)
GO
-- 2.3 Tạo bảng với ràng buộc khóa chính và dữ liệu tự động tăng (identity)
-- TABLE(col1, col2, col3)
CREATE TABLE TABLE3
(
	COL1 INT IDENTITY(1,1) CONSTRAINT PK_TABLE3 PRIMARY KEY,
	COL2 NVARCHAR(100),
	COL3 TINYINT
)
GO
-- 2.4: Tạo bảng với ràng buộc duy nhất (unique)
-- NHACC(MACC, TENCC, DIACHI, DIENTHOAI)
-- PK[MANCC]
-- UQ[TENNCC]
CREATE TABLE NHACC
(
	MANHACC CHAR(3) CONSTRAINT PK_NHACC PRIMARY KEY,
	TENNHACC NVARCHAR(200) CONSTRAINT UQ_NHACC_TENNCC UNIQUE,
	DIACHI NVARCHAR(250),
	DIENTHOAI VARCHAR(50) NOT NULL CONSTRAINT UQ_NHACC_DIENTHOAI UNIQUE
)
GO
-- 2.5: Tạo bảng với thuộc tính default
-- NHACC(MACC, TENCC, DIACHI, DIENTHOAI)
-- PK[MANCC]
-- UQ[TENNCC], UQ_DIENTHOAI
-- DF[DIACHI] = 'HÀ NỘI'
DROP TABLE NHACC
GO
CREATE TABLE NHACC
(
	MANHACC CHAR(3) CONSTRAINT PK_NHACC PRIMARY KEY,
	TENNHACC NVARCHAR(200) CONSTRAINT UQ_NHACC_TENNCC UNIQUE,
	DIACHI NVARCHAR(250) CONSTRAINT DF_NHACC_DIACHI DEFAULT 'HÀ NỘI',	
	DIENTHOAI VARCHAR(50) NOT NULL CONSTRAINT UQ_NHACC_DIENTHOAI UNIQUE
)
GO
-- 2.6: Ràng buộc miền giá trị CHECK CONSTRAINT
-- CTDONDH(SODH, MAVTU, SLDAT)
-- PK[SODH, MAVTU]
-- CK[SLDAT]>0
CREATE TABLE CTDONDH
(
	SODH CHAR(4),
	MAVTU CHAR(4),
	SLDAT TINYINT CONSTRAINT CK_CTDONDH_SLDAT CHECK(SLDAT>0 AND SLDAT<150),
	CONSTRAINT PK_CTDONDH PRIMARY KEY(SODH, MAVTU)
)
GO
-- DONDH
CREATE TABLE DONDH
(
	SODH CHAR(4) CONSTRAINT PK_DONDH PRIMARY KEY,
	NGAYDH DATETIME CONSTRAINT DF_DONDH_NGAYDH DEFAULT GETDATE(),
	MANHACC CHAR(3),
)
GO
-- 2.7 Tạo bảng với ràng buộc khóa ngoại
-- CTDONDH(SODH, MAVTU, SLDAT)
-- PK[SODH, MAVTU]
-- CK[SLDAT]: SLDAT<150 VÀ SLDAT >0
-- FK[SODH] REFERENCES DONDH
-- FK[MAVTU] REFERENCES VATTU
DROP TABLE CTDONDH
GO
CREATE TABLE CTDONDH
(
	SODH CHAR(4) CONSTRAINT FK_CTDONDH_SODH FOREIGN KEY REFERENCES DONDH,
	MAVTU CHAR(4),-- CONSTRAINT FK_CTDONDH_VATTU_SODH FOREIGN KEY REFERENCES VATTU
	SLDAT TINYINT CONSTRAINT CK_CTDONDH_SLDAT CHECK(SLDAT>0 AND SLDAT<150),
	CONSTRAINT PK_CTDONDH PRIMARY KEY(SODH, MAVTU),
	CONSTRAINT FK_CTDONDH_VATTU_MAVTU FOREIGN KEY (MAVTU) REFERENCES VATTU
		ON UPDATE CASCADE --NO ACTION / SET NULL / SET DEFAULT
		ON DELETE NO ACTION -- CASCADE / SET NULL / SET DEFAULT
)
GO
-- 2.8: Sửa đổi bảng DONDH
-- BỔ SUNG KHÓA NGOẠI (MANHACC) THAM CHIẾU ĐẾN BẢNG NHACC
-- FK[MANHACC] ~ NHACC
-- SỬA ĐỔI THÊM RÀNG BUỘC:
ALTER TABLE DONDH
	ADD CONSTRAINT FK_DONDH_NHACC FOREIGN KEY (MANHACC) REFERENCES NHACC(MANHACC)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
GO
-- THÊM CỘT
ALTER TABLE DONDH
	ADD TONGTRIGIA NUMERIC(18,2)
GO
-- XÓA CỘT
ALTER TABLE DONDH
	DROP COLUMN TONGTRIGIA
GO
-- SỬA TÊN CỘT
EXEC sp_rename 'dbo.DONDH.TONGTRIGIAA','TONGTRIGIA', 'COLUMN';

-- PNHAP
CREATE TABLE PNHAP
(
	SOPN CHAR(4),
	MAVTU CHAR(4),
	SLNHAP INT,
	DGNHAP MONEY,
	CONSTRAINT PK_CTDONDH PRIMARY KEY(SOPN, MAVTU)
)
--3. Làm việc với các câu lệnh DML(Select/insert/update/delete)
-- 3.1: SELECT -> lọc / duyệt các bảng ghi từ nguồn dữ liệu
SELECT * FROM VATTU
GO
-- 3.2: INSERT
-- THÊM MỘT HAY NHIỀU BẢN GHI VÀO BẢNG
-- SYNTAX: (ĐƠN GIẢN)
-- THÊM MỘT BẢN GHI VÀO BẢNG
INSERT VATTU (MAVTU, TENVTU, DVTINH, PHANTRAM)
VALUES ('VT01', N'TỦ LẠNH LG', N'CHIẾC', 40)
GO
INSERT VATTU (MAVTU, TENVTU, DVTINH, PHANTRAM)
VALUES ('VT02', N'TỦ LẠNH SHARP', N'CHIẾC', 40)
GO

-- ghi chú: 
---	++ cột identity -> mặc định không thực hiện thêm giá trị cho cột này
--- ++ cột có giá trị mặc định hoặc null: có thể không cần thêm giá trị
--- ++ mặc định: khi thêm giá trị trên cột khóa ngoại, thì giá trị đó phải tồn tại trên cột tham chiếu  trên 1 bảng tương ứng
-- Thêm nhiều bản ghi vào bảng cùng lúc vào bảng
INSERT VATTU(MAVTU, TENVTU, DVTINH, PHANTRAM) VALUES
('VT03', N'TỦ LẠNH TOSHIBA', N'CHIẾC', 10),
('VT04', N'TỦ LẠNH TOSHIBA 5', N'CHIẾC', 15),
('VT05', N'TỦ LẠNH HITACHI ', N'CHIẾC', 18)

-- INSERT SELECT
INSERT VATTU (MAVTU, TENVTU, DVTINH, PHANTRAM)
SELECT 'VT06', N'TỦ LẠNH TOSHIBA 6', N'CHIẾC', 20
--
INSERT VATTU (MAVTU, TENVTU, DVTINH, PHANTRAM)
SELECT 'VT07', N'TỦ LẠNH TOSHIBA 7', N'CHIẾC', 25 UNION
SELECT 'VT08', N'TỦ LẠNH TOSHIBA 8', N'CHIẾC', 30


-------------
-- Ghi chú: 
/*
	- Dữ liệu chuỗi non unicode: đặt trong cặp nháy đơn ''
	- Dữ liệu chuỗi unicode: đặt trong cặp nháy đơn N''
	- Dữ liệu kiểu ngày: (Mặc định) -> đặt trong cặp dấu nháy đơn '', theo định dạng: mm/dd/yyyy | yyyy/mm/dd
	=> set dateformat dmy ?
*/
-- 3.3: Update -> sửa đổi dữ liệu trên cột trong bảng
-- xóa cũ, thêm mới
-- syntax:
/*
	Update <table_name> [source]
	Set <column_name> = <Giá trị> / [<Column_source>] [,...]
	[Where <condition>]
*/
-- cập nhật cột phantram trong bảng vật tư, tăng lên 10;
SELECT * FROM VATTU
--
UPDATE VATTU SET PHANTRAM = PHANTRAM + 10
GO
-- CẬP NHẬT CỘT PHẦN TRĂM TRONG BẢNG VẬT TƯ, TỈ LỆ PHẦN TRĂM GIẢM ĐI 10 CHO NHỮNG VẬT TƯ CÓ PHẦN TRĂM >= 50
UPDATE VATTU SET PHANTRAM = PHANTRAM - 10 WHERE PHANTRAM >=50
GO
-- 3.4: XÓA (DELETE)
-- SYNTAX: DELETE [FROM] <table_name> [where <condition>]
DELETE VATTU WHERE MAVTU = 'VT04'
GO
-- XÓA CÁC BẢN GHI VẬT TƯ CÓ PHẦN TRĂM <30
DELETE VATTU WHERE PHANTRAM < 30
GO

-- Ghi chú:
-- Khi xóa dữ liệu trên bảng mà có liên kết đến bảng bên nhiều thì chú ý đến điều kiện tham chiếu (ON DELETE NO ACTION)

-- 3.5 Xóa sạch (làm sạch vùng nhớ)
-- TRUNCATE TABLE <TABLE_NAME>
TRUNCATE TABLE VATTU
GO
-- Cannot truncate table 'VATTU' because it is being referenced by a FOREIGN KEY constraint.
TRUNCATE TABLE [dbo].[TABLE2]
GO

---