create database qlbh;
use qlbh;
create table khachhang
(
    maKh     nvarchar(4) primary key,
    tenKh    nvarchar(30),
    diaChi   nvarchar(50),
    ngaySinh datetime,
    soDT     nvarchar(15) unique
);

create table nhanVien
(
    MaNV       nvarchar(4) primary key,
    hoTen      nvarchar(30),
    gioiTinh   bit,
    diaChi     nvarchar(50),
    ngaySinh   datetime,
    dienThoai  nvarchar(15),
    email      text,
    noiSinh    nvarchar(20),
    ngayVaoLam datetime,
    maSQL      nvarchar(4)
);

create table nhaCungCap
(
    maNCC     nvarchar(5) primary key,
    tenNCC    nvarchar(50),
    diaChi    nvarchar(50),
    dienThoai nvarchar(15),
    email     nvarchar(30),
    website   nvarchar(30)
);

create table phieuNhap
(
    soPN     nvarchar(5) primary key,
    maNV     nvarchar(4),
    maNCC    nvarchar(5),
    ngayNhap datetime default now(),
    ghiChu   nvarchar(100),
    foreign key (maNV) references nhanVien (MaNV),
    foreign key (maNCC) references nhaCungCap (maNCC)
);

create table loaiSP
(
    maLoaiSP  nvarchar(4) primary key,
    tenLoaiSP nvarchar(30),
    ghiChu    nvarchar(100)
);

create table phieuXuat
(
    soPX    nvarchar(5) primary key,
    maNV    nvarchar(4),
    maKH    nvarchar(4),
    ngayBan datetime,
    ghiChu  text,
    foreign key (maNV) references nhanVien (MaNV),
    foreign key (maKH) references khachhang (maKh)
);

create table sanPham
(
    maSP      nvarchar(4) primary key,
    maLoaiSP  nvarchar(4),
    tenSP     nvarchar(50),
    donViTinh nvarchar(10),
    ghiChu    nvarchar(100),
    foreign key (maLoaiSP) references loaiSP (maLoaiSP)
);

create table ctPhieuXuat
(
    soPX    nvarchar(5),
    maSP    nvarchar(4),
    soLuong smallint,
    giaBan  real,
    check ( soLuong >= 0 and giaBan >= 0),
    primary key (soPX, maSP),
    foreign key (soPX) references phieuXuat (soPX),
    foreign key (maSP) references sanPham (maSP)
);

create table ctPhieuNhap
(
    maSP    nvarchar(4),
    soPN    nvarchar(5),
    soLuong smallint default (0),
    giaNhap real CHECK (giaNhap > 0),
    primary key (maSP, soPN),
    foreign key (maSP) references sanPham (maSP),
    foreign key (soPN) references phieuNhap (soPN)
);

-- Thêm dữ liệu vào bảng khachhang
INSERT INTO khachhang (maKh, tenKh, diaChi, ngaySinh, soDT)
VALUES ('KH01', 'Nguyễn Văn A', 'Hà Nội', '1990-01-01', '0123456789'),
       ('KH02', 'Trần Thị B', 'Hồ Chí Minh', '1995-02-15', '0987654321'),
       ('KH03', 'Lê Văn C', 'Đà Nẵng', '1992-07-10', '0369876543'),
       ('KH04', 'Phạm Thị D', 'Hải Phòng', '1998-04-20', '0932145678'),
       ('KH05', 'Nguyễn Thị E', 'Huế', '1993-12-05', '0765432198');

-- Thêm dữ liệu vào bảng nhanVien
INSERT INTO nhanVien (MaNV, hoTen, gioiTinh, diaChi, ngaySinh, dienThoai, email, noiSinh, ngayVaoLam, maSQL)
VALUES ('NV01', 'Nguyễn Văn X', 1, 'Hà Nội', '1985-03-10', '0123456789', 'nvx@gmail.com', 'Hà Nội', '2020-01-01',
        'NV02'),
       ('NV02', 'Trần Thị Y', 0, 'Hồ Chí Minh', '1990-05-20', '0987654321', 'ty@gmail.com', 'Hồ Chí Minh', '2021-02-15',
        'SQL2'),
       ('NV03', 'Lê Văn Z', 1, 'Đà Nẵng', '1992-10-15', '0369876543', 'lvz@gmail.com', 'Đà Nẵng', '2019-07-10', 'NV02'),
       ('NV04', 'Phạm Thị K', 0, 'Hải Phòng', '1998-09-05', '0932145678', 'ptk@gmail.com', 'Hải Phòng', '2022-04-20',
        'NV02'),
       ('NV05', 'Nguyễn Thị M', 0, 'Huế', '1995-08-25', '0765432198', 'ntm@gmail.com', 'Huế', '2023-01-01', 'NV02');

-- Thêm dữ liệu vào bảng nhaCungCap
INSERT INTO nhaCungCap (maNCC, tenNCC, diaChi, dienThoai, email, website)
VALUES ('NCC1', 'Công ty A', 'Hà Nội', '0123456789', 'ctyA@gmail.com', 'www.congtyA.com'),
       ('NCC2', 'Công ty B', 'Hồ Chí Minh', '0987654321', 'ctyB@gmail.com', 'www.congtyB.com'),
       ('NCC3', 'Công ty C', 'Đà Nẵng', '0369876543', 'ctyC@gmail.com', 'www.congtyC.com'),
       ('NCC4', 'Công ty D', 'Hải Phòng', '0932145678', 'ctyD@gmail.com', 'www.congtyD.com'),
       ('NCC5', 'Công ty E', 'Huế', '0765432198', 'ctyE@gmail.com', 'www.congtyE.com');

-- Thêm dữ liệu vào bảng phieuNhap
INSERT INTO phieuNhap (soPN, maNV, maNCC, ngayNhap, ghiChu)
VALUES ('PN01', 'NV01', 'NCC1', '2023-06-01', 'Ghi chú phiếu nhập 1'),
       ('PN02', 'NV02', 'NCC2', '2023-06-02', 'Ghi chú phiếu nhập 2'),
       ('PN03', 'NV03', 'NCC3', '2023-06-03', 'Ghi chú phiếu nhập 3'),
       ('PN04', 'NV04', 'NCC4', '2023-06-04', 'Ghi chú phiếu nhập 4'),
       ('PN05', 'NV05', 'NCC5', '2023-06-05', 'Ghi chú phiếu nhập 5');

-- Thêm dữ liệu vào bảng loaiSP
INSERT INTO loaiSP (maLoaiSP, tenLoaiSP, ghiChu)
VALUES ('LSP1', 'Loại sản phẩm 1', 'Ghi chú loại sản phẩm 1'),
       ('LSP2', 'Loại sản phẩm 2', 'Ghi chú loại sản phẩm 2'),
       ('LSP3', 'Loại sản phẩm 3', 'Ghi chú loại sản phẩm 3'),
       ('LSP4', 'Loại sản phẩm 4', 'Ghi chú loại sản phẩm 4'),
       ('LSP5', 'Loại sản phẩm 5', 'Ghi chú loại sản phẩm 5');

-- Thêm dữ liệu vào bảng phieuXuat
INSERT INTO phieuXuat (soPX, maNV, maKH, ngayBan, ghiChu)
VALUES ('PX001', 'NV01', 'KH01', '2023-07-01', 'Ghi chú phiếu xuất 1'),
       ('PX002', 'NV02', 'KH02', '2023-07-02', 'Ghi chú phiếu xuất 2'),
       ('PX003', 'NV03', 'KH03', '2023-07-03', 'Ghi chú phiếu xuất 3'),
       ('PX004', 'NV04', 'KH04', '2023-07-04', 'Ghi chú phiếu xuất 4'),
       ('PX005', 'NV05', 'KH05', '2023-07-05', 'Ghi chú phiếu xuất 5');

-- Thêm dữ liệu vào bảng sanPham
INSERT INTO sanPham (maSP, maLoaiSP, tenSP, donViTinh, ghiChu)
VALUES ('SP01', 'LSP1', 'Sản phẩm 1', 'Cái', 'Ghi chú sản phẩm 1'),
       ('SP02', 'LSP2', 'Sản phẩm 2', 'Hộp', 'Ghi chú sản phẩm 2'),
       ('SP03', 'LSP3', 'Sản phẩm 3', 'Chai', 'Ghi chú sản phẩm 3'),
       ('SP04', 'LSP4', 'Sản phẩm 4', 'Thùng', 'Ghi chú sản phẩm 4'),
       ('SP05', 'LSP5', 'Sản phẩm 5', 'Gói', 'Ghi chú sản phẩm 5');

-- Thêm dữ liệu vào bảng ctPhieuXuat
INSERT INTO ctPhieuXuat (soPX, maSP, soLuong, giaBan)
VALUES ('PX001', 'SP01', 10, 100000),
       ('PX002', 'SP02', 5, 200000),
       ('PX003', 'SP03', 8, 150000),
       ('PX004', 'SP04', 15, 50000),
       ('PX005', 'SP05', 20, 30000);

-- Thêm dữ liệu vào bảng ctPhieuNhap
INSERT INTO ctPhieuNhap (maSP, soPN, soLuong, giaNhap)
VALUES ('SP01', 'PN01', 50, 90000),
       ('SP02', 'PN01', 30, 180000),
       ('SP03', 'PN02', 25, 120000),
       ('SP04', 'PN02', 40, 60000),
       ('SP05', 'PN03', 60, 40000);

-- 1. Liệt kê thông tin về nhân viên trong cửa hàng, gồm: mã nhân viên, họ tên
-- nhân viên, giới tính, ngày sinh, địa chỉ, số điện thoại, tuổi. Kết quả sắp xếp
-- theo tuổi.
select MaNV,
       hoTen,
       (case gioiTinh when true then 'Nam' when false then 'Nữ' end) 'gioi tinh',
       ngaySinh,
       diaChi,
       dienThoai,
       year(now()) - year(ngaySinh) as                               tuoi
from nhanVien
order by year(now()) - year(ngaySinh);

-- 2. Liệt kê các hóa đơn nhập hàng trong tháng 6/2018, gồm thông tin số phiếu
-- nhập, mã nhân viên nhập hàng, họ tên nhân viên, họ tên nhà cung cấp, ngày
-- nhập hàng, ghi chú

select nV.MaNV, nV.hoTen, nCC.tenNCC, p.ngayNhap, p.ghiChu
from phieuNhap p
         join nhanVien nV on nV.MaNV = p.maNV
         join nhaCungCap nCC on nCC.maNCC = p.maNCC
where year(ngayNhap) = 2018
  and month(ngayNhap) = 6;

-- 3. Liệt kê tất cả sản phẩm có đơn vị tính là chai, gồm tất cả thông tin về sản
-- phẩm.

select tenSP, maSP, donViTinh, count(donViTinh)
from sanPham
where donViTinh = 'Chai';

-- 4. Liệt kê chi tiết nhập hàng trong tháng hiện hành gồm thông tin: số phiếu
-- nhập, mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính, số lượng, giá
-- nhập, thành tiền.

select pn.soPN,
       cPN.maSP,
       sP.tenSP,
       sP.maLoaiSP,
       sP.donViTinh,
       cPN.soLuong,
       cPN.giaNhap,
       soLuong * giaNhap as total
from phieuNhap pn
         join ctPhieuNhap cPN on pn.soPN = cPN.soPN
         join sanPham sP on cPN.maSP = sP.maSP
where month(ngayNhap) = 6;

-- 5. Liệt kê các nhà cung cấp có giao dịch mua bán trong tháng hiện hành, gồm
-- thông tin: mã nhà cung cấp, họ tên nhà cung cấp, địa chỉ, số điện thoại,
-- email, số phiếu nhập, ngày nhập. Sắp xếp thứ tự theo ngày nhập hàng.

SELECT ncc.MaNCC     `Ma_NCC`,
       ncc.TenNCC    `Ten_NCC`,
       ncc.Diachi    `Dia_Chi`,
       ncc.DienThoai `Dien_Thoai`,
       ncc.Email     `Email`,
       pn.SoPN       `So_PN`,
       pn.NgayNhap   `Ngay_Nhap`
FROM NhaCungCap ncc
         JOIN
     PhieuNhap pn ON pn.MaNCC = ncc.MaNCC
WHERE MONTH(pn.NgayNhap) = MONTH(NOW())
ORDER BY DAY(pn.NgayNhap);
-- 6. Liệt kê chi tiết hóa đơn bán hàng trong 6 tháng đầu năm 2023,
-- gồm thông tin: số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên sản phẩm, đơn vị tính, số lượng, giá bán, doanh thu.
SELECT px.SoPX                      `So_PX`,
       nv.HoTen                     `Ten_NV`,
       px.NgayBan                   `Ngay_Ban`,
       sp.MaSP                      `Ma_SP`,
       sp.TenSP                     `Ten_SP`,
       sp.Donvitinh                 `Don_vi`,
       ctpx.Soluong                 `So_luong`,
       ctpx.Giaban                  `Gia_Ban`,
       (ctpx.SoLuong * ctpx.GiaBan) `Doanh_Thu`
FROM PhieuXuat px
         JOIN
     NhanVien nv ON px.MaNV = nv.MaNV
         JOIN
     CTPhieuXuat ctpx ON px.SoPX = ctpx.SoPX
         JOIN
     SanPham sp ON ctpx.MaSP = sp.MaSP
WHERE MONTH(px.NgayBan) <= 06
  AND YEAR(px.NgayBan) = 2023
ORDER BY px.NgayBan;
-- 7. Hãy in danh sách khách hàng có ngày sinh nhật trong tháng hiện hành 
-- (gồm tất cả thông tin của khách hàng)
SELECT *
FROM KhachHang
WHERE MONTH(KhachHang.NgaySinh) = MONTH(NOW());
-- 8. Liệt kê các hóa đơn bán hàng từ ngày 15/04/2018 đến 15/05/2018 
-- gồm các thông tin: số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên sản phẩm, đơn vị tính, số lượng, giá bán, doanh thu.
SELECT px.SoPX                      `So_PX`,
       nv.HoTen                     `Ten_NV`,
       px.NgayBan                   `Ngay_Ban`,
       sp.MaSP                      `Ma_SP`,
       sp.TenSP                     `Ten_SP`,
       sp.Donvitinh                 `Don_vi`,
       ctpx.Soluong                 `So_luong`,
       ctpx.Giaban                  `Gia_Ban`,
       (ctpx.SoLuong * ctpx.GiaBan) `Doanh_Thu`
FROM PhieuXuat px
         JOIN
     NhanVien nv ON px.MaNV = nv.MaNV
         JOIN
     CTPhieuXuat ctpx ON px.SoPX = ctpx.SoPX
         JOIN
     SanPham sp ON ctpx.MaSP = sp.MaSP
WHERE px.NgayBan BETWEEN '20230415' AND '20230515'
ORDER BY px.NgayBan;
-- 9. Liệt kê các hóa đơn mua hàng theo từng khách hàng, 
-- gồm các thông tin: số phiếu xuất, ngày bán, mã khách hàng, tên khách hàng, trị giá.
SELECT px.SoPX                         `So_PX`,
       px.NgayBan                      `Ngay_Ban`,
       px.MaKH                         ` Ma_KH`,
       kh.TenKH                        `Ten_KH`,
       SUM(ctpx.SoLuong * ctpx.GiaBan) `Tri_Gia`
FROM PhieuXuat px
         JOIN
     KhachHang kh ON px.MaKH = kh.MaKH
         JOIN
     CTPhieuXuat ctpx ON px.SoPX = ctpx.SoPX
GROUP BY px.SoPX;
-- 10. Cho biết tổng số chai nước xả vải Comfort đã bán trong 6 tháng đầu năm 2023. 
-- Thông tin hiển thị: tổng số lượng. 
SELECT SUM(ctpx.Soluong)
FROM CTPhieuXuat ctpx
         JOIN
     SanPham sp ON ctpx.MaSP = sp.MaSP
         JOIN
     PhieuXuat px ON ctpx.SoPX = px.SoPX
WHERE sp.TenSP = 'Comfort'
  AND MONTH(px.NgayBan) <= 06
  AND YEAR(px.NgayBan) = 2023
GROUP BY sp.MaSP;
-- 11.Tổng kết doanh thu theo từng khách hàng theo tháng, 
-- gồm các thông tin: tháng, mã khách hàng, tên khách hàng, địa chỉ, tổng tiền.
SELECT MONTH(px.NgayBan)               `Thang`,
       px.MaKH                         `Ma KH`,
       kh.TenKH                        `Ten KH`,
       kh.DiaChi                       `Dia Chi`,
       SUM(ctpx.Soluong * ctpx.Giaban) `Tong tien`
FROM PhieuXuat px
         JOIN
     KhachHang kh ON px.MaKH = kh.MaKH
         JOIN
     CTPhieuXuat ctpx ON px.SoPX = ctpx.SoPX
GROUP BY MONTH(px.NgayBan), px.MaKH
ORDER BY MONTH(px.NgayBan);
-- 12.Thống kê tổng số lượng sản phẩm đã bán theo từng tháng trong năm, 
-- gồm thông tin: năm, tháng, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số lượng.
SELECT YEAR(NgayBan)  AS Nam,
       MONTH(NgayBan) AS Thang,
       sp.MaSP,
       sp.TenSP,
       sp.Donvitinh,
       SUM(SoLuong)   AS TongSoLuong
FROM PhieuXuat px
         JOIN
     CTPhieuXuat ctpx ON px.SoPX = ctpx.SoPX
         JOIN
     SanPham sp ON ctpx.MaSP = sp.MaSP
GROUP BY YEAR(NgayBan), MONTH(NgayBan), MaSP, TenSP, Donvitinh
ORDER BY YEAR(NgayBan), MONTH(NgayBan), sp.MaSP;
-- 13.Thống kê doanh thu bán hàng trong trong 6 tháng đầu năm 2023, 
-- thông tin hiển thị gồm: tháng, doanh thu.
select Month(px.NgayBan)               as Thang,
       SUM(ctpx.SoLuong * ctpx.GiaBan) as DoanhThu
from PhieuXuat px
         join
     CTPhieuXuat ctpx on px.SoPX = ctpx.SoPX
where px.NgayBan between '2023-01-01' and '2023-06-30'
group by Month(px.NgayBan)
order by Month(px.NgayBan);
-- 14.Liệt kê các hóa đơn bán hàng của tháng 5 và tháng 6 năm 2023, 
-- gồm các thông tin: số phiếu, ngày bán, họ tên nhân viên bán hàng, họ tên khách hàng, tổng trị giá.
SELECT px.SoPX,
       px.NgayBan,
       (SELECT HoTen
        FROM NhanVien
        WHERE MaNV = px.MaNV)          `Ten NV`,
       (SELECT TenKH
        FROM KhachHang
        WHERE MaKH = px.MaKH)          `Ten KH`,
       SUM(ctpx.SoLuong * ctpx.GiaBan) `Tong Tri Gia`
FROM PhieuXuat px
         JOIN
     CTPhieuXuat ctpx ON px.SoPX = ctpx.SoPX
WHERE NgayBan BETWEEN '20230501' AND '20230630'
GROUP BY px.SoPX, px.NgayBan, px.MaNV, px.MaKH
ORDER BY px.NgayBan;
-- 15.Cuối ngày, nhân viên tổng kết các hóa đơn bán hàng trong ngày, 3
-- thông tin gồm: số phiếu xuất, mã khách hàng, tên khách hàng, họ tên nhân viên bán hàng, ngày bán, trị giá.
SELECT px.SoPX                         AS SoPhieuXuat,
       px.MaKH,
       kh.TenKH,
       (SELECT HoTen
        FROM NhanVien
        WHERE MaNV = px.MaNV)             `Ten NV`,
       px.NgayBan,
       SUM(ctpx.GiaBan * ctpx.SoLuong) AS `Tong Tri Gia`
FROM PhieuXuat px
         JOIN
     CTPhieuXuat ctpx ON px.SoPX = ctpx.SoPX
         JOIN
     KhachHang kh ON px.MaKH = kh.MaKH
WHERE DATE(px.NgayBan) = CURDATE()
GROUP BY px.SoPX, px.MaKH, kh.TenKH, px.MaNV, px.NgayBan
ORDER BY px.NgayBan DESC;
-- 16.Thống kê doanh số bán hàng theo từng nhân viên, 
-- gồm thông tin: mã nhân viên, họ tên nhân viên, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số lượng.
SELECT px.MaNV,
       (SELECT HoTen
        FROM NhanVien
        WHERE MaNV = px.MaNV) `Ten NV`,
       ctpx.MaSP,
       sp.TenSP,
       sp.Donvitinh,
       SUM(ctpx.SoLuong)      `So luong`
FROM PhieuXuat px
         JOIN
     CTPhieuXuat ctpx ON px.SoPX = ctpx.SoPX
         JOIN
     SanPham sp ON ctpx.MaSP = sp.MaSP
GROUP BY px.MaNV, ctpx.MaSP, sp.TenSP, sp.Donvitinh
ORDER BY px.MaNV ASC, ctpx.MaSP ASC;
-- 17.Liệt kê các hóa đơn bán hàng cho khách vãng lai (KH01) trong quý 2/2023,
-- thông tin gồm số phiếu xuất, ngày bán, mã sản phẩm, tên sản phẩm, đơn vị tính, số lượng, đơn giá, thành tiền.
SELECT px.SoPX,
       px.NgayBan,
       (SELECT HoTen
        FROM NhanVien
        WHERE MaNV = px.MaNV)       `Ten NV`,
       (SELECT TenKH
        FROM KhachHang
        WHERE MaKH = px.MaKH)       `Ten KH`,
       ctpx.MaSP,
       sp.TenSP,
       sp.Donvitinh,
       ctpx.SoLuong,
       (ctpx.GiaBan * ctpx.SoLuong) `Thanh tien`
FROM PhieuXuat px
         JOIN
     CTPhieuXuat ctpx ON px.SoPX = ctpx.SoPX
         JOIN
     SanPham sp ON ctpx.MaSP = sp.MaSP
WHERE px.MaKH = 'KH01'
  AND px.NgayBan BETWEEN '20230401' AND '20230630'
ORDER BY px.NgayBan ASC, ctpx.MaSP ASC;
-- 18.Liệt kê các sản phẩm chưa bán được trong 6 tháng đầu năm 2018,
-- gồm: mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính.
SELECT sp.MaSP,
       sp.TenSP,
       (SELECT TenloaiSP
        FROM LoaiSP
        WHERE MaloaiSP = sp.MaloaiSP) `Loai SP`,
       sp.Donvitinh
FROM SanPham sp
WHERE MaSP NOT IN (SELECT MaSP
                   FROM CTPhieuXuat ctpx
                            JOIN
                        PhieuXuat px ON ctpx.SoPX = px.SoPX
                   WHERE YEAR(px.NgayBan) = 2023
                     AND MONTH(px.NgayBan) <= 6);
-- 19.Liệt kê danh sách nhà cung cấp không giao dịch mua bán với cửa hàng trong quý 2/2023, 
-- gồm thông tin: mã nhà cung cấp, tên nhà cung cấp, địa chỉ, số điện thoại.
SELECT ncc.MaNCC,
       ncc.TenNCC,
       ncc.Diachi,
       ncc.Dienthoai
FROM NhaCungCap ncc
WHERE MaNCC NOT IN (SELECT DISTINCT MaNCC
                    FROM PhieuNhap pn
                    WHERE YEAR(pn.Ngaynhap) = 2023
                      AND MONTH(pn.Ngaynhap) BETWEEN 4 AND 6);
-- 20.Cho biết khách hàng có tổng trị giá đơn hàng lớn nhất 
-- trong 6 tháng đầu năm 2018.
SELECT kh.TenKH,
       SUM(ctpx.GiaBan * ctpx.SoLuong) `Tổng Trị Giá`
FROM PhieuXuat px
         JOIN
     CTPhieuXuat ctpx ON px.SoPX = ctpx.SoPX
         JOIN
     KhachHang kh ON px.MaKH = kh.MaKH
WHERE YEAR(px.NgayBan) = 2023
  AND MONTH(px.NgayBan) <= 6
GROUP BY kh.TenKH
ORDER BY `Tổng Trị Giá` DESC
LIMIT 1;
-- 21.Cho biết mã khách hàng và số lượng đơn đặt hàng của mỗi khách hàng.
SELECT px.MaKH        `Ma KH`,
       COUNT(px.SoPX) `SL đơn`
FROM PhieuXuat px
GROUP BY px.MaKH;
-- 22.Cho biết mã nhân viên, tên nhân viên, tên khách hàng 
-- kể cả những nhân viên không đại diện bán hàng.
SELECT nv.MaNV,
       nv.HoTen,
       (SELECT TenKH
        FROM KhachHang
        WHERE MaKH = px.MaKH) `Ten KH`
FROM NhanVien nv
         LEFT JOIN
     PhieuXuat px ON nv.MaNV = px.MaNV;
-- 23.Cho biết số lượng nhân viên nam, số lượng nhân viên nữ
SELECT nv.GioiTinh        `Gioi tinh`,
       COUNT(nv.GioiTinh) `So luong`
FROM NhanVien nv
GROUP BY nv.GioiTinh;
-- 24.Cho biết mã nhân viên, tên nhân viên, số năm làm việc của những nhân viên
-- có thâm niên cao nhất.
SELECT nv.MaNV                                    `Ma NV`,
       nv.HoTen                                   `Ten NV`,
       (DATEDIFF(CURDATE(), nv.NgayVaoLam) / 365) `Tham Nien`
FROM NhanVien nv
ORDER BY `Tham Nien` DESC
LIMIT 5;
-- 25.Hãy cho biết họ tên của những nhân viên đã đến tuổi về hưu 
-- (nam:60 tuổi,nữ: 55 tuổi)

-- 26.Hãy cho biết họ tên của nhân viên và năm về hưu của họ.

-- 27.Cho biết tiền thưởng tết dương lịch của từng nhân viên. 
-- Biết rằng - thâm niên <1 năm thưởng 200.000 - 1 năm <= thâm niên < 3 năm thưởng
-- 400.000 - 3 năm <= thâm niên < 5 năm thưởng 600.000 - 5 năm <= thâm
-- niên < 10 năm thưởng 800.000 - thâm niên >= 10 năm thưởng 1.000.000

-- 28.Cho biết những sản phẩm thuộc ngành hàng Hóa mỹ phẩm
SELECT *
FROM SanPham
         JOIN
     LoaiSP ON Sanpham.MaloaiSP = LoaiSP.MaLoaiSP
WHERE LoaiSP.TenloaiSP = 'Hoa Pham';
-- 29.Cho biết những sản phẩm thuộc loại Quần áo.
SELECT *
FROM SanPham
         JOIN
     LoaiSP ON Sanpham.MaloaiSP = LoaiSP.MaLoaiSP
WHERE LoaiSP.TenloaiSP = 'Quan Ao';
-- 30.Cho biết số lượng sản phẩm loại Quần áo.
SELECT COUNT(SanPham.MaSP)
FROM SanPham
         JOIN
     LoaiSP ON Sanpham.MaloaiSP = LoaiSP.MaLoaiSP
WHERE LoaiSP.TenloaiSP = 'Quan Ao';
-- 31.Cho biết số lượng loại sản phẩm ngành hàng Hóa mỹ phẩm.
SELECT COUNT(SanPham.MaSP)
FROM SanPham
         JOIN
     LoaiSP ON Sanpham.MaloaiSP = LoaiSP.MaLoaiSP
WHERE LoaiSP.TenloaiSP = 'Hoa Pham';
-- 32.Cho biết số lượng sản phẩm theo từng loại sản phẩm.
SELECT LoaiSP.TenloaiSP    `Loai_SP`,
       COUNT(SanPham.MaSP) `So_luong`
FROM SanPham
         JOIN
     LoaiSP ON Sanpham.MaloaiSP = LoaiSP.MaLoaiSP
GROUP BY LoaiSP.TenloaiSP;