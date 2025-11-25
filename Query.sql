CREATE DATABASE DW_MeBe;
GO

USE DW_MeBe;
GO

CREATE LOGIN [NT SERVICE\MSSQLServerOLAPService] FROM WINDOWS;
go

CREATE USER [NT SERVICE\MSSQLServerOLAPService] FOR LOGIN [NT SERVICE\MSSQLServerOLAPService];
GO

ALTER ROLE db_owner ADD MEMBER [NT SERVICE\MSSQLServerOLAPService];

CREATE TABLE Dim_Customer (
    CustomerID INT PRIMARY KEY,
    HoTen NVARCHAR(100),
    GioiTinh NVARCHAR(10),
    NgaySinhCon DATE,
    DiaChi NVARCHAR(255),
    KhuVuc NVARCHAR(50)
);

CREATE TABLE Dim_Product (
    ProductID INT PRIMARY KEY,
    TenSanPham NVARCHAR(100),
    LoaiSanPham NVARCHAR(100),
    DonGia DECIMAL(18,2),
    ThuongHieu NVARCHAR(50)
);

CREATE TABLE Dim_Date (
    DateID INT PRIMARY KEY,
    Ngay INT,
    Thang INT,
    Quy INT,
    Nam INT
);
	
	CREATE TABLE Dim_Store (
    StoreID INT PRIMARY KEY,
    TenCuaHang NVARCHAR(100),
    TinhThanh NVARCHAR(50),
    KhuVuc NVARCHAR(50)
);

CREATE TABLE Fact_Sales (
    FactID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    DateID INT,
    StoreID INT,
    SoLuongMua INT,
    DoanhThu DECIMAL(18,2),

    FOREIGN KEY (CustomerID) REFERENCES Dim_Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Dim_Product(ProductID),
    FOREIGN KEY (DateID) REFERENCES Dim_Date(DateID),
    FOREIGN KEY (StoreID) REFERENCES Dim_Store(StoreID)
);

INSERT INTO Dim_Customer VALUES
(1, 'Nguyễn Thị Lan', 'Nữ', '2024-11-10', 'Hà Nội', 'Thành thị'),
(2, 'Trần Minh Hoàng', 'Nam', '2024-08-02', 'Nghệ An', 'Nông thôn'),
(3, 'Phạm Thị Hương', 'Nữ', '2025-01-15', 'Hồ Chí Minh', 'Thành thị'),
(4, 'Lê Thu Thảo', 'Nữ', NULL, 'Hải Dương', 'Nông thôn'),
(5, 'Hoàng Quốc Việt', 'Nam', '2024-12-20', 'Đà Nẵng', 'Thành thị');

INSERT INTO Dim_Product VALUES
(101, 'Sữa Meiji 800g', 'Sữa', 450000, 'Meiji'),
(102, 'Bỉm Moony XL', 'Bỉm', 320000, 'Moony'),
(103, 'Khăn ướt Mamamy', 'Khăn ướt', 45000, 'Mamamy'),
(104, 'Quần áo sơ sinh', 'Quần áo', 99000, 'Bibabo'),
(105, 'Bình sữa Pigeon 200ml', 'Phụ kiện', 180000, 'Pigeon');

INSERT INTO Dim_Store VALUES
(1, 'Mẹ Bé Hoàng Mai', 'Hà Nội', 'Thành thị'),
(2, 'Mẹ Bé Cầu Giấy', 'Hà Nội', 'Thành thị'),
(3, 'Mẹ Bé Vinh', 'Nghệ An', 'Nông thôn');

INSERT INTO Dim_Date VALUES
(20250101, 1, 1, 1, 2025),
(20250102, 2, 1, 1, 2025),
(20250103, 3, 1, 1, 2025),
(20250104, 4, 1, 1, 2025),
(20250105, 5, 1, 1, 2025);

INSERT INTO Fact_Sales VALUES
(1, 1, 101, 20250101, 1, 2, 900000),
(2, 1, 102, 20250102, 1, 1, 320000),
(3, 2, 103, 20250103, 3, 5, 225000),
(4, 3, 102, 20250101, 2, 2, 640000),
(5, 3, 104, 20250105, 2, 3, 297000),
(6, 5, 105, 20250103, 1, 1, 180000);


UPDATE Dim_Customer SET HoTen = 'Nguyen Thi Lan', GioiTinh = 'Nu', DiaChi = 'Ha Noi', KhuVuc = 'Thanh thi' WHERE CustomerID = 1;
UPDATE Dim_Customer SET HoTen = 'Tran Minh Hoang', GioiTinh = 'Nam', DiaChi = 'Nghe An', KhuVuc = 'Nong thon' WHERE CustomerID = 2;
UPDATE Dim_Customer SET HoTen = 'Pham Thi Huong', GioiTinh = 'Nu', DiaChi = 'Ho Chi Minh', KhuVuc = 'Thanh thi' WHERE CustomerID = 3;
UPDATE Dim_Customer SET HoTen = 'Le Thu Thao', GioiTinh = 'Nu', DiaChi = 'Hai Duong', KhuVuc = 'Nong thon' WHERE CustomerID = 4;
UPDATE Dim_Customer SET HoTen = 'Hoang Quoc Viet', GioiTinh = 'Nam', DiaChi = 'Da Nang', KhuVuc = 'Thanh thi' WHERE CustomerID = 5;


UPDATE Dim_Product SET TenSanPham = 'Sua Meiji 800g', LoaiSanPham = 'Sua' WHERE ProductID = 101;
UPDATE Dim_Product SET TenSanPham = 'Bim Moony XL', LoaiSanPham = 'Bim' WHERE ProductID = 102;
UPDATE Dim_Product SET TenSanPham = 'Khan uot Mamamy', LoaiSanPham = 'Khan uot' WHERE ProductID = 103;
UPDATE Dim_Product SET TenSanPham = 'Quan ao so sinh', LoaiSanPham = 'Quan ao' WHERE ProductID = 104;
UPDATE Dim_Product SET TenSanPham = 'Binh sua Pigeon 200ml', LoaiSanPham = 'Phu kien' WHERE ProductID = 105;


UPDATE Dim_Store SET TenCuaHang = 'Me Be Hoang Mai', TinhThanh = 'Ha Noi', KhuVuc = 'Thanh thi' WHERE StoreID = 1;
UPDATE Dim_Store SET TenCuaHang = 'Me Be Cau Giay', TinhThanh = 'Ha Noi', KhuVuc = 'Thanh thi' WHERE StoreID = 2;
UPDATE Dim_Store SET TenCuaHang = 'Me Be Vinh', TinhThanh = 'Nghe An', KhuVuc = 'Nong thon' WHERE StoreID = 3;
