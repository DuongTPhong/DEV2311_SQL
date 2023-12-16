-- Less 04 

-- 1. Truy vấn với select đơn giản (không có from)
SELECT 'Devmaster'
GO
-- 2. Đặt tên cột cho dữ liệu trong tập kết quả 
SELECT 'Devmaster' as [Company]
GO
SELECT 'Devmaster' as 'Company'
GO
SELECT 'Devmaster' [Company Name]
GO
SELECT 'Company' = 'Devmaster'
-- 3. Truy vấn dữ liệu từ một bảng sử dụng dấu *
-- Liệt kê tất cả dữ liệu trong bảng khoa
-- (*)
SELECT * 
FROM KHOA
GO
-- 4. Lựa chọn các cột trong tập kết quả
SELECT MaKH, TenKH
FROM KHOA
GO
-- Liệt kê các thông tin masv, hosv, tensv, ngaysinh
SELECT MASV, HOSV, TENSV, NGAYSINH
FROM SINHVIEN
GO
-- 5. Sử dụng biểu thức trong select
-- Liệt kê các thông tin masv, hosv, ngaysinh, trong đó cột hoten được gộp từ hosv, tensv
SELECT MASV, HOSV + '' + TENSV as [Họ tên], NGAYSINH
FROM SINHVIEN
GO
-- Liệt kê các thông tin điểm thi của sinh viên, thêm cột điểm tăng 10%
SELECT * , [DIEM TANG] = DIEM*110/100
FROM KETQUA
-- 6. Sử dụng mệnh đề where để giới hạn dữ liệu trong tập kết quả (lọc, tìm kiếm)
-- WHERE <Biểu thức điều kiện>
/*
	- Điều kiện sử dụng các phép toán so sánh
		(>; >=; <=; =; <>; !=) => thường dùng với cột dữ liệu kiểu số
	- Điều kiện sử dụng các phép toán tương đối (áp dụng với dữ liệu kiểu chuỗi)
		+ Like / Not like:
			+++ các ký tự đại diện:
				++: dấu % đại diện cho chuỗi ký tự bất kỳ có thể rỗng
				++: dấu _ đại diện cho 1 ký tự bất kỳ
				++: [a-m]: khoảng ký tự từ a đến m
	- Sử dụng toán tử quan hệ (and, or, not) trong biểu thức điều kiện
	- Điều kiện so sánh tập hợp: IN / NOT IN

*/

/*
	SELECT
	FROM
	WHERE
*/
-- Liệt kê sinh viên có học bổng lớn hơn hoặc bằng 100000
SELECT *
FROM SINHVIEN 
WHERE HOCBONG >= 100000
GO
--Liệt kê sinh viên có học bổng trong khoảng 10.000 đến 100.000
SELECT *
FROM SINHVIEN 
WHERE HOCBONG >= 10000 AND HOCBONG <= 100000
GO
--
SELECT *
FROM SINHVIEN 
WHERE HOCBONG between 10000 AND 100000
GO
--- so sánh tương đối ( LIKE / NOT LIKE)
-- Liệt kê sinh viên có tên bắt đầu bằng 'T'
SELECT *
FROM SINHVIEN 
WHERE TENSV LIKE N'T%'
GO
-- Liệt kê sinh viên có tên chứa kí tự 'u'
SELECT *
FROM SINHVIEN 
WHERE TENSV LIKE N'%u%'
GO
-- Liệt kê sinh viên có tên mà ký tự thứ 2 là 'u'
SELECT *
FROM SINHVIEN 
WHERE TENSV LIKE N'_u%'
GO
-- Liệt kê sinh viên có tên chứa 3 kí tự
SELECT *
FROM SINHVIEN 
WHERE TENSV LIKE N'___'
GO
--
SELECT *
FROM SINHVIEN 
WHERE len(TENSV) = 3
GO
-- Liệt kê sinh viên có tên có chứa ký tự đầu tiên trong khoảng từ a-m
SELECT *
FROM SINHVIEN 
WHERE TENSV LIKE N'[a-m]%'
GO
-- Không chứa
SELECT *
FROM SINHVIEN 
WHERE TENSV NOT LIKE N'[a-m]%'
GO
--
SELECT *
FROM SINHVIEN 
WHERE TENSV LIKE N'[^a-m]%'
GO
-- Sử dụng tập hợp 
-- Liệt kê sinh viên có tháng sinh là tháng 2 và tháng 8
SELECT [MaSV], [HoSV], [TenSV], [Phai], [NgaySinh], [NoiSinh], [MaKH], [HocBong], [DiemTrungBinh]
FROM SINHVIEN
WHERE MONTH(NGAYSINH) = 2 OR MONTH(NGAYSINH) = 8
GO
SELECT [MaSV], [HoSV], [TenSV], [Phai], [NgaySinh], [NoiSinh], [MaKH], [HocBong], [DiemTrungBinh]
FROM SINHVIEN
WHERE MONTH(NGAYSINH) IN (2,8)
GO
--================================
-- 7. Sắp xếp dữ liệu trong tập kết quả
-- sắp tăng: ORDER BY <column_Name> | <index> | <alise name> ASC (Mặc định)
-- sắp giảm: ORDER BY DESC
-- Liệt kê sinh viên, dữ liệu sắp theo tên sinh viên tăng dần
SELECT  MASV, HOSV AS [HỌ SINH VIÊN], TENSV AS [TÊN SINH VIÊN]
FROM SINHVIEN
ORDER BY TENSV ASC
--
SELECT  MASV, HOSV AS [HỌ SINH VIÊN], TENSV AS [TÊN SINH VIÊN]
FROM SINHVIEN
ORDER BY 3 ASC
--
SELECT  MASV, HOSV AS [HỌ SINH VIÊN], TENSV AS [TÊN SINH VIÊN]
FROM SINHVIEN
ORDER BY [TÊN SINH VIÊN] ASC
-- DESC
SELECT  MASV, HOSV AS [HỌ SINH VIÊN], TENSV AS [TÊN SINH VIÊN]
FROM SINHVIEN
ORDER BY TENSV DESC
-- 


-- Luyện tập
-- 1. Cho biết danh sách các môn học, gồm các thông tin sau: Mã môn học, Tên môn học, Số tiết.
SELECT  * 
FROM MONHOC
-- 2.Liệt kê danh sách sinh viên, gồm các thông tin sau: Mã sinh viên, Họ sinh viên, Tên sinh viên, Học bổng. 
--Danh sách sẽ được sắp xếp theo thứ tự Mã sinh viên tăng dần.
SELECT  MASV, HOSV, TENSV, HocBong 
FROM SINHVIEN
ORDER BY MaSV ASC
--3. Danh sách các sinh viên, gồm các thông tin sau: Mã sinh viên, Tên sinh viên, Phái, Ngày sinh. 
--Danh sách sẽ được sắp xếp theo thứ tự của tên.
SELECT  MASV, HOSV, TENSV, HocBong 
FROM SINHVIEN
ORDER BY TenSV ASC
-- 4. Thông tin các sinh viên gồm: Họ tên sinh viên, Ngày sinh, Học bổng. 
-- Thông tin sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần.


/*
15. Cho biết các sinh viên sinh sau ngày 20/12/1977, gồm các thông tin: Họ tên
sinh viên, Ngày sinh, Nơi sinh, Học bổng. Danh sách sẽ được sắp xếp theo
thứ tự ngày sinh giảm dần.
*/

set dateformat dmy
go
SELECT  HOSV, TENSV, CONVERT(VARCHAR(10),NGAYSINH,103) AS 'NGAYSINH',NOISINH, HocBong 
FROM SINHVIEN
WHERE NgaySinh > '12/20/1977'
ORDER BY NgaySinh DESC


--====================
-- 7. sử dụng từ khóa TOP trong select
-- TOP: trích ra số bản ghi đầu tiên trong tập kết quả
SELECT *
FROM SINHVIEN
GO
SELECT TOP 1*
FROM SINHVIEN
GO
SELECT TOP 5*
FROM SINHVIEN
GO
-- TOP 50%
SELECT TOP 50 PERCENT *
FROM SINHVIEN
GO
-- Lấy ra sinh viên có học bổng cao nhất
SELECT TOP 1*
FROM SINHVIEN
ORDER BY HocBong DESC
GO
-- Lấy ra những sinh viên có học bổng cao nhất
SELECT TOP 1 WITH TIES*
FROM SINHVIEN
ORDER BY HocBong DESC
GO

--===================
-- 8. Sử dụng từ khóa DISTINCT TRONG SELEC
-- DISTINCT: Loại bỏ dòng trùng lặp (giữ lại 1)
SELECT * 
FROM SINHVIEN
GO -- các bản ghi là duy nhất (PK)

SELECT MaKH
FROM SINHVIEN
GO -- lặp -> 15 bản ghi

SELECT distinct MaKH
FROM SINHVIEN
GO

--===========================
-- 9. case ... when ... then trong select
--: Liệt kê sinh viên, trong đó phái hiển thị là: 0 ~ Nam; 1 ~ Nữ; null ~ Khác
SELECT [MaSV], [HoSV], [TenSV], [Phai] = CASE PHAI
											WHEN 0 THEN N'NAM'
											WHEN 1 THEN N'NỮ'
											ELSE N'KHÁC'
										END
, [NgaySinh], [NoiSinh], [MaKH], [HocBong], [DiemTrungBinh]
FROM SINHVIEN
GO
--========================================================
--10. Sử dụng hàm IIF => IIF( boolean_expression, true_value, false_value)
SELECT [MaSV], [HoSV], [TenSV], [Phai] = IIF (PHAI =0, N'NAM', IIF (PHAI =1,N'NỮ', N'KHÁC'))									
, [NgaySinh], [NoiSinh], [MaKH], [HocBong], [DiemTrungBinh]
FROM SINHVIEN
GO
--========================================================
--11. Truy vấn kết hợp 2 hay nhiều bảng (JOIN)
/*
	INNER JOIN
	LEFT JOIN / LEFT OUTER JOIN
	RIGHT JOIN / RIGHT OUTER JOIN
	FULL JOIN / FULL OUTER JOIN
*/
-- INNER JOIN:
SELECT *
FROM KHOA AS K
	JOIN SINHVIEN S ON K.MaKH = S.MaKH
GO
SELECT *
FROM KHOA AS K, SINHVIEN AS S
WHERE K.MaKH = S.MaKH
GO -- SO SÁNH
-- LEFT JOIN:
SELECT *
FROM KHOA AS K
	LEFT JOIN SINHVIEN S ON K.MaKH = S.MaKH
GO
-- RIGHT JOIN:
SELECT *
FROM KHOA AS K
	RIGHT JOIN SINHVIEN S ON K.MaKH = S.MaKH
GO
-- FULL JOIN:
SELECT *
FROM KHOA AS K
	FULL JOIN SINHVIEN S ON K.MaKH = S.MaKH
GO
-- Liệt kê các thông tin MAKH, TENKH, HOTEN, NGAYSINH, PHAI, HOCBONG
SELECT * 
FROM KHOA AS K
	JOIN SINHVIEN AS S ON K.MaKH= S.MaKH
GO
-- Liệt kê các thông tin: MAKH, TENKH, HOSV, TENSV, PHAI, DIEM
-- KHOA, SINHVIEN, KETQUA
SELECT K.MAKH, S.MASV, TENKH, HOSV, TENSV, PHAI, DIEM
FROM KHOA AS K
	JOIN SINHVIEN AS S ON K.MaKH = S.MaKH
	JOIN KETQUA AS Q ON S.MASV = Q.MASV
GO
-- DESIGNER


--- Luyện tập lab04
-- Nghiên cứu truy vấn gộp nhóm / điều kiện gộp nhóm
-- truy vấn con
-- truy vấn tham chiếu