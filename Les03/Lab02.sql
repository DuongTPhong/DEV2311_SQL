-- Tạo csdl có tên Lab02
CREATE DATABASE Lab02;
GO

-- Gọi csdl ra sử dụng
USE Lab02;
GO

-- Khai báo biến Name, gán giá trị và in ra
DECLARE @Name NVARCHAR(50);
SET @Name = 'Duong Phong ';
PRINT 'Name: ' + @Name;
GO
-- Khai báo biến Age, gán giá trị và in ra
DECLARE @Age INT;
SET @Age = 21;
PRINT 'Age: ' + CAST(@Age AS NVARCHAR(10));
GO
-- Tạo bảng Employee
CREATE TABLE Employee (
    ID INT PRIMARY KEY,
    FullName NVARCHAR(35),
    Gender BIT,
    Birthday DATETIME,
    Address NVARCHAR(MAX),
    Email VARCHAR(50),
    Salary FLOAT
);
GO
-- Thêm cột phone cho bảng Employee
ALTER TABLE Employee
ADD Phone VARCHAR(20);
GO
-- Nhập vào tối thiểu 5 bản ghi
INSERT INTO Employee (ID, FullName, Gender, Birthday, Address, Email, Salary, Phone)
VALUES
    (1, N'Dương Phong', 1, '2002-05-15', N'Hà nội', 'duongphong@gmail.com', 2500000, '0123456789'),
    (2, N'Nguyễn Hoàng', 0, '2002-10-10', N'Hà nội', 'nguyenhoang@example.com', 1800000, '0987654321'),
    (3, N'Nguyễn Thăng', 1, '2002-02-15', N'Hải Dương', 'nguyenthang@example.com', 2200000, '0456789123'),
    (4, 'ABC', 0, '2000-11-25', 'Da Nang', 'abc1@example.com', 3000000, '0789123456'),
    (5, 'Employee1', 1, '2001-04-03', 'Hanoi', 'employee1@example.com', 2100000, '0321654987');
GO
-- Đưa ra tất cả các nhân viên trong công ty
SELECT * FROM Employee;

-- Đưa ra các nhân viên có lương > 2000000
SELECT * FROM Employee WHERE Salary > 2000000;

-- Đưa ra các nhân viên có sinh nhật trong tháng này
SELECT * FROM Employee WHERE MONTH(Birthday) = MONTH(GETDATE());

-- Đưa ra danh sách nhân viên hiển thị kèm thêm cột tuổi và cột BirthDay hiển thị dạng dd/mm/yyyy
SELECT
    ID,
    FullName,
    Gender,
    Birthday,
    Address,
    Email,
    Salary,
    Phone,
    DATEDIFF(YEAR, Birthday, GETDATE()) AS Age,
    FORMAT(Birthday, 'dd/MM/yyyy') AS FormattedBirthday
FROM Employee;
GO
-- Đưa ra những nhân viên có địa chỉ ở Hà Nội
SELECT * FROM Employee WHERE Address = 'Hanoi';

-- Sửa tên nhân viên có mã là "NV01" thành tên "John"
UPDATE Employee SET FullName = 'John' WHERE ID = 1;

-- Xóa những nhân viên có tuổi > 50
DELETE FROM Employee WHERE DATEDIFF(YEAR, Birthday, GETDATE()) > 50;

-- Copy những nhân viên có tuổi > 50 sang một bảng mới
SELECT *
INTO ElderlyEmployee
FROM Employee
WHERE DATEDIFF(YEAR, Birthday, GETDATE()) > 50;

-- Đếm số nhân viên
SELECT COUNT(*) AS NumberOfEmployees FROM Employee;
