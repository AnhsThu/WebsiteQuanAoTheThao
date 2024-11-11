CREATE DATABASE Sport65_SD65_SU24
GO
USE Sport65_SD65_SU24
GO

CREATE TABLE loai
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE thuong_hieu
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT
)

CREATE TABLE cau_lac_bo
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE san_pham
(
    id       UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ten      NVARCHAR(MAX) NOT NULL,
    anh      NVARCHAR(MAX),
    id_loai  INT           NOT NULL,
	id_thuong_hieu  INT  NOT NULL,
	id_cau_lac_bo  INT  NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT
)

CREATE TABLE mau_sac
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE kich_co
(
    id  INT IDENTITY (1, 1) PRIMARY KEY,
    ten NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE san_pham_chi_tiet
(
    id          UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma_san_pham VARCHAR(20),
    id_san_pham UNIQUEIDENTIFIER,
    id_kich_co  INT,
    id_mau_sac  INT,
    so_luong    INT,
    mo_ta       NVARCHAR(MAX),
	gia         DECIMAL(20, 0)               DEFAULT 0,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT
)

CREATE TABLE anh_san_pham
(
    id                   UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_san_pham UNIQUEIDENTIFIER,
    duong_dan            NVARCHAR(MAX) NOT NULL,
    trang_thai  INT 
)

CREATE TABLE khach_hang
(
    id             UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ho_va_ten      NVARCHAR(100) NOT NULL,
    email          NVARCHAR(50) NOT NULL,
    so_dien_thoai  NVARCHAR(15)	,
	dia_chi        NVARCHAR(100) , 
    xa_phuong      NVARCHAR(80) ,
    quan_huyen     NVARCHAR(80) ,
    tinh_thanh_pho NVARCHAR(80) ,
    mat_khau       NVARCHAR(50) ,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE nhan_vien
(
    id             UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma             VARCHAR(20) UNIQUE NOT NULL,
    ho_va_ten      NVARCHAR(100),
    email          NVARCHAR(50),
    so_dien_thoai  NVARCHAR(15),
    mat_khau       NVARCHAR(50),
    dia_chi        NVARCHAR(100),
    xa_phuong      NVARCHAR(80),
    quan_huyen     NVARCHAR(80),
    tinh_thanh_pho NVARCHAR(80),
    ngay_vao_lam   DATE,
    chuc_vu        INT,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE gio_hang_chi_tiet
(
    id                   UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_khach_hang          UNIQUEIDENTIFIER,
    id_san_pham_chi_tiet UNIQUEIDENTIFIER,
    gia                  DECIMAL(20, 0)               DEFAULT 0,
    so_luong             INT,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE khuyen_mai
(
    id                UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma                VARCHAR(10) UNIQUE NOT NULL,
    ten               NVARCHAR(50),
    so_phan_tram_giam INT,
    ngay_bat_dau      DATE,
    ngay_ket_thuc     DATE,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE khuyen_mai_chi_tiet
(
    id                   UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_khuyen_mai        UNIQUEIDENTIFIER,
    id_san_pham_chi_tiet UNIQUEIDENTIFIER,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)


CREATE TABLE giam_gia
(
    id                UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma                VARCHAR(10) NOT NULL,
    so_phan_tram_giam INT,
	 so_phan_tien_giam_toi_thieu INT,
    so_luong          INT,
    ngay_bat_dau      DATE,
    ngay_ket_thuc     DATE,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE hinh_thuc_thanh_toan
(
    id INT IDENTITY(1,1) PRIMARY KEY ,
    ten NVARCHAR(50) NOT NULL,
	ma NVARCHAR(50) NOT NULL,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE hoa_don
(
    id                       UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ma                       VARCHAR(50) UNIQUE NOT NULL,
    -- Ngày tạo hoá đơn
    ngay_tao                 DATETIME                     DEFAULT GETDATE(),
    -- Ngày thanh toán
    ngay_thanh_toan          DATETIME,
    -- Ngày vận chuyển
    ngay_van_chuyen          DATETIME,
    -- Ngày nhận hàng
    ngay_nhan                DATETIME,
    -- id người mua
    id_khach_hang            UNIQUEIDENTIFIER,
    -- id người duyệt
    id_nhan_vien             UNIQUEIDENTIFIER,
    id_giam_gia              UNIQUEIDENTIFIER,
    id_hinh_thuc_thanh_toan  INT,
    nguoi_nhan               NVARCHAR(100),
    email                    NVARCHAR(50),
    so_dien_thoai            NVARCHAR(15),
	tong_tien                  DECIMAL(20, 0)               DEFAULT 0,
    so_tien_giam                  DECIMAL(20, 0)               DEFAULT 0,
    thanh_toan                  DECIMAL(20, 0)               DEFAULT 0,
    dia_chi                  NVARCHAR(100),
    xa_phuong                NVARCHAR(80),
    quan_huyen               NVARCHAR(80),
    tinh_thanh_pho           NVARCHAR(80),
    loai_hoa_don             INT,
    ma_van_chuyen            VARCHAR(50),
    ten_don_vi_van_chuyen    NVARCHAR(MAX),
    phi_van_chuyen           DECIMAL(20, 0)               DEFAULT 0,
    anh_hoa_don_chuyen_khoan NVARCHAR(MAX),
    ghi_chu                  NVARCHAR(MAX),
    ngay_sua DATE ,
    trang_thai  INT 
)

CREATE TABLE hoa_don_chi_tiet
(
    id                   UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    id_hoa_don           UNIQUEIDENTIFIER,
    id_san_pham_chi_tiet UNIQUEIDENTIFIER,
    id_khuyen_mai        UNIQUEIDENTIFIER,
    gia                  DECIMAL(20, 0)               DEFAULT 0,
    so_luong             INT,
	ngay_tao DATE ,
    ngay_sua DATE ,
    trang_thai  INT 
)

-- loai - san_pham
ALTER TABLE san_pham
    ADD FOREIGN KEY (id_loai) REFERENCES loai (id)
ALTER TABLE san_pham
	ADD FOREIGN KEY (id_cau_lac_bo) REFERENCES cau_lac_bo (id)
ALTER TABLE san_pham
    ADD FOREIGN KEY (id_thuong_hieu) REFERENCES thuong_hieu (id)

-- san_pham - san_pham_chi_tiet
ALTER TABLE san_pham_chi_tiet
    ADD FOREIGN KEY (id_san_pham) REFERENCES san_pham (id)

-- mau_sac - san_pham_chi_tiet
ALTER TABLE san_pham_chi_tiet
    ADD FOREIGN KEY (id_mau_sac) REFERENCES mau_sac (id)

-- kich_co - san_pham_chi_tiet
ALTER TABLE san_pham_chi_tiet
    ADD FOREIGN KEY (id_kich_co) REFERENCES kich_co (id)

-- san_pham - anh_san_pham
ALTER TABLE anh_san_pham
    ADD FOREIGN KEY (id_san_pham) REFERENCES san_pham (id)

-- khach_hang - gio_hang
ALTER TABLE gio_hang_chi_tiet
    ADD FOREIGN KEY (id_khach_hang) REFERENCES khach_hang (id)

-- san_pham - gio_hang_chi_tiet
ALTER TABLE gio_hang_chi_tiet
    ADD FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES san_pham_chi_tiet (id)

-- khuyen_mai - khuyen_mai_chi_tiet
ALTER TABLE khuyen_mai_chi_tiet
    ADD FOREIGN KEY (id_khuyen_mai) REFERENCES khuyen_mai (id)

-- san_pham_chi_tiet - khuyen_mai_chi_tiet
ALTER TABLE khuyen_mai_chi_tiet
    ADD FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES san_pham_chi_tiet (id)

-- khach_hang - hoa_don
ALTER TABLE hoa_don
    ADD FOREIGN KEY (id_khach_hang) REFERENCES khach_hang (id)

-- nhanh_vien - hoa_don
ALTER TABLE hoa_don
    ADD FOREIGN KEY (id_nhan_vien) REFERENCES nhan_vien (id)

-- khuyen_mai - hoa_don_chi_tiet
ALTER TABLE hoa_don_chi_tiet
    ADD FOREIGN KEY (id_khuyen_mai) REFERENCES khuyen_mai (id)

-- giam_gia - hoa_don
ALTER TABLE hoa_don
    ADD FOREIGN KEY (id_giam_gia) REFERENCES giam_gia (id)
ALTER TABLE hoa_don
    ADD FOREIGN KEY (id_hinh_thuc_thanh_toan) REFERENCES hinh_thuc_thanh_toan (id)

-- hoa_don - hoa_don_chi_tiet
ALTER TABLE hoa_don_chi_tiet
    ADD FOREIGN KEY (id_hoa_don) REFERENCES hoa_don (id)

-- san_pham_chi_tiet - hoa_don_chi_tiet
ALTER TABLE hoa_don_chi_tiet
    ADD FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES san_pham_chi_tiet (id)



	-- Insert data into loai table
-- populate_data.sql

-- Insert data into 'loai' table
INSERT INTO loai (ten, ngay_tao, ngay_sua, trang_thai)
VALUES 
    (N'Quần áo', '2024-01-01', '2024-01-01', 1),
    (N'Giày dép', '2024-01-01', '2024-01-01', 1),
    (N'Phụ kiện', '2024-01-01', '2024-01-01', 1);

-- Insert data into 'thuong_hieu' table
INSERT INTO thuong_hieu (ten, ngay_tao, ngay_sua, trang_thai)
VALUES 
    (N'Nike', '2024-01-01', '2024-01-01', 1),
    (N'Adidas', '2024-01-01', '2024-01-01', 1),
    (N'Puma', '2024-01-01', '2024-01-01', 1);

-- Insert data into 'cau_lac_bo' table
INSERT INTO cau_lac_bo (ten, ngay_tao, ngay_sua, trang_thai)
VALUES 
    (N'FC Barcelona', '2024-01-01', '2024-01-01', 1),
    (N'Real Madrid', '2024-01-01', '2024-01-01', 1),
    (N'Liverpool FC', '2024-01-01', '2024-01-01', 1);

-- Insert data into 'san_pham' table
INSERT INTO san_pham (ten, anh, id_loai, id_thuong_hieu, id_cau_lac_bo, ngay_tao, ngay_sua, trang_thai)
VALUES 
    (N'Áo Nike FC Barcelona', N'/images/ao_nike_fcb.png', 
        (SELECT id FROM loai WHERE ten = N'Quần áo'), 
        (SELECT id FROM thuong_hieu WHERE ten = N'Nike'), 
        (SELECT id FROM cau_lac_bo WHERE ten = N'FC Barcelona'), 
        '2024-01-01', '2024-01-01', 1),
    (N'Giày Adidas Real Madrid', N'/images/giay_adidas_rm.png', 
        (SELECT id FROM loai WHERE ten = N'Giày dép'), 
        (SELECT id FROM thuong_hieu WHERE ten = N'Adidas'), 
        (SELECT id FROM cau_lac_bo WHERE ten = N'Real Madrid'), 
        '2024-01-01', '2024-01-01', 1),
    (N'Khăn Puma Liverpool', N'/images/khan_puma_lfc.png', 
        (SELECT id FROM loai WHERE ten = N'Phụ kiện'), 
        (SELECT id FROM thuong_hieu WHERE ten = N'Puma'), 
        (SELECT id FROM cau_lac_bo WHERE ten = N'Liverpool FC'), 
        '2024-01-01', '2024-01-01', 1);

-- Insert data into 'mau_sac' table
INSERT INTO mau_sac (ten, ngay_tao, ngay_sua, trang_thai)
VALUES 
    (N'Đỏ', '2024-01-01', '2024-01-01', 1),
    (N'Xanh', '2024-01-01', '2024-01-01', 1),
    (N'Vàng', '2024-01-01', '2024-01-01', 1);

-- Insert data into 'kich_co' table
INSERT INTO kich_co (ten, ngay_tao, ngay_sua, trang_thai)
VALUES 
    (N'S', '2024-01-01', '2024-01-01', 1),
    (N'M', '2024-01-01', '2024-01-01', 1),
    (N'L', '2024-01-01', '2024-01-01', 1);

-- Insert data into 'san_pham_chi_tiet' table
INSERT INTO san_pham_chi_tiet (ma_san_pham, id_san_pham, id_kich_co, id_mau_sac, so_luong, mo_ta, gia, ngay_tao, ngay_sua, trang_thai)
VALUES 
    ('SP0001', 
        (SELECT id FROM san_pham WHERE ten = N'Áo Nike FC Barcelona'), 
        (SELECT id FROM kich_co WHERE ten = N'S'), 
        (SELECT id FROM mau_sac WHERE ten = N'Đỏ'), 
        100, N'Mẫu áo mới nhất của Barcelona', 500000, '2024-01-01', '2024-01-01', 1),
    ('SP0002', 
        (SELECT id FROM san_pham WHERE ten = N'Giày Adidas Real Madrid'), 
        (SELECT id FROM kich_co WHERE ten = N'M'), 
        (SELECT id FROM mau_sac WHERE ten = N'Xanh'), 
        50, N'Giày mới của Real Madrid', 1200000, '2024-01-01', '2024-01-01', 1),
    ('SP0003', 
        (SELECT id FROM san_pham WHERE ten = N'Khăn Puma Liverpool'), 
        (SELECT id FROM kich_co WHERE ten = N'L'), 
        (SELECT id FROM mau_sac WHERE ten = N'Vàng'), 
        200, N'Khăn Puma cho Liverpool', 300000, '2024-01-01', '2024-01-01', 1);

-- Insert data into 'anh_san_pham' table
INSERT INTO anh_san_pham (id_san_pham, duong_dan, trang_thai)
VALUES 
    ((SELECT id FROM san_pham WHERE ten = N'Áo Nike FC Barcelona'), N'/images/ao_nike_fcb_1.png', 1),
    ((SELECT id FROM san_pham WHERE ten = N'Giày Adidas Real Madrid'), N'/images/giay_adidas_rm_1.png', 1),
    ((SELECT id FROM san_pham WHERE ten = N'Khăn Puma Liverpool'), N'/images/khan_puma_lfc_1.png', 1);

-- Insert data into 'khach_hang' table
INSERT INTO khach_hang (ho_va_ten, email, so_dien_thoai, mat_khau,dia_chi,xa_phuong,quan_huyen,tinh_thanh_pho,ngay_tao, ngay_sua, trang_thai)
VALUES 
    (N'Nguyễn Văn A', N'nguyenvana@example.com', N'0123456789', N'password123',N'123 Đường A', N'Phường X', N'Quận Y', N'TP. Z', '2024-01-01', '2024-01-01', 1),
    (N'Trần Thị B', N'tranthib@example.com', N'0987654321', N'password456',N'456 Đường B', N'Phường W', N'Quận V', N'TP. U', '2024-01-01', '2024-01-01', 1),
    (N'Lê C D', N'lecd@example.com', N'1122334455', N'password789',N'789 Đường C', N'Phường Q', N'Quận R', N'TP. S', '2024-01-01', '2024-01-01', 1);

-- Insert data into 'nhan_vien' table
INSERT INTO nhan_vien (ma, ho_va_ten, email, so_dien_thoai, mat_khau, dia_chi, xa_phuong, quan_huyen, tinh_thanh_pho, ngay_vao_lam, chuc_vu, ngay_tao, ngay_sua, trang_thai)
VALUES 
    ('NV0001', N'Văn Đình Sơn', N'sondinhson11@gmail.com', N'0123456780', N'As121202', N'789 Đường D', N'Phường P', N'Quận O', N'TP. N', '2024-01-01', 0, '2024-01-01', '2024-01-01', 1),
    ('NV0002', N'Trần Thị F', N'tranthif@example.com', N'0987654320', N'password456', N'123 Đường E', N'Phường Z', N'Quận Y', N'TP. X', '2024-01-01', 1, '2024-01-01', '2024-01-01', 1),
    ('NV0003', N'Lê G H', N'legh@example.com', N'1122334466', N'password789', N'456 Đường F', N'Phường W', N'Quận V', N'TP. U', '2024-01-01', 1, '2024-01-01', '2024-01-01', 1);

-- Insert data into 'gio_hang' table
INSERT INTO gio_hang_chi_tiet (id_khach_hang, id_san_pham_chi_tiet, gia, so_luong, ngay_tao, ngay_sua, trang_thai)
VALUES 
    ((SELECT id FROM khach_hang WHERE email = 'sondinhson11@gmail.com'), 
        (SELECT id FROM san_pham_chi_tiet WHERE ma_san_pham = 'SP001'), 
        500000, 2, '2024-01-01', '2024-01-01',1),
    ((SELECT id FROM khach_hang WHERE email = 'sondinhson11@gmail.com'), 
        (SELECT id FROM san_pham_chi_tiet WHERE ma_san_pham = 'SP002'), 
        1200000, 1, '2024-01-01', '2024-01-01',1);

-- Insert data into 'khuyen_mai' table
INSERT INTO khuyen_mai (ma, ten, so_phan_tram_giam, ngay_bat_dau, ngay_ket_thuc, ngay_tao, ngay_sua, trang_thai)
VALUES 
    ('KM0001', N'Giảm giá 10%', 10, '2024-01-01', '2024-02-01', '2024-01-01', '2024-01-01', 1),
    ('KM0002', N'Giảm giá 20%', 20, '2024-02-01', '2024-03-01', '2024-01-01', '2024-01-01', 1);

-- Insert data into 'khuyen_mai_chi_tiet' table
INSERT INTO khuyen_mai_chi_tiet (id_khuyen_mai, id_san_pham_chi_tiet, ngay_tao, ngay_sua, trang_thai)
VALUES 
    ((SELECT id FROM khuyen_mai WHERE ma = 'KM0001'), 
        (SELECT id FROM san_pham_chi_tiet WHERE ma_san_pham = 'SP0001'), 
        '2024-01-01', '2024-01-01', 1),
    ((SELECT id FROM khuyen_mai WHERE ma = 'KM0002'), 
        (SELECT id FROM san_pham_chi_tiet WHERE ma_san_pham = 'SP0002'), 
        '2024-01-01', '2024-01-01', 1);

-- Insert data into 'giam_gia' table
INSERT INTO giam_gia (ma, so_phan_tram_giam, so_luong,so_phan_tien_giam_toi_thieu, ngay_bat_dau, ngay_ket_thuc, ngay_tao, ngay_sua, trang_thai)
VALUES 
    ('GG0001', 0, 100000, 0, '2024-01-01', '2999-02-01', '2024-01-01', '2024-01-01', 1),
    ('GG0002', 15, 100, 0, '2024-01-01', '2024-02-01', '2024-01-01', '2024-01-01', 1),
    ('GG0003', 25, 200, 0, '2024-02-01', '2024-03-01', '2024-01-01', '2024-01-01', 1);

-- Insert data into 'hinh_thuc_thanh_toan' table
INSERT INTO hinh_thuc_thanh_toan (ten, ma, ngay_tao, ngay_sua, trang_thai)
VALUES 
    (N'Tiền mặt', '1', '2024-01-01', '2024-01-01', 1),
    (N'Chuyển khoản', '2', '2024-01-01', '2024-01-01', 1);

-- Insert data into 'hoa_don' table
INSERT INTO hoa_don (ma, ngay_thanh_toan, ngay_van_chuyen, ngay_nhan, id_khach_hang, id_nhan_vien, id_giam_gia, id_hinh_thuc_thanh_toan, nguoi_nhan, email, so_dien_thoai,tong_tien, dia_chi, xa_phuong, quan_huyen, tinh_thanh_pho, trang_thai, loai_hoa_don, ma_van_chuyen, ten_don_vi_van_chuyen, phi_van_chuyen, anh_hoa_don_chuyen_khoan, ghi_chu, ngay_tao, ngay_sua)
VALUES 
    ('HD0001', '2024-01-02', '2024-01-03', '2024-01-04', 
        (SELECT id FROM khach_hang WHERE email = 'nguyenvana@example.com'), 
        (SELECT id FROM nhan_vien WHERE ma = 'NV001'), 
        (SELECT id FROM giam_gia WHERE ma = 'GG001'), 
        (SELECT id FROM hinh_thuc_thanh_toan WHERE ma = '1'), 
        N'Nguyễn Văn A', 'nguyenvana@example.com', '0123456789',480000, 
        N'123 Đường A', N'Phường X', N'Quận Y', N'TP. Z', 1, 1, 'VC001', N'Viettel', 30000, 
        N'/images/hoa_don_001.png', N'Ghi chú 1', '2024-01-01', '2024-01-01'),
    ('HD0002', '2024-02-02', '2024-02-03', '2024-02-04', 
        (SELECT id FROM khach_hang WHERE email = 'tranthib@example.com'), 
        (SELECT id FROM nhan_vien WHERE ma = 'NV002'), 
        (SELECT id FROM giam_gia WHERE ma = 'GG002'), 
        (SELECT id FROM hinh_thuc_thanh_toan WHERE ma = '2'), 
        N'Trần Thị B', 'tranthib@example.com', '0987654321',1050000,
        N'456 Đường B', N'Phường W', N'Quận V', N'TP. U', 1, 1, 'VC002', N'Giao Hàng Nhanh', 50000, 

        N'/images/hoa_don_002.png', N'Ghi chú 2', '2024-02-01', '2024-02-01');
-- Insert data into 'hoa_don_chi_tiet' table
INSERT INTO hoa_don_chi_tiet (id_hoa_don, id_san_pham_chi_tiet, id_khuyen_mai,gia,so_luong, ngay_tao, ngay_sua, trang_thai)
VALUES 
    ((SELECT id FROM hoa_don WHERE ma = 'HD0001'), 
        (SELECT id FROM san_pham_chi_tiet WHERE ma_san_pham = 'SP0001'), 
        (SELECT id FROM khuyen_mai WHERE ma = 'KM0001'), 
        450000, 2, '2024-01-01', '2024-01-01', 1),
    ((SELECT id FROM hoa_don WHERE ma = 'HD0002'), 
        (SELECT id FROM san_pham_chi_tiet WHERE ma_san_pham = 'SP0002'), 
        (SELECT id FROM khuyen_mai WHERE ma = 'KM0002'), 
        1000000, 1, '2024-02-01', '2024-02-01', 1);


