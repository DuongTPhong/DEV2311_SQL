--Bài 1: Viết những truy vấn lọc và sắp xếp dữ liệu 

-- 1. Danh sách các môn học:
SELECT MaMH, TenMH, Sotiet
FROM MonHoc;
-- 2. Danh sách sinh viên sắp xếp theo Mã sinh viên tăng dần:
SELECT MaSV, HoSV, TenSV, HocBong
FROM SinhVien
ORDER BY MaSV ASC;
-- 3. Danh sách sinh viên sắp xếp theo tên:
SELECT MaSV, TenSV, Phai, NgaySinh
FROM SinhVien
ORDER BY TenSV;
-- 4. Thông tin sinh viên sắp xếp theo Ngày sinh tăng dần và Học bổng giảm dần:
SELECT HoSV + ' ' + TenSV AS HoTen, NgaySinh, HocBong
FROM SinhVien
ORDER BY NgaySinh ASC, HocBong DESC;
-- 5. Danh sách các môn học có tên bắt đầu bằng chữ 'T':
SELECT MaMH, TenMH, Sotiet
FROM MonHoc
WHERE TenMH LIKE 'T%';
-- 6. Danh sách sinh viên có chữ cái cuối cùng trong tên là 'i':
SELECT HoSV + ' ' + TenSV AS HoTen, NgaySinh, Phai
FROM SinhVien
WHERE SUBSTRING(TenSV, LEN(TenSV), 1) = 'i';
--7. Danh sách khoa có ký tự thứ hai của tên khoa có chứa chữ 'N':
SELECT MaKH, TenKH
FROM Khoa
WHERE SUBSTRING(TenKH, 2, 1) LIKE 'N%';
--8. Danh sách sinh viên mà họ có chứa chữ 'Thị':
SELECT HoSV + ' ' + TenSV AS HoTen, NgaySinh, Phai
FROM SinhVien
WHERE HoSV LIKE '%Thị%';
--9. Danh sách sinh viên ký tự đầu tiên của tên nằm trong khoảng từ a đến m:
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, Phai, HocBong
FROM SinhVien
WHERE ASCII(LEFT(TenSV, 1)) BETWEEN ASCII('a') AND ASCII('m');
--10. Danh sách sinh viên tên chứa ký tự trong khoảng từ a đến m, sắp xếp tăng dần theo họ tên:
SELECT HoSV + ' ' + TenSV AS HoTen, NgaySinh, NoiSinh, HocBong
FROM SinhVien
WHERE TenSV COLLATE SQL_Latin1_General_CP1_CI_AS BETWEEN 'a' AND 'm'
ORDER BY HoTen;
-- 11. Danh sách sinh viên của khoa Anh văn:
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, NgaySinh, MaKH
FROM SinhVien
WHERE MaKH = 'AV';
--12. Danh sách sinh viên của khoa Vật Lý, sắp xếp theo Ngày sinh giảm dần:
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, NgaySinh
FROM SinhVien
WHERE MaKH = 'VL'
ORDER BY NgaySinh DESC;
--13. Danh sách sinh viên có học bổng lớn hơn 500,000, sắp xếp theo Mã khoa giảm dần:
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, MaKH, HocBong
FROM SinhVien
WHERE HocBong > 500000
ORDER BY MaKH DESC;
--14. Danh sách sinh viên sinh vào ngày 20/12/1987:
SELECT HoSV + ' ' + TenSV AS HoTen, MaKH, HocBong
FROM SinhVien
WHERE NgaySinh = '1987-12-20';
--15. Danh sách sinh viên sinh sau ngày 20/12/1977, sắp xếp theo ngày sinh giảm dần:
SELECT HoSV + ' ' + TenSV AS HoTen, NgaySinh, NoiSinh, HocBong
FROM SinhVien
WHERE NgaySinh > '1977-12-20'
ORDER BY NgaySinh DESC;
--16. Danh sách sinh viên có học bổng lớn hơn 100,000 và sinh ở Tp HCM:
SELECT HoSV + ' ' + TenSV AS HoTen, MaKH, NoiSinh, HocBong
FROM SinhVien
WHERE HocBong > 100000 AND NoiSinh = 'Tp. HCM';
--17. Danh sách sinh viên của khoa Anh văn và khoa Triết:
SELECT MaSV, MaKH, Phai
FROM SinhVien
WHERE MaKH IN ('AV', 'TR');
--18. Sinh viên có ngày sinh từ ngày 01/01/1986 đến ngày 05/06/1992:
SELECT MaSV, NgaySinh, NoiSinh, HocBong
FROM SinhVien
WHERE NgaySinh BETWEEN '1986-01-01' AND '1992-06-05';
--19. Sinh viên có học bổng từ 200,000 đến 800,000:
SELECT MaSV, NgaySinh, Phai, MaKH
FROM SinhVien
WHERE HocBong BETWEEN 200000 AND 800000;
--20. Môn học có số tiết lớn hơn 40 và nhỏ hơn 60:
SELECT MaMH, TenMH, Sotiet
FROM MonHoc
WHERE Sotiet > 40 AND Sotiet < 60;
--21. Sinh viên nam của khoa Anh văn:
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, Phai
FROM SinhVien
WHERE Phai = 0 AND MaKH = 'AV';
--22. Sinh viên có nơi sinh ở Hà Nội và ngày sinh sau ngày 01/01/1990:
SELECT HoSV, TenSV, NoiSinh, NgaySinh
FROM SinhVien
WHERE NoiSinh = 'Hà Nội' AND NgaySinh > '1990-01-01';
--23. Sinh viên nữ, tên có chứa chữ N:
SELECT HoSV + ' ' + TenSV AS HoTen, Phai
FROM SinhVien
WHERE Phai = 1 AND (CHARINDEX('N', TenSV) > 0 OR CHARINDEX('n', TenSV) > 0);
--24. Nam sinh viên khoa Tin Học có ngày sinh sau ngày 30/5/1986:
SELECT MaSV, HoSV + ' ' + TenSV AS HoTen, NgaySinh
FROM SinhVien
WHERE Phai = 0 AND MaKH = 'TH' AND NgaySinh > '1986-05-30';
--25. Danh sách sinh viên với giới tính (Nam/Nữ) và Ngày sinh:
SELECT HoSV + ' ' + TenSV AS HoTen, CASE WHEN Phai = 0 THEN 'Nam' ELSE 'Nữ' END AS GioiTinh, NgaySinh
FROM SinhVien;
--26. Danh sách sinh viên với thông tin Mã sinh viên, Tuổi, Nơi sinh, Mã khoa:
SELECT MaSV, YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi, NoiSinh, MaKH
FROM SinhVien;
--27. Sinh viên có tuổi lớn hơn 20, thông tin gồm: Họ tên sinh viên, Tuổi, Học bổng:
SELECT HoSV + ' ' + TenSV AS HoTen, YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi, HocBong
FROM SinhVien
WHERE YEAR(GETDATE()) - YEAR(NgaySinh) > 20;
--28. Danh sách sinh viên có tuổi từ 20 đến 30, thông tin gồm: Họ tên sinh viên, Tuổi, Tên khoa:
SELECT HoSV + ' ' + TenSV AS HoTen, YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi, TenKH
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE YEAR(GETDATE()) - YEAR(NgaySinh) BETWEEN 20 AND 30;

--=====================================================================================
-- Truy vấn con  
-- 1.
SELECT MaSV, MaKH, Phai
FROM SinhVien SV
WHERE NOT EXISTS (SELECT 1 FROM Ketqua K WHERE SV.MaSV = K.MaSV);
-- 2.
SELECT SV.MaSV, SV.HoSV + ' ' + SV.TenSV AS HoTen, SV.MaKH
FROM SinhVien SV
WHERE NOT EXISTS (SELECT 1 FROM Ketqua K WHERE SV.MaSV = K.MaSV AND K.MaMH = '01');
-- 3. 
SELECT M.MaMH, M.TenMH, M.Sotiet
FROM MonHoc M
WHERE NOT EXISTS (SELECT 1 FROM Ketqua K WHERE M.MaMH = K.MaMH);
-- 4.
SELECT K.MaKH, K.TenKH
FROM Khoa K
WHERE NOT EXISTS (SELECT 1 FROM SinhVien SV WHERE K.MaKH = SV.MaKH);
-- 5.
SELECT SV.MaSV, SV.HoSV + ' ' + SV.TenSV AS HoTen, SV.MaKH
FROM SinhVien SV
WHERE SV.MaKH = 'AV' AND NOT EXISTS (SELECT 1 FROM Ketqua K WHERE SV.MaSV = K.MaSV AND K.MaMH = '01');
-- 6.
SELECT M.MaMH, M.TenMH, M.Sotiet
FROM MonHoc M
WHERE NOT EXISTS (SELECT 1 FROM Ketqua K JOIN SinhVien SV ON K.MaSV = SV.MaSV WHERE SV.MaKH = 'LY' AND M.MaMH = K.MaMH);
-- 7.
SELECT K1.MaSV, K1.MaMH, K1.Diem
FROM Ketqua K1
JOIN SinhVien SV ON K1.MaSV = SV.MaSV
WHERE K1.MaMH = '04' AND K1.Diem < (SELECT MIN(K2.Diem) FROM Ketqua K2 JOIN SinhVien SV2 ON K2.MaSV = SV2.MaSV WHERE SV2.MaKH = 'TH' AND K2.MaMH = '04');
-- 8.
SELECT SV.MaSV, SV.HoSV + ' ' + SV.TenSV AS HoTen, SV.NgaySinh
FROM SinhVien SV
WHERE SV.NgaySinh > (SELECT MIN(NgaySinh) FROM SinhVien WHERE MaKH = 'AV');
-- 9.
SELECT SV.MaSV, SV.HocBong
FROM SinhVien SV
WHERE SV.HocBong > (SELECT SUM(HocBong) FROM SinhVien WHERE MaKH = 'TR');
-- 10.
SELECT SV.MaSV, SV.HoSV + ' ' + SV.TenSV AS HoTen, SV.NoiSinh
FROM SinhVien SV
WHERE SV.NoiSinh = (SELECT TOP 1 SV2.NoiSinh FROM SinhVien SV2 WHERE SV2.MaKH = 'LY' ORDER BY SV2.HocBong DESC);
-- 11.
SELECT K1.MaSV, SV.HoSV + ' ' + SV.TenSV AS HoTen, K1.MaMH, M.TenMH, K1.Diem
FROM Ketqua K1
JOIN SinhVien SV ON K1.MaSV = SV.MaSV
JOIN MonHoc M ON K1.MaMH = M.MaMH
WHERE K1.Diem = (SELECT MAX(K2.Diem) FROM Ketqua K2 WHERE K2.MaMH = K1.MaMH);
-- 12.
SELECT SV.MaSV, K.TenKH, SV.HocBong
FROM SinhVien SV
JOIN Khoa K ON SV.MaKH = K.MaKH
WHERE SV.HocBong = (SELECT MAX(SV2.HocBong) FROM SinhVien SV2 WHERE SV2.MaKH = SV.MaKH);
--=====================================================================================
-- Thêm dữ liệu vào cơ sở dữ liệu 
-- 1.
INSERT INTO SinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKH, HocBong)
VALUES ('C01', 'Lê Thành', 'Nguyên', 1, '1980-10-20', 'Thành phố Hồ Chí Minh', 'TH', 850000);
-- 2. 
INSERT INTO MonHoc (MaMH, TenMH, Sotiet)
VALUES ('06', 'Xử lý ảnh', 45);
-- 3. 
INSERT INTO Khoa (MaKH, TenKH)
VALUES ('CT', 'Công trình');
-- 4.
INSERT INTO SinhVien (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKH, HocBong)
VALUES ('C02', 'Nguyễn Trần', 'Quân', 1, GETDATE(), 'Huế', 'CT', 950000);
-- 5.
INSERT INTO Ketqua (MaSV, MaMH, Diem)
SELECT SV.MaSV, '06', 7
FROM SinhVien SV
INNER JOIN Khoa KH ON SV.MaKH = KH.MaKH
WHERE KH.TenKH = 'Tin học';
--6.
INSERT INTO Ketqua (MaSV, MaMH, Diem)
SELECT 'C02', MaMH, 8
FROM MonHoc;
--=====================================================================================
-- Xoá thông tin trong cơ sở dữ liệu 
-- 1.
CREATE TABLE DeleteTable (
    [MaSV] [nvarchar](3) NOT NULL,
    [HoTen] [nvarchar](max) NOT NULL,
    [Phai] [bit] NOT NULL,
    [NgaySinh] [smalldatetime] NOT NULL,
    [NoiSinh] [nvarchar](100) NOT NULL,
    [TenKhoa] [nvarchar](50) NOT NULL,
    [HocBong] [float] NULL
);
-- 2.
DELETE FROM DeleteTable
WHERE HocBong IS NULL;
-- 3.
DELETE FROM DeleteTable
WHERE NgaySinh = '1987-12-20';
-- 4.
DELETE FROM DeleteTable
WHERE NgaySinh < '1987-03-01';
-- 5.
DELETE FROM DeleteTable
WHERE Phai = 1 AND TenKhoa = 'Tin học';
--=====================================================================================
-- Cập nhật thông tin trong cơ sở dữ liệu  
-- 1.
UPDATE MonHoc
SET Sotiet = 45
WHERE MaMH = 'Văn';
-- 2.
UPDATE SinhVien
SET TenSV = 'Kỳ'
WHERE HoSV = 'Trần Thanh' AND TenSV = 'Mai';
-- 3.
UPDATE SinhVien
SET Phai = 1
WHERE HoSV = 'Trần Thanh' AND TenSV = 'Kỳ';
-- 4
UPDATE SinhVien
SET NgaySinh = '1990-07-05'
WHERE HoSV = 'Trần Thị Thu' AND TenSV = 'Thuỷ';
-- 5.
UPDATE SinhVien
SET HocBong = HocBong + 100000
WHERE MaKH = 'AV';
-- 6.
UPDATE Ketqua
SET Diem = CASE
    WHEN Diem + 5 > 10 THEN 10
    ELSE Diem + 5
END
WHERE MaMH = '02' AND MaSV IN (SELECT MaSV FROM SinhVien WHERE MaKH = 'AV');

