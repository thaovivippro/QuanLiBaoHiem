-- Tao co so du lieu
CREATE DATABASE QuanLyBaoHiem
GO
USE QuanLyBaoHiem
GO

-- 1. Bang KhachHang 
CREATE TABLE KhachHang (
    MaKH VARCHAR(20) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE NOT NULL,
    SoDienThoai VARCHAR(15) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DiaChi NVARCHAR(200) NULL,
    GioiTinh NVARCHAR(10) NULL
);

-- 2. Bang LoaiBaoHiem 
CREATE TABLE LoaiBaoHiem (
    MaLoaiBH VARCHAR(20) PRIMARY KEY,
    TenLoaiBH NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(200) NULL
);

-- 3. Bang DichVuBaoHiem 
CREATE TABLE DichVuBaoHiem (
    MaDV VARCHAR(20) PRIMARY KEY,
    TenDV NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(200) NULL,
    ChiPhiCoBan DECIMAL(18,2) NOT NULL,
    MaLoaiBH VARCHAR(20) NOT NULL,
    FOREIGN KEY (MaLoaiBH) REFERENCES LoaiBaoHiem(MaLoaiBH)
);

-- 4. Bang DoiTac 
CREATE TABLE DoiTac (
    MaDoiTac VARCHAR(20) PRIMARY KEY,
    TenDoiTac NVARCHAR(100) NOT NULL,
    LoaiDoiTac NVARCHAR(50) NOT NULL,
    DiaChi NVARCHAR(200) NOT NULL,
    SoDienThoai VARCHAR(15) UNIQUE NOT NULL
);

-- 5. Bang HopDong 
CREATE TABLE HopDong (
    MaHD VARCHAR(20) PRIMARY KEY,
    NgayLap DATE NOT NULL,
    NgayHetHan DATE NOT NULL,
    GiaTriHD DECIMAL(18,2) NOT NULL,
    TrangThai NVARCHAR(50) NOT NULL,
    MaLoaiBH VARCHAR(20) NOT NULL,
    MaDoiTac VARCHAR(20) NULL,
    MaKH VARCHAR(20) NULL,
    FOREIGN KEY (MaLoaiBH) REFERENCES LoaiBaoHiem(MaLoaiBH),
    FOREIGN KEY (MaDoiTac) REFERENCES DoiTac(MaDoiTac),
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    CONSTRAINT CHK_NgayHetHan CHECK (NgayHetHan >= NgayLap),
    CONSTRAINT CHK_GiaTriHD CHECK (GiaTriHD > 0)
);

-- 6. Bang ChiTietHopDong 
CREATE TABLE ChiTietHopDong (
    MaCT VARCHAR(20) PRIMARY KEY,
    MaHD VARCHAR(20) NOT NULL,
    MaDV VARCHAR(20) NOT NULL,
    SoTienBH DECIMAL(18,2) NOT NULL,
    DieuKhoan NVARCHAR(500) NULL,
    FOREIGN KEY (MaHD) REFERENCES HopDong(MaHD),
    FOREIGN KEY (MaDV) REFERENCES DichVuBaoHiem(MaDV)
);

-- 7. Bang NhanVien 
CREATE TABLE NhanVien (
    MaNV VARCHAR(20) PRIMARY KEY,
    HoTenNV NVARCHAR(100) NOT NULL,
    ChucVu NVARCHAR(50) NOT NULL,
    SoDienThoai VARCHAR(15) NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DiaChi NVARCHAR(200) NOT NULL
);

-- 8. Bang ThanhToan 
CREATE TABLE ThanhToan (
    MaTT VARCHAR(20) PRIMARY KEY,
    MaHD VARCHAR(20) NOT NULL,
    MaKH VARCHAR(20) NULL,
    NgayTT DATE NOT NULL,
    SoTien DECIMAL(18,2) NOT NULL,
    PhuongThuc NVARCHAR(50) NOT NULL,
    TrangThai NVARCHAR(50) NOT NULL,
    MaNV VARCHAR(20) NULL,
    FOREIGN KEY (MaHD) REFERENCES HopDong(MaHD),
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

-- 9. Bang HoSoYeuCau 
CREATE TABLE HoSoYeuCau (
    MaYeuCau VARCHAR(20) PRIMARY KEY,
    MaHD VARCHAR(20) NOT NULL,
    NgayYeuCau DATE NOT NULL,
    MoTa NVARCHAR(500) NULL,
    SoTienYC DECIMAL(18,2) NOT NULL,
    TrangThai NVARCHAR(50) NOT NULL,
    FOREIGN KEY (MaHD) REFERENCES HopDong(MaHD)
);

-- 10. Bang LichSuThayDoiHD 
CREATE TABLE LichSuThayDoiHD (
    MaThayDoi VARCHAR(20) PRIMARY KEY,
    MaHD VARCHAR(20) NULL,
    NgayThayDoi DATE NOT NULL,
    NoiDungThayDoi NVARCHAR(500) NOT NULL,
    MaNV VARCHAR(20) NOT NULL,
    FOREIGN KEY (MaHD) REFERENCES HopDong(MaHD),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

-- 11. Bang YeuCauBoiThuong 
CREATE TABLE YeuCauBoiThuong (
    MaYC VARCHAR(20) PRIMARY KEY,
    MaYeuCau VARCHAR(20) NOT NULL,
    NgayYeuCau DATE NOT NULL,
    SoTienBoiThuong DECIMAL(18,2) NOT NULL,
    TrangThai NVARCHAR(50) NOT NULL,
    MaNV VARCHAR(20) NULL,
    FOREIGN KEY (MaYeuCau) REFERENCES HoSoYeuCau(MaYeuCau),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

-- Chèn dữ liệu

--1. Bảng KhachHang
INSERT INTO KhachHang (MaKH, HoTen, NgaySinh, SoDienThoai, Email, DiaChi, GioiTinh) VALUES
('KH001', N'Nguyễn Xuân Phúc', '1985-07-20', '0901234561', 'nguyenxuanphuc@gmail.com', N'123 Trần Phú, TP.HCM', N'Nam'),
('KH002', N'Trần Thị Mai', '1990-03-15', '0912345678', 'tranthimai90@gmail.com', N'45 Lê Lợi, Hà Nội', N'Nữ'),
('KH003', N'Phạm Minh Tuấn', '1988-11-10', '0933456789', 'phamminhtuan@gmail.com', N'78 Nguyễn Huệ, Đà Nẵng', N'Nam'),
('KH004', N'Lê Hồng Anh', '1975-05-25', '0944567890', 'lehonganh75@gmail.com', N'12 Pasteur, TP.HCM', N'Nữ'),
('KH005', N'Hoàng Văn Hùng', '1992-09-30', '0975678901', 'hoangvanhung@gmail.com', N'56 Hùng Vương, Huế', N'Nam'),
('KH006', N'Nguyễn Thị Thanh', '1980-12-05', '0986789012', 'nguyenthithanh@gmail.com', N'89 Lý Thường Kiệt, Hà Nội', N'Nữ'),
('KH007', N'Trương Văn Nam', '1987-04-18', '0907890123', 'truongvannam@gmail.com', N'34 Nguyễn Trãi, TP.HCM', N'Nam'),
('KH008', N'Vũ Thị Lan', '1995-06-22', '0918901234', 'vuthilan95@gmail.com', N'67 Lê Đại Hành, Đà Nẵng', N'Nữ'),
('KH009', N'Đặng Văn Bình', '1983-08-14', '0939012345', 'dangvanbinh@gmail.com', N'23 Tôn Đức Thắng, Hà Nội', N'Nam'),
('KH010', N'Bùi Thị Hương', '1991-02-28', '0940123456', 'buithihuong@gmail.com', N'45 Nguyễn Thị Minh Khai, TP.HCM', N'Nữ'),
('KH011', N'Lý Văn Hòa', '1978-10-10', '0971234567', 'lyvanhoa@gmail.com', N'12 Hai Bà Trưng, Huế', N'Nam'),
('KH012', N'Phan Thị Ngọc', '1989-01-15', '0982345678', 'phanthingoc@gmail.com', N'78 Trần Hưng Đạo, Hà Nội', N'Nữ'),
('KH013', N'Ngô Văn Long', '1984-03-20', '0903456789', 'ngovanlong@gmail.com', N'56 Lê Thánh Tôn, TP.HCM', N'Nam'),
('KH014', N'Hà Thị Thu', '1993-07-07', '0914567890', 'hathithu93@gmail.com', N'89 Nguyễn Đình Chiểu, Đà Nẵng', N'Nữ'),
('KH015', N'Tô Văn Khánh', '1986-11-25', '0935678901', 'tovankhanh@gmail.com', N'34 Phạm Ngọc Thạch, Hà Nội', N'Nam'),
('KH016', N'Đỗ Thị Minh', '1994-09-09', '0946789012', 'dothiminh@gmail.com', N'67 Bạch Đằng, TP.HCM', N'Nữ'),
('KH017', N'Vương Quốc Anh', '1982-05-30', '0977890123', 'vuongquocanh@gmail.com', N'23 Điện Biên Phủ, Huế', N'Nam'),
('KH018', N'Trịnh Thị Hoa', '1990-12-12', '0988901234', 'trinhthihoa@gmail.com', N'45 Lê Duẩn, Hà Nội', N'Nữ'),
('KH019', N'Chu Văn Hùng', '1981-08-08', '0909012345', 'chuvanhung@gmail.com', N'78 Võ Thị Sáu, TP.HCM', N'Nam'),
('KH020', N'Đào Thị Lan', '1987-04-04', '0910123456', 'daothilan@gmail.com', N'12 Nguyễn Công Trứ, Đà Nẵng', N'Nữ');

-- 2. Bảng LoaiBaoHiem
INSERT INTO LoaiBaoHiem (MaLoaiBH, TenLoaiBH, MoTa) VALUES
('LBH01', N'Bảo hiểm nhân thọ', N'Bảo hiểm cho sức khỏe và tính mạng'),
('LBH02', N'Bảo hiểm y tế', N'Chi trả chi phí khám chữa bệnh'),
('LBH03', N'Bảo hiểm xe cơ giới', N'Bảo hiểm cho xe máy, ô tô'),
('LBH04', N'Bảo hiểm tài sản', N'Bảo vệ tài sản cá nhân hoặc doanh nghiệp'),
('LBH05', N'Bảo hiểm du lịch', N'Hỗ trợ rủi ro khi đi du lịch'),
('LBH06', N'Bảo hiểm sức khỏe', N'Hỗ trợ chi phí y tế toàn diện'),
('LBH07', N'Bảo hiểm tai nạn', N'Chi trả khi xảy ra tai nạn'),
('LBH08', N'Bảo hiểm nhà cửa', N'Bảo vệ nhà ở trước thiên tai, hỏa hoạn'),
('LBH09', N'Bảo hiểm trách nhiệm', N'Bảo hiểm trách nhiệm dân sự'),
('LBH10', N'Bảo hiểm hàng hóa', N'Bảo vệ hàng hóa trong vận chuyển'),
('LBH11', N'Bảo hiểm lao động', N'Hỗ trợ người lao động khi gặp rủi ro'),
('LBH12', N'Bảo hiểm giáo dục', N'Hỗ trợ chi phí học tập cho con cái'),
('LBH13', N'Bảo hiểm hưu trí', N'Đảm bảo tài chính khi về hưu'),
('LBH14', N'Bảo hiểm nông nghiệp', N'Bảo vệ mùa màng và gia súc'),
('LBH15', N'Bảo hiểm doanh nghiệp', N'Hỗ trợ doanh nghiệp trước rủi ro'),
('LBH16', N'Bảo hiểm hàng hải', N'Bảo vệ tàu thuyền và hàng hóa'),
('LBH17', N'Bảo hiểm xây dựng', N'Bảo vệ công trình xây dựng'),
('LBH18', N'Bảo hiểm tín dụng', N'Hỗ trợ khi khách hàng không thanh toán'),
('LBH19', N'Bảo hiểm môi trường', N'Chi trả thiệt hại môi trường'),
('LBH20', N'Bảo hiểm thú cưng', N'Hỗ trợ chi phí chăm sóc thú cưng');

-- 3. Bảng DichVuBaoHiem
INSERT INTO DichVuBaoHiem (MaDV, TenDV, MoTa, ChiPhiCoBan, MaLoaiBH) VALUES
('DV001', N'Bảo hiểm nhân thọ toàn diện', N'Chi trả toàn bộ rủi ro về sức khỏe và tính mạng', 15000000, 'LBH01'),
('DV002', N'Bảo hiểm y tế cơ bản', N'Hỗ trợ khám chữa bệnh thông thường', 2000000, 'LBH02'),
('DV003', N'Bảo hiểm xe máy', N'Bảo hiểm trách nhiệm dân sự cho xe máy', 500000, 'LBH03'),
('DV004', N'Bảo hiểm nhà ở', N'Chi trả thiệt hại do hỏa hoạn, thiên tai', 10000000, 'LBH04'),
('DV005', N'Bảo hiểm du lịch quốc tế', N'Hỗ trợ y tế và tai nạn khi đi nước ngoài', 3000000, 'LBH05'),
('DV006', N'Bảo hiểm sức khỏe cao cấp', N'Bao gồm bệnh hiểm nghèo và điều trị quốc tế', 12000000, 'LBH06'),
('DV007', N'Bảo hiểm tai nạn lao động', N'Chi trả khi xảy ra tai nạn tại nơi làm việc', 4000000, 'LBH07'),
('DV008', N'Bảo hiểm nhà chung cư', N'Bảo vệ căn hộ trước hỏa hoạn và ngập lụt', 8000000, 'LBH08'),
('DV009', N'Bảo hiểm trách nhiệm công cộng', N'Bảo vệ trước rủi ro pháp lý với bên thứ ba', 6000000, 'LBH09'),
('DV010', N'Bảo hiểm hàng hóa xuất khẩu', N'Bảo vệ hàng hóa trong quá trình vận chuyển quốc tế', 15000000, 'LBH10'),
('DV011', N'Bảo hiểm lao động thời vụ', N'Hỗ trợ người lao động ngắn hạn gặp rủi ro', 3000000, 'LBH11'),
('DV012', N'Bảo hiểm học vấn cấp 1', N'Hỗ trợ học phí và chi phí học tập tiểu học', 5000000, 'LBH12'),
('DV013', N'Bảo hiểm hưu trí cơ bản', N'Hỗ trợ tài chính khi nghỉ hưu', 7000000, 'LBH13'),
('DV014', N'Bảo hiểm mùa màng', N'Bảo vệ lúa và hoa màu trước thiên tai', 4000000, 'LBH14'),
('DV015', N'Bảo hiểm doanh nghiệp nhỏ', N'Hỗ trợ rủi ro kinh doanh cho doanh nghiệp nhỏ', 20000000, 'LBH15'),
('DV016', N'Bảo hiểm tàu cá', N'Bảo vệ tàu thuyền đánh cá trước bão và tai nạn', 18000000, 'LBH16'),
('DV017', N'Bảo hiểm công trình xây dựng', N'Bảo vệ dự án xây dựng trước rủi ro kỹ thuật', 25000000, 'LBH17'),
('DV018', N'Bảo hiểm tín dụng doanh nghiệp', N'Hỗ trợ khi khách hàng không thanh toán nợ', 15000000, 'LBH18'),
('DV019', N'Bảo hiểm ô nhiễm môi trường', N'Chi trả thiệt hại do ô nhiễm gây ra', 30000000, 'LBH19'),
('DV020', N'Bảo hiểm thú cưng cơ bản', N'Hỗ trợ chi phí y tế và chăm sóc thú cưng', 2000000, 'LBH20');

-- 4. Bảng DoiTac
INSERT INTO DoiTac (MaDoiTac, TenDoiTac, LoaiDoiTac, DiaChi, SoDienThoai) VALUES
('DT001', N'Công ty Bảo Việt', N'Bảo hiểm', N'23 Tôn Đức Thắng, Quận Hoàn Kiếm, Hà Nội', '0911112233'),
('DT002', N'Tập đoàn Prudential', N'Bảo hiểm', N'45 Nguyễn Thị Minh Khai, Quận 1, TP.HCM', '0922223344'),
('DT003', N'Ngân hàng Vietcombank', N'Ngân hàng', N'198 Trần Quang Khải, Quận 1, TP.HCM', '0933334455'),
('DT004', N'Công ty Manulife', N'Bảo hiểm', N'67 Lý Thái Tổ, Quận Hải Châu, Đà Nẵng', '0944445566'),
('DT005', N'Bệnh viện Chợ Rẫy', N'Y tế', N'201B Nguyễn Chí Thanh, Quận 5, TP.HCM', '0955556677'),
('DT006', N'Công ty AIA Việt Nam', N'Bảo hiểm', N'88 Lê Đại Hành, Quận Hoàn Kiếm, Hà Nội', '0966667788'),
('DT007', N'Ngân hàng BIDV', N'Ngân hàng', N'35 Hàng Vôi, Quận Hoàn Kiếm, Hà Nội', '0977778899'),
('DT008', N'Bệnh viện Bạch Mai', N'Y tế', N'78 Giải Phóng, Quận Đống Đa, Hà Nội', '0988889900'),
('DT009', N'Công ty Generali', N'Bảo hiểm', N'56 Nguyễn Du, Quận 1, TP.HCM', '0909990011'),
('DT010', N'Công ty PVI', N'Bảo hiểm', N'12 Lê Thánh Tôn, Quận Hoàn Kiếm, Hà Nội', '0910001122'),
('DT011', N'Ngân hàng Techcombank', N'Ngân hàng', N'15 Đào Duy Anh, Quận Phú Nhuận, TP.HCM', '0921112233'),
('DT012', N'Bệnh viện Đà Nẵng', N'Y tế', N'124 Hải Phòng, Quận Hải Châu, Đà Nẵng', '0932223344'),
('DT013', N'Công ty Chubb Việt Nam', N'Bảo hiểm', N'89 Phạm Ngọc Thạch, Quận 3, TP.HCM', '0943334455'),
('DT014', N'Công ty BIC', N'Bảo hiểm', N'34 Hùng Vương, Quận Ba Đình, Hà Nội', '0954445566'),
('DT015', N'Ngân hàng Agribank', N'Ngân hàng', N'23 Láng Hạ, Quận Đống Đa, Hà Nội', '0965556677'),
('DT016', N'Bệnh viện Huế', N'Y tế', N'16 Lê Lợi, TP. Huế', '0976667788'),
('DT017', N'Công ty Liberty', N'Bảo hiểm', N'67 Trần Hưng Đạo, Quận 1, TP.HCM', '0987778899'),
('DT018', N'Công ty Sun Life', N'Bảo hiểm', N'45 Điện Biên Phủ, Quận Ba Đình, Hà Nội', '0908889900'),
('DT019', N'Ngân hàng VPBank', N'Ngân hàng', N'89 Nguyễn Huệ, Quận 1, TP.HCM', '0919990011'),
('DT020', N'Bệnh viện Vinmec', N'Y tế', N'458 Minh Khai, Quận Hai Bà Trưng, Hà Nội', '0920001122');

-- 5. Bảng HopDong
INSERT INTO HopDong (MaHD, NgayLap, NgayHetHan, GiaTriHD, TrangThai, MaLoaiBH, MaDoiTac, MaKH) VALUES
('HD001', '2024-01-15', '2025-01-15', 25000000, N'Đang hiệu lực', 'LBH01', 'DT001', 'KH001'),
('HD002', '2024-03-10', '2025-03-10', 5000000, N'Đang hiệu lực', 'LBH02', 'DT002', 'KH002'),
('HD003', '2024-05-20', '2025-05-20', 1200000, N'Đang hiệu lực', 'LBH03', 'DT003', 'KH003'),
('HD004', '2024-07-01', '2026-07-01', 30000000, N'Đang hiệu lực', 'LBH04', 'DT004', 'KH004'),
('HD005', '2024-09-15', '2025-09-15', 7000000, N'Đang hiệu lực', 'LBH05', 'DT005', 'KH005'),
('HD006', '2024-02-10', '2025-02-10', 18000000, N'Đang hiệu lực', 'LBH06', 'DT006', 'KH006'),
('HD007', '2024-04-25', '2025-04-25', 6000000, N'Đang hiệu lực', 'LBH07', 'DT007', 'KH007'),
('HD008', '2024-06-15', '2026-06-15', 12000000, N'Đang hiệu lực', 'LBH08', 'DT008', 'KH008'),
('HD009', '2024-08-20', '2025-08-20', 9000000, N'Đang hiệu lực', 'LBH09', 'DT009', 'KH009'),
('HD010', '2024-10-01', '2025-10-01', 20000000, N'Đang hiệu lực', 'LBH10', 'DT010', 'KH010'),
('HD011', '2024-01-20', '2025-01-20', 4500000, N'Đang hiệu lực', 'LBH11', 'DT011', 'KH011'),
('HD012', '2024-03-05', '2026-03-05', 8000000, N'Đang hiệu lực', 'LBH12', 'DT012', 'KH012'),
('HD013', '2024-05-10', '2025-05-10', 10000000, N'Đang hiệu lực', 'LBH13', 'DT013', 'KH013'),
('HD014', '2024-07-15', '2025-07-15', 6000000, N'Đang hiệu lực', 'LBH14', 'DT014', 'KH014'),
('HD015', '2024-09-20', '2026-09-20', 25000000, N'Đang hiệu lực', 'LBH15', 'DT015', 'KH015'),
('HD016', '2024-02-15', '2025-02-15', 22000000, N'Đang hiệu lực', 'LBH16', 'DT016', 'KH016'),
('HD017', '2024-04-10', '2026-04-10', 30000000, N'Đang hiệu lực', 'LBH17', 'DT017', 'KH017'),
('HD018', '2024-06-20', '2025-06-20', 18000000, N'Đang hiệu lực', 'LBH18', 'DT018', 'KH018'),
('HD019', '2024-08-25', '2025-08-25', 35000000, N'Đang hiệu lực', 'LBH19', 'DT019', 'KH019'),
('HD020', '2024-10-10', '2025-10-10', 3000000, N'Đang hiệu lực', 'LBH20', 'DT020', 'KH020');

-- 6. Bảng ChiTietHopDong
INSERT INTO ChiTietHopDong (MaCT, MaHD, MaDV, SoTienBH, DieuKhoan) VALUES
('CT001', 'HD001', 'DV001', 20000000, N'Chi trả khi tử vong hoặc bệnh hiểm nghèo'),
('CT002', 'HD002', 'DV002', 3000000, N'Khám bệnh định kỳ miễn phí'),
('CT003', 'HD003', 'DV003', 500000, N'Trách nhiệm dân sự tối đa 100 triệu'),
('CT004', 'HD004', 'DV004', 25000000, N'Bồi thường thiệt hại do hỏa hoạn'),
('CT005', 'HD005', 'DV005', 5000000, N'Hỗ trợ y tế khẩn cấp quốc tế'),
('CT006', 'HD006', 'DV006', 15000000, N'Bảo hiểm bệnh ung thư và điều trị quốc tế'),
('CT007', 'HD007', 'DV007', 4000000, N'Chi trả tai nạn lao động'),
('CT008', 'HD008', 'DV008', 10000000, N'Bảo vệ căn hộ trước thiên tai'),
('CT009', 'HD009', 'DV009', 7000000, N'Bảo hiểm trách nhiệm công cộng'),
('CT010', 'HD010', 'DV010', 18000000, N'Bảo vệ hàng hóa xuất khẩu'),
('CT011', 'HD011', 'DV011', 3000000, N'Hỗ trợ lao động thời vụ khi tai nạn'),
('CT012', 'HD012', 'DV012', 6000000, N'Hỗ trợ học phí tiểu học'),
('CT013', 'HD013', 'DV013', 8000000, N'Hỗ trợ tài chính khi nghỉ hưu'),
('CT014', 'HD014', 'DV014', 4000000, N'Bảo vệ mùa màng trước thiên tai'),
('CT015', 'HD015', 'DV015', 20000000, N'Hỗ trợ doanh nghiệp nhỏ khi phá sản'),
('CT016', 'HD016', 'DV016', 15000000, N'Bảo vệ tàu cá trước bão'),
('CT017', 'HD017', 'DV017', 25000000, N'Bảo vệ công trình xây dựng'),
('CT018', 'HD018', 'DV018', 15000000, N'Hỗ trợ khi khách hàng không thanh toán'),
('CT019', 'HD019', 'DV019', 30000000, N'Chi trả thiệt hại do ô nhiễm'),
('CT020', 'HD020', 'DV020', 2000000, N'Hỗ trợ chi phí y tế thú cưng');

-- 7. Bảng NhanVien
INSERT INTO NhanVien (MaNV, HoTenNV, ChucVu, SoDienThoai, Email, DiaChi) VALUES
('NV001', N'Nguyễn Văn Hùng', N'Quản lý', '0901234567', 'nguyenvanhung@xai.com', N'123 Nguyễn Trãi, Quận 5, TP.HCM'),
('NV002', N'Trần Thị Ngọc Ánh', N'Nhân viên kinh doanh', '0912345678', 'tranthingocanh@xai.com', N'45 Lê Lợi, Quận Hoàn Kiếm, Hà Nội'),
('NV003', N'Phạm Quốc Bảo', N'Nhân viên chăm sóc khách hàng', '0933456789', 'phamquocbao@xai.com', N'78 Nguyễn Huệ, Quận Hải Châu, Đà Nẵng'),
('NV004', N'Lê Thị Hồng Nhung', N'Kế toán', '0944567890', 'lethihongnhung@xai.com', N'12 Pasteur, Quận 3, TP.HCM'),
('NV005', N'Hoàng Minh Tuấn', N'Nhân viên kỹ thuật', '0975678901', 'hoangminhtuan@xai.com', N'56 Hùng Vương, TP. Huế'),
('NV006', N'Nguyễn Thị Kim Oanh', N'Nhân viên kinh doanh', '0986789012', 'nguyenthikimoanh@xai.com', N'89 Lý Thường Kiệt, Quận Hoàn Kiếm, Hà Nội'),
('NV007', N'Trương Đình Nam', N'Quản lý khu vực', '0907890123', 'truongdinhnam@xai.com', N'34 Trần Phú, Quận 1, TP.HCM'),
('NV008', N'Vũ Thị Thanh Huyền', N'Nhân viên chăm sóc khách hàng', '0918901234', 'vuthithanhhuyen@xai.com', N'67 Lê Đại Hành, Quận Hải Châu, Đà Nẵng'),
('NV009', N'Đặng Văn Thành', N'Nhân viên kỹ thuật', '0939012345', 'dangvanthanh@xai.com', N'23 Tôn Đức Thắng, Quận Đống Đa, Hà Nội'),
('NV010', N'Bùi Thị Thu Hà', N'Kế toán', '0940123456', 'buithithuha@xai.com', N'45 Nguyễn Thị Minh Khai, Quận 1, TP.HCM'),
('NV011', N'Lý Văn Quang', N'Quản lý', '0971234567', 'lyvanquang@xai.com', N'12 Hai Bà Trưng, TP. Huế'),
('NV012', N'Phan Thị Minh Thư', N'Nhân viên kinh doanh', '0982345678', 'phanthiminhthu@xai.com', N'78 Trần Hưng Đạo, Quận Ba Đình, Hà Nội'),
('NV013', N'Ngô Văn Hoàng', N'Nhân viên kỹ thuật', '0903456789', 'ngovanhoang@xai.com', N'56 Lê Thánh Tôn, Quận 1, TP.HCM'),
('NV014', N'Hà Thị Ngọc Mai', N'Nhân viên chăm sóc khách hàng', '0914567890', 'hathingocmai@xai.com', N'89 Nguyễn Đình Chiểu, Quận Hải Châu, Đà Nẵng'),
('NV015', N'Tô Văn Đức', N'Quản lý khu vực', '0935678901', 'tovanduc@xai.com', N'34 Phạm Ngọc Thạch, Quận Đống Đa, Hà Nội'),
('NV016', N'Đỗ Thị Lan Anh', N'Kế toán', '0946789012', 'dothilananh@xai.com', N'67 Bạch Đằng, Quận 1, TP.HCM'),
('NV017', N'Vương Văn Long', N'Nhân viên kinh doanh', '0977890123', 'vuongvanlong@xai.com', N'23 Điện Biên Phủ, TP. Huế'),
('NV018', N'Trịnh Thị Hồng Phúc', N'Nhân viên chăm sóc khách hàng', '0988901234', 'trinhthihongphuc@xai.com', N'45 Lê Duẩn, Quận Ba Đình, Hà Nội'),
('NV019', N'Chu Văn Thắng', N'Nhân viên kỹ thuật', '0909012345', 'chuvanthang@xai.com', N'78 Võ Thị Sáu, Quận 3, TP.HCM'),
('NV020', N'Đào Thị Kim Liên', N'Quản lý', '0910123456', 'daothikimlien@xai.com', N'12 Nguyễn Công Trứ, Quận Hải Châu, Đà Nẵng');

-- 8. Bảng ThanhToan
INSERT INTO ThanhToan (MaTT, MaHD, MaKH, NgayTT, SoTien, PhuongThuc, TrangThai, MaNV) VALUES
('TT001', 'HD001', 'KH001', '2024-01-20', 25000000, N'Chuyển khoản', N'Hoàn tất', 'NV001'),
('TT002', 'HD002', 'KH002', '2024-03-15', 5000000, N'Tiền mặt', N'Hoàn tất', 'NV002'),
('TT003', 'HD003', 'KH003', '2024-05-25', 1200000, N'Thẻ tín dụng', N'Hoàn tất', 'NV003'),
('TT004', 'HD004', 'KH004', '2024-07-05', 30000000, N'Chuyển khoản', N'Hoàn tất', 'NV004'),
('TT005', 'HD005', 'KH005', '2024-09-20', 7000000, N'Tiền mặt', N'Hoàn tất', 'NV005'),
('TT006', 'HD006', 'KH006', '2024-02-15', 18000000, N'Thẻ tín dụng', N'Hoàn tất', 'NV006'),
('TT007', 'HD007', 'KH007', '2024-04-30', 6000000, N'Chuyển khoản', N'Hoàn tất', 'NV007'),
('TT008', 'HD008', 'KH008', '2024-06-20', 12000000, N'Tiền mặt', N'Hoàn tất', 'NV008'),
('TT009', 'HD009', 'KH009', '2024-08-25', 9000000, N'Thẻ tín dụng', N'Hoàn tất', 'NV009'),
('TT010', 'HD010', 'KH010', '2024-10-05', 20000000, N'Chuyển khoản', N'Hoàn tất', 'NV010'),
('TT011', 'HD011', 'KH011', '2024-01-25', 4500000, N'Tiền mặt', N'Hoàn tất', 'NV011'),
('TT012', 'HD012', 'KH012', '2024-03-10', 8000000, N'Thẻ tín dụng', N'Hoàn tất', 'NV012'),
('TT013', 'HD013', 'KH013', '2024-05-15', 10000000, N'Chuyển khoản', N'Hoàn tất', 'NV013'),
('TT014', 'HD014', 'KH014', '2024-07-20', 6000000, N'Tiền mặt', N'Hoàn tất', 'NV014'),
('TT015', 'HD015', 'KH015', '2024-09-25', 25000000, N'Chuyển khoản', N'Hoàn tất', 'NV015'),
('TT016', 'HD016', 'KH016', '2024-02-20', 22000000, N'Thẻ tín dụng', N'Hoàn tất', 'NV016'),
('TT017', 'HD017', 'KH017', '2024-04-15', 30000000, N'Chuyển khoản', N'Hoàn tất', 'NV017'),
('TT018', 'HD018', 'KH018', '2024-06-25', 18000000, N'Tiền mặt', N'Hoàn tất', 'NV018'),
('TT019', 'HD019', 'KH019', '2024-08-30', 35000000, N'Thẻ tín dụng', N'Hoàn tất', 'NV019'),
('TT020', 'HD020', 'KH020', '2024-10-15', 3000000, N'Chuyển khoản', N'Hoàn tất', 'NV020');

-- 9. Bảng HoSoYeuCau
INSERT INTO HoSoYeuCau (MaYeuCau, MaHD, NgayYeuCau, MoTa, SoTienYC, TrangThai) VALUES
('YC001', 'HD001', '2024-06-15', N'Yêu cầu chi trả do tai nạn giao thông', 15000000, N'Đã duyệt'),
('YC002', 'HD002', '2024-07-10', N'Yêu cầu thanh toán viện phí', 3000000, N'Đang xử lý'),
('YC003', 'HD003', '2024-08-20', N'Yêu cầu bồi thường xe máy hư hỏng', 1000000, N'Đã duyệt'),
('YC004', 'HD004', '2024-09-01', N'Yêu cầu chi trả thiệt hại do cháy nhà', 20000000, N'Đang xử lý'),
('YC005', 'HD005', '2024-10-05', N'Yêu cầu hỗ trợ y tế khi du lịch', 5000000, N'Đã duyệt'),
('YC006', 'HD006', '2024-05-20', N'Yêu cầu chi trả bệnh hiểm nghèo', 12000000, N'Đã duyệt'),
('YC007', 'HD007', '2024-06-25', N'Yêu cầu bồi thường tai nạn lao động', 4000000, N'Đang xử lý'),
('YC008', 'HD008', '2024-07-15', N'Yêu cầu chi trả thiệt hại căn hộ', 10000000, N'Đã duyệt'),
('YC009', 'HD009', '2024-08-10', N'Yêu cầu bồi thường trách nhiệm dân sự', 6000000, N'Đang xử lý'),
('YC010', 'HD010', '2024-09-20', N'Yêu cầu chi trả hàng hóa hư hỏng', 15000000, N'Đã duyệt'),
('YC011', 'HD011', '2024-05-30', N'Yêu cầu hỗ trợ lao động bị tai nạn', 3000000, N'Đã duyệt'),
('YC012', 'HD012', '2024-06-20', N'Yêu cầu chi trả học phí', 5000000, N'Đang xử lý'),
('YC013', 'HD013', '2024-07-25', N'Yêu cầu hỗ trợ tài chính hưu trí', 7000000, N'Đã duyệt'),
('YC014', 'HD014', '2024-08-15', N'Yêu cầu bồi thường mùa màng thất thu', 4000000, N'Đang xử lý'),
('YC015', 'HD015', '2024-09-25', N'Yêu cầu chi trả rủi ro kinh doanh', 20000000, N'Đã duyệt'),
('YC016', 'HD016', '2024-06-10', N'Yêu cầu bồi thường tàu cá hư hỏng', 15000000, N'Đã duyệt'),
('YC017', 'HD017', '2024-07-20', N'Yêu cầu chi trả thiệt hại công trình', 25000000, N'Đang xử lý'),
('YC018', 'HD018', '2024-08-25', N'Yêu cầu hỗ trợ tín dụng doanh nghiệp', 15000000, N'Đã duyệt'),
('YC019', 'HD019', '2024-09-30', N'Yêu cầu chi trả thiệt hại môi trường', 30000000, N'Đang xử lý'),
('YC020', 'HD020', '2024-10-15', N'Yêu cầu hỗ trợ chi phí thú cưng', 2000000, N'Đã duyệt');

-- 10. Bảng LichSuThayDoiHD
INSERT INTO LichSuThayDoiHD (MaThayDoi, MaHD, NgayThayDoi, NoiDungThayDoi, MaNV) VALUES
('TD001', 'HD001', '2024-03-01', N'Cập nhật thông tin khách hàng', 'NV001'),
('TD002', 'HD002', '2024-04-15', N'Thêm điều khoản bảo hiểm phụ', 'NV002'),
('TD003', 'HD003', '2024-06-10', N'Gia hạn thời gian hợp đồng', 'NV003'),
('TD004', 'HD004', '2024-08-05', N'Thay đổi số tiền bảo hiểm', 'NV004'),
('TD005', 'HD005', '2024-09-20', N'Cập nhật địa chỉ khách hàng', 'NV005'),
('TD006', 'HD006', '2024-03-15', N'Thêm dịch vụ bảo hiểm sức khỏe', 'NV006'),
('TD007', 'HD007', '2024-05-20', N'Hủy điều khoản phụ', 'NV007'),
('TD008', 'HD008', '2024-07-10', N'Gia hạn hợp đồng thêm 6 tháng', 'NV008'),
('TD009', 'HD009', '2024-08-25', N'Thay đổi phương thức thanh toán', 'NV009'),
('TD010', 'HD010', '2024-10-10', N'Cập nhật thông tin đối tác', 'NV010'),
('TD011', 'HD011', '2024-02-28', N'Thêm điều khoản trách nhiệm', 'NV011'),
('TD012', 'HD012', '2024-04-20', N'Điều chỉnh số tiền bảo hiểm', 'NV012'),
('TD013', 'HD013', '2024-06-15', N'Cập nhật thông tin liên lạc', 'NV013'),
('TD014', 'HD014', '2024-08-10', N'Thêm dịch vụ bảo hiểm phụ', 'NV014'),
('TD015', 'HD015', '2024-09-30', N'Gia hạn hợp đồng thêm 1 năm', 'NV015'),
('TD016', 'HD016', '2024-03-20', N'Thay đổi điều khoản bồi thường', 'NV016'),
('TD017', 'HD017', '2024-05-25', N'Cập nhật thông tin doanh nghiệp', 'NV017'),
('TD018', 'HD018', '2024-07-15', N'Hủy dịch vụ bảo hiểm phụ', 'NV018'),
('TD019', 'HD019', '2024-09-05', N'Thay đổi số tiền yêu cầu bồi thường', 'NV019'),
('TD020', 'HD020', '2024-10-20', N'Cập nhật thông tin thú cưng', 'NV020');

-- 11. Bảng YeuCauBoiThuong
INSERT INTO YeuCauBoiThuong (MaYC, MaYeuCau, NgayYeuCau, SoTienBoiThuong, TrangThai, MaNV) VALUES
('BT001', 'YC001', '2024-06-20', 15000000, N'Đã duyệt', 'NV001'),
('BT002', 'YC002', '2024-07-15', 3000000, N'Đang xử lý', 'NV002'),
('BT003', 'YC003', '2024-08-25', 1000000, N'Đã duyệt', 'NV003'),
('BT004', 'YC004', '2024-09-05', 20000000, N'Đang xử lý', 'NV004'),
('BT005', 'YC005', '2024-10-10', 5000000, N'Đã duyệt', 'NV005'),
('BT006', 'YC006', '2024-05-25', 12000000, N'Đã duyệt', 'NV006'),
('BT007', 'YC007', '2024-06-30', 4000000, N'Đang xử lý', 'NV007'),
('BT008', 'YC008', '2024-07-20', 10000000, N'Đã duyệt', 'NV008'),
('BT009', 'YC009', '2024-08-15', 6000000, N'Đang xử lý', 'NV009'),
('BT010', 'YC010', '2024-09-25', 15000000, N'Đã duyệt', 'NV010'),
('BT011', 'YC011', '2024-06-05', 3000000, N'Đã duyệt', 'NV011'),
('BT012', 'YC012', '2024-06-25', 5000000, N'Đang xử lý', 'NV012'),
('BT013', 'YC013', '2024-07-30', 7000000, N'Đã duyệt', 'NV013'),
('BT014', 'YC014', '2024-08-20', 4000000, N'Đang xử lý', 'NV014'),
('BT015', 'YC015', '2024-09-30', 20000000, N'Đã duyệt', 'NV015'),
('BT016', 'YC016', '2024-06-15', 15000000, N'Đã duyệt', 'NV016'),
('BT017', 'YC017', '2024-07-25', 25000000, N'Đang xử lý', 'NV017'),
('BT018', 'YC018', '2024-08-30', 15000000, N'Đã duyệt', 'NV018'),
('BT019', 'YC019', '2024-10-05', 30000000, N'Đang xử lý', 'NV019'),
('BT020', 'YC020', '2024-10-20', 2000000, N'Đã duyệt', 'NV020');

-- Hien thi du lieu tu cac bang
SELECT * FROM KhachHang;
SELECT * FROM HopDong;
SELECT * FROM LoaiBaoHiem;
SELECT * FROM DichVuBaoHiem;
SELECT * FROM ChiTietHopDong;
SELECT * FROM ThanhToan;
SELECT * FROM HoSoYeuCau;
SELECT * FROM NhanVien;
SELECT * FROM LichSuThayDoiHD;
SELECT * FROM DoiTac;
SELECT * FROM YeuCauBoiThuong;

-- View 1
CREATE VIEW v_KhachHang_HopDong AS
SELECT kh.MaKH, kh.HoTen, hd.MaHD, hd.NgayLap, hd.NgayHetHan, hd.GiaTriHD, hd.TrangThai
FROM KhachHang kh
JOIN HopDong hd ON kh.MaKH = hd.MaKH;

-- View 2
CREATE VIEW v_ChiTiet_HopDong AS
SELECT ct.MaCT, ct.MaHD, dv.TenDV, ct.SoTienBH, ct.DieuKhoan
FROM ChiTietHopDong ct
JOIN DichVuBaoHiem dv ON ct.MaDV = dv.MaDV;

-- View 3
CREATE VIEW v_HopDong_HetHan AS
SELECT MaHD, MaKH, NgayLap, NgayHetHan, GiaTriHD, TrangThai
FROM HopDong
WHERE TrangThai = N'Đã hết hạn';

-- View 4
CREATE VIEW v_TongTienBaoHiem_KhachHang AS
SELECT kh.MaKH, kh.HoTen, SUM(hd.GiaTriHD) AS TongTienBaoHiem
FROM KhachHang kh
JOIN HopDong hd ON kh.MaKH = hd.MaKH
GROUP BY kh.MaKH, kh.HoTen;

-- View 5 
CREATE VIEW v_ThanhToan_HopDong AS
SELECT tt.MaTT, tt.MaHD, hd.NgayLap, tt.NgayTT, tt.SoTien, tt.PhuongThuc, tt.TrangThai
FROM ThanhToan tt
JOIN HopDong hd ON tt.MaHD = hd.MaHD;

-- View 6
CREATE VIEW v_YeuCau_DangXuLy AS
SELECT MaYeuCau, MaHD, NgayYeuCau, MoTa, SoTienYC, TrangThai
FROM HoSoYeuCau
WHERE TrangThai = N'Đang xử lý';

-- View 7
CREATE VIEW v_LichSuThayDoi_HopDong AS
SELECT ls.MaThayDoi, ls.MaHD, ls.NgayThayDoi, ls.NoiDungThayDoi, nv.HoTenNV AS NhanVienThucHien
FROM LichSuThayDoiHD ls
JOIN NhanVien nv ON ls.MaNV = nv.MaNV;

-- View 8
CREATE VIEW v_KhachHang_KhongCoHopDong AS
SELECT kh.MaKH, kh.HoTen, kh.SoDienThoai, kh.Email
FROM KhachHang kh
LEFT JOIN HopDong hd ON kh.MaKH = hd.MaKH
WHERE hd.MaHD IS NULL;

-- View 9
CREATE VIEW v_TongTienThanhToan_KhachHang AS
SELECT kh.MaKH, kh.HoTen, SUM(tt.SoTien) AS TongTienDaThanhToan
FROM KhachHang kh
JOIN HopDong hd ON kh.MaKH = hd.MaKH
JOIN ThanhToan tt ON hd.MaHD = tt.MaHD
GROUP BY kh.MaKH, kh.HoTen;

-- View 10
CREATE VIEW v_HopDong_GiaTriCaoNhat AS
SELECT MaHD, MaKH, GiaTriHD
FROM HopDong
WHERE GiaTriHD = (SELECT MAX(GiaTriHD) FROM HopDong);

-- In kết quả các view
SELECT * FROM v_KhachHang_HopDong;
SELECT * FROM v_ChiTiet_HopDong;
SELECT * FROM v_HopDong_HetHan;
SELECT * FROM v_TongTienBaoHiem_KhachHang;
SELECT * FROM v_ThanhToan_HopDong;
SELECT * FROM v_YeuCau_DangXuLy;
SELECT * FROM v_LichSuThayDoi_HopDong;
SELECT * FROM v_KhachHang_KhongCoHopDong;
SELECT * FROM v_TongTienThanhToan_KhachHang;
SELECT * FROM v_HopDong_GiaTriCaoNhat;

-- Procedure 1
CREATE PROCEDURE sp_LayThongTinKhachHang
    @MaKH VARCHAR(20)
AS
BEGIN
    SELECT MaKH, HoTen, NgaySinh, SoDienThoai, Email, DiaChi
    FROM KhachHang
    WHERE MaKH = @MaKH
END

--In kết quả
EXEC sp_LayThongTinKhachHang 'KH001';

-- Procedure 2
CREATE PROCEDURE sp_ThemHopDong
    @MaHD VARCHAR(20),
    @MaKH VARCHAR(20),
    @MaLoaiBH VARCHAR(20),
    @MaDoiTac VARCHAR(20) = NULL,
    @NgayLap DATE,
    @NgayHetHan DATE,
    @GiaTriHD DECIMAL(18,2),
    @TrangThai NVARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM HopDong WHERE MaHD = @MaHD)
    BEGIN
        RAISERROR (N'Mã hợp đồng %s đã tồn tại trong hệ thống.', 16, 1, @MaHD);
        RETURN;
    END

    INSERT INTO HopDong (MaHD, MaKH, MaLoaiBH, MaDoiTac, NgayLap, NgayHetHan, GiaTriHD, TrangThai)
    VALUES (@MaHD, @MaKH, @MaLoaiBH, @MaDoiTac, @NgayLap, @NgayHetHan, @GiaTriHD, @TrangThai)
    
    SELECT * FROM HopDong WHERE MaHD = @MaHD
END

--In kết quả
EXEC sp_ThemHopDong 'HD021', 'KH001', 'LBH01', NULL, '2023-11-01', '2024-11-01', 700000000, N'Đang hiệu lực';

-- Procedure 3
CREATE PROCEDURE sp_CapNhatTrangThaiHopDong
    @MaHD VARCHAR(20),
    @TrangThaiMoi NVARCHAR(50)
AS
BEGIN
    UPDATE HopDong
    SET TrangThai = @TrangThaiMoi
    WHERE MaHD = @MaHD
    SELECT * FROM HopDong WHERE MaHD = @MaHD
END

--In kết quả
EXEC sp_CapNhatTrangThaiHopDong 'HD001', N'Đã hết hạn';

-- Procedure 4
CREATE PROCEDURE sp_LayHopDongTheoKhachHang
    @MaKH VARCHAR(20)
AS
BEGIN
    SELECT MaHD, MaKH, NgayLap, NgayHetHan, GiaTriHD, TrangThai
    FROM HopDong
    WHERE MaKH = @MaKH
END

--In kết quả
EXEC sp_LayHopDongTheoKhachHang 'KH002';

-- Procedure 5 
CREATE PROCEDURE sp_TongGiaTriHopDongTheoTrangThai
    @TrangThai NVARCHAR(50)
AS
BEGIN
    SELECT @TrangThai AS TrangThai, SUM(GiaTriHD) AS TongGiaTri
    FROM HopDong
    WHERE TrangThai = @TrangThai
END

--In kết quả
EXEC sp_TongGiaTriHopDongTheoTrangThai N'Đang hiệu lực';

-- Procedure 6
CREATE PROCEDURE sp_LayChiTietHopDong
    @MaHD VARCHAR(20)
AS
BEGIN
    SELECT ct.MaCT, ct.MaHD, dv.TenDV, ct.SoTienBH, ct.DieuKhoan
    FROM ChiTietHopDong ct
    JOIN DichVuBaoHiem dv ON ct.MaDV = dv.MaDV
    WHERE ct.MaHD = @MaHD
END

--In kết quả
EXEC sp_LayChiTietHopDong 'HD003';

-- Procedure 7 
CREATE PROCEDURE sp_ThemThanhToan
    @MaTT VARCHAR(20),
    @MaHD VARCHAR(20),
    @MaKH VARCHAR(20) = NULL,
    @MaNV VARCHAR(20) = NULL,
    @NgayTT DATE,
    @SoTien DECIMAL(18,2),
    @PhuongThuc NVARCHAR(50),
    @TrangThai NVARCHAR(50)
AS
BEGIN
    INSERT INTO ThanhToan (MaTT, MaHD, MaKH, MaNV, NgayTT, SoTien, PhuongThuc, TrangThai)
    VALUES (@MaTT, @MaHD, @MaKH, @MaNV, @NgayTT, @SoTien, @PhuongThuc, @TrangThai)
    SELECT * FROM ThanhToan WHERE MaTT = @MaTT
END

--In kết quả
EXEC sp_ThemThanhToan 'TT021', 'HD001', NULL, NULL, '2023-11-15', 200000000, N'Chuyển khoản', N'Đã thanh toán';

-- Procedure 8
CREATE PROCEDURE sp_LayYeuCauBaoHiemTheoTrangThai
    @TrangThai NVARCHAR(50)
AS
BEGIN
    SELECT MaYeuCau, MaHD, NgayYeuCau, MoTa, SoTienYC, TrangThai
    FROM HoSoYeuCau
    WHERE TrangThai = @TrangThai
END

--In kết quả
EXEC sp_LayYeuCauBaoHiemTheoTrangThai N'Đang xử lý';

-- Procedure 9
CREATE PROCEDURE sp_CapNhatNhanVien
    @MaNV VARCHAR(20),
    @SoDienThoaiMoi VARCHAR(15)
AS
BEGIN
    UPDATE NhanVien
    SET SoDienThoai = @SoDienThoaiMoi
    WHERE MaNV = @MaNV
    SELECT * FROM NhanVien WHERE MaNV = @MaNV
END

--In kết quả
EXEC sp_CapNhatNhanVien 'NV001', '0912345678';

-- Procedure 10
CREATE PROCEDURE sp_LayLichSuThayDoiHopDong
    @MaHD VARCHAR(20)
AS
BEGIN
    SELECT ls.MaThayDoi, ls.MaHD, ls.NgayThayDoi, ls.NoiDungThayDoi, nv.HoTenNV AS NhanVienThucHien
    FROM LichSuThayDoiHD ls
    JOIN NhanVien nv ON ls.MaNV = nv.MaNV
    WHERE ls.MaHD = @MaHD
END

--In kết quả
EXEC sp_LayLichSuThayDoiHopDong 'HD004';

-- Trigger 1: Ghi log vào LichSuThayDoiHD khi thêm khách hàng mới vào KhachHang
CREATE TRIGGER tr_ThemKhachHang
ON KhachHang
AFTER INSERT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV = 'NV001')
    BEGIN
        RAISERROR (N'Mã nhân viên NV001 không tồn tại.', 16, 1);
        RETURN;
    END
    INSERT INTO LichSuThayDoiHD (MaThayDoi, MaHD, NgayThayDoi, NoiDungThayDoi, MaNV)
    SELECT 'TD' + RIGHT('000' + CAST((SELECT COUNT(*) FROM LichSuThayDoiHD) + 1 AS VARCHAR), 3), 
           NULL, GETDATE(), N'Thêm khách hàng mới: ' + i.HoTen, 'NV001'
    FROM inserted i
END

-- Kiểm tra
INSERT INTO KhachHang (MaKH, HoTen, NgaySinh, SoDienThoai, Email, DiaChi) 
SELECT 
    'KH' + RIGHT('000' + CAST(COALESCE(MAX(CAST(RIGHT(MaKH, 3) AS INT)), 0) + 1 AS VARCHAR), 3),
    N'Nguyen Thi Moi', '1990-01-01', '0901234571', 'nguyenthimoi@gmail.com', N'123 Ly Thuong Kiet, HCM'
FROM KhachHang;
SELECT * FROM LichSuThayDoiHD WHERE NoiDungThayDoi LIKE N'Thêm khách hàng mới%';

-- Trigger 2: Kiểm tra GiaTriHD không âm trước khi thêm hợp đồng vào HopDong
CREATE TRIGGER tr_KiemTraGiaTriHopDong
ON HopDong
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE GiaTriHD < 0)
    BEGIN
        RAISERROR (N'Giá trị hợp đồng không được âm', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO HopDong (MaHD, MaKH, MaLoaiBH, MaDoiTac, NgayLap, NgayHetHan, GiaTriHD, TrangThai)
        SELECT MaHD, MaKH, MaLoaiBH, MaDoiTac, NgayLap, NgayHetHan, GiaTriHD, TrangThai FROM inserted
    END
END

-- Kiểm tra
INSERT INTO HopDong (MaHD, MaKH, MaLoaiBH, MaDoiTac, NgayLap, NgayHetHan, GiaTriHD, TrangThai) 
VALUES ('HD022', 'KH001', 'LBH01', NULL, '2023-11-01', '2025-11-01', 1000000, N'Đang hiệu lực');
SELECT * FROM HopDong WHERE MaHD = 'HD022';

-- Trigger 3: Cập nhật TrangThai thành "Đã hết hạn" nếu NgayHetHan nhỏ hơn ngày hiện tại sau khi cập nhật HopDong
CREATE TRIGGER tr_CapNhatTrangThaiHopDong
ON HopDong
AFTER UPDATE
AS
BEGIN
    UPDATE HopDong
    SET TrangThai = N'Đã hết hạn'
    WHERE MaHD IN (SELECT MaHD FROM inserted WHERE NgayHetHan < GETDATE())
END

-- Kiểm tra
UPDATE HopDong SET NgayHetHan = '2025-01-01' WHERE MaHD = 'HD001';
SELECT * FROM HopDong WHERE MaHD = 'HD001';

-- Trigger 4: Ghi log vào LichSuThayDoiHD khi thêm chi tiết hợp đồng vào ChiTietHopDong
CREATE TRIGGER tr_ThemChiTietHopDong
ON ChiTietHopDong
AFTER INSERT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV = 'NV002')
    BEGIN
        RAISERROR (N'Mã nhân viên NV002 không tồn tại.', 16, 1);
        RETURN;
    END
    INSERT INTO LichSuThayDoiHD (MaThayDoi, MaHD, NgayThayDoi, NoiDungThayDoi, MaNV)
    SELECT 'TD' + RIGHT('000' + CAST((SELECT COUNT(*) FROM LichSuThayDoiHD) + 1 AS VARCHAR), 3), 
           i.MaHD, GETDATE(), N'Thêm chi tiết hợp đồng: ' + i.MaCT, 'NV002'
    FROM inserted i
END

-- Kiểm tra
INSERT INTO ChiTietHopDong (MaCT, MaHD, MaDV, SoTienBH, DieuKhoan) 
VALUES ('CT021', 'HD001', 'DV001', 150000000, N'Chi trả mỗi năm');
SELECT * FROM LichSuThayDoiHD WHERE NoiDungThayDoi LIKE N'Thêm chi tiết hợp đồng%';

-- Trigger 5: Kiểm tra SoTien không vượt quá GiaTriHD của hợp đồng trước khi thêm vào ThanhToan
CREATE TRIGGER tr_KiemTraThanhToan
ON ThanhToan
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted i JOIN HopDong h ON i.MaHD = h.MaHD WHERE i.SoTien > h.GiaTriHD)
    BEGIN
        RAISERROR (N'Số tiền thanh toán không được vượt quá giá trị hợp đồng', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO ThanhToan (MaTT, MaHD, MaKH, MaNV, NgayTT, SoTien, PhuongThuc, TrangThai)
        SELECT MaTT, MaHD, MaKH, MaNV, NgayTT, SoTien, PhuongThuc, TrangThai FROM inserted
    END
END

-- Kiểm tra
INSERT INTO ThanhToan (MaTT, MaHD, MaKH, MaNV, NgayTT, SoTien, PhuongThuc, TrangThai) 
VALUES ('TT022', 'HD001', NULL, NULL, '2023-11-01', 6000000, N'Chuyển khoản', N'Đã thanh toán');
SELECT * FROM ThanhToan WHERE MaTT = 'TT022';

-- Trigger 6: Cập nhật TrangThai của HoSoYeuCau thành "Đã xử lý" khi thêm yêu cầu bồi thường với trạng thái "Đã thanh toán" vào YeuCauBoiThuong
CREATE TRIGGER tr_CapNhatYeuCauBoiThuong
ON YeuCauBoiThuong
AFTER INSERT
AS
BEGIN
    UPDATE HoSoYeuCau
    SET TrangThai = N'Đã xử lý'
    WHERE MaYeuCau IN (SELECT MaYeuCau FROM inserted WHERE TrangThai = N'Đã thanh toán')
END

-- Kiểm tra
INSERT INTO YeuCauBoiThuong (MaYC, MaYeuCau, NgayYeuCau, SoTienBoiThuong, TrangThai) 
VALUES ('YC_BT021', 'YC002', '2023-11-01', 80000000, N'Đã thanh toán');
SELECT * FROM HoSoYeuCau WHERE MaYeuCau = 'YC002';

-- Trigger 7: Ghi log vào LichSuThayDoiHD khi trạng thái thanh toán trong ThanhToan thay đổi
CREATE TRIGGER tr_LogThayDoiTrangThaiThanhToan
ON ThanhToan
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV = 'NV003')
    BEGIN
        RAISERROR (N'Mã nhân viên NV003 không tồn tại.', 16, 1);
        RETURN;
    END
    INSERT INTO LichSuThayDoiHD (MaThayDoi, MaHD, NgayThayDoi, NoiDungThayDoi, MaNV)
    SELECT 
        'TD' + RIGHT('000000' + CAST(
            ROW_NUMBER() OVER (ORDER BY GETDATE()) + 
            (SELECT COUNT(*) FROM LichSuThayDoiHD) AS VARCHAR), 6), 
        i.MaHD, 
        GETDATE(), 
        N'Thay đổi trạng thái thanh toán hợp đồng ' + i.MaHD + N' từ "' + d.TrangThai + N'" sang "' + i.TrangThai + N'"', 
        'NV003'
    FROM inserted i
    JOIN deleted d ON i.MaTT = d.MaTT
    WHERE i.TrangThai <> d.TrangThai;
END

-- Kiểm tra
INSERT INTO ThanhToan (MaTT, MaHD, NgayTT, SoTien, PhuongThuc, TrangThai) 
VALUES ('TT998', 'HD001', '2024-03-01', 2000000, N'Chuyển khoản', N'Chưa thanh toán');
UPDATE ThanhToan SET TrangThai = N'Đã thanh toán' WHERE MaTT = 'TT998';
SELECT * FROM LichSuThayDoiHD WHERE NoiDungThayDoi LIKE N'Thay đổi trạng thái thanh toán hợp đồng HD001%';

-- Trigger 8: Kiểm tra NgayYeuCau không lớn hơn ngày hiện tại trước khi thêm vào HoSoYeuCau
CREATE TRIGGER tr_KiemTraNgayYeuCau
ON HoSoYeuCau
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE NgayYeuCau > GETDATE())
    BEGIN
        RAISERROR (N'Ngày yêu cầu không được lớn hơn ngày hiện tại', 16, 1)
    END
    ELSE
    BEGIN
        INSERT INTO HoSoYeuCau (MaYeuCau, MaHD, NgayYeuCau, MoTa, SoTienYC, TrangThai)
        SELECT MaYeuCau, MaHD, NgayYeuCau, MoTa, SoTienYC, TrangThai FROM inserted
    END
END

-- Kiểm tra
INSERT INTO HoSoYeuCau (MaYeuCau, MaHD, NgayYeuCau, MoTa, SoTienYC, TrangThai) 
VALUES ('YC021', 'HD001', '2025-01-01', N'Tai nạn', 100000000, N'Đang xử lý');
SELECT * FROM HoSoYeuCau WHERE MaYeuCau = 'YC021';

-- Trigger 9: Ghi log vào LichSuThayDoiHD khi cập nhật thông tin nhân viên trong NhanVien
CREATE TRIGGER tr_CapNhatNhanVien
ON NhanVien
AFTER UPDATE
AS
BEGIN
    INSERT INTO LichSuThayDoiHD (MaThayDoi, MaHD, NgayThayDoi, NoiDungThayDoi, MaNV)
    SELECT 'TD' + RIGHT('000' + CAST((SELECT COUNT(*) FROM LichSuThayDoiHD) + 1 AS VARCHAR), 3), 
           NULL, GETDATE(), N'Cập nhật nhân viên: ' + i.HoTenNV, i.MaNV
    FROM inserted i
END

-- Kiểm tra
UPDATE NhanVien SET SoDienThoai = '0912345678' WHERE MaNV = 'NV001';
SELECT * FROM LichSuThayDoiHD WHERE NoiDungThayDoi LIKE N'Cập nhật nhân viên%';

-- Trigger 10: Kiểm tra SoDienThoai bắt đầu bằng "0" và có 10 chữ số trước khi thêm vào DoiTac
CREATE TRIGGER tr_KiemTraDoiTac
ON DoiTac
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE SoDienThoai NOT LIKE '0%' OR LEN(SoDienThoai) != 10)
    BEGIN
        RAISERROR (N'Số điện thoại đối tác phải bắt đầu bằng 0 và có 10 chữ số', 16, 1)
    END
    ELSE
    BEGIN
        INSERT INTO DoiTac (MaDoiTac, TenDoiTac, LoaiDoiTac, DiaChi, SoDienThoai)
        SELECT MaDoiTac, TenDoiTac, LoaiDoiTac, DiaChi, SoDienThoai FROM inserted
    END
END

-- Kiểm tra
INSERT INTO DoiTac (MaDoiTac, TenDoiTac, LoaiDoiTac, DiaChi, SoDienThoai) 
VALUES ('DT021', N'Công ty Mới', N'Bảo hiểm', N'123 Trần Phú, HCM', '0923456712');
SELECT * FROM DoiTac WHERE MaDoiTac = 'DT021';

--1. Tạo các role
-- Tạo role cho Nhân viên
CREATE ROLE NhanVien;

-- Tạo role cho Quản lý
CREATE ROLE QuanLy;

-- Tạo role cho Khách hàng
CREATE ROLE KhachHang;

-- Tạo role cho Đối tác
CREATE ROLE DoiTac;

--2. Phân quyền cho từng role
--*******role QuanLy*******
-- Quyền trên bảng
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON SCHEMA::dbo TO QuanLy;

--*******role NhanVien******
-- Quyền trên bảng
GRANT SELECT, INSERT, UPDATE ON KhachHang TO NhanVien;
GRANT SELECT, INSERT, UPDATE ON HopDong TO NhanVien;
GRANT SELECT, INSERT, UPDATE ON ChiTietHopDong TO NhanVien;
GRANT SELECT, INSERT, UPDATE ON ThanhToan TO NhanVien;
GRANT SELECT, INSERT, UPDATE ON HoSoYeuCau TO NhanVien;
GRANT SELECT, INSERT, UPDATE ON YeuCauBoiThuong TO NhanVien;
GRANT SELECT ON LoaiBaoHiem TO NhanVien; 
GRANT SELECT ON DichVuBaoHiem TO NhanVien; 
GRANT SELECT ON DoiTac TO NhanVien; 
GRANT SELECT, INSERT ON LichSuThayDoiHD TO NhanVien;

-- Quyền trên view
GRANT SELECT ON v_KhachHang_HopDong TO NhanVien;
GRANT SELECT ON v_ChiTiet_HopDong TO NhanVien;
GRANT SELECT ON v_ThanhToan_HopDong TO NhanVien;
GRANT SELECT ON v_YeuCau_DangXuLy TO NhanVien;
GRANT SELECT ON v_LichSuThayDoi_HopDong TO NhanVien;

-- Quyền trên procedure
GRANT EXECUTE ON sp_LayThongTinKhachHang TO NhanVien;
GRANT EXECUTE ON sp_ThemHopDong TO NhanVien;
GRANT EXECUTE ON sp_CapNhatTrangThaiHopDong TO NhanVien;
GRANT EXECUTE ON sp_LayHopDongTheoKhachHang TO NhanVien;
GRANT EXECUTE ON sp_LayChiTietHopDong TO NhanVien;
GRANT EXECUTE ON sp_ThemThanhToan TO NhanVien;
GRANT EXECUTE ON sp_LayYeuCauBaoHiemTheoTrangThai TO NhanVien;
GRANT EXECUTE ON sp_LayLichSuThayDoiHopDong TO NhanVien;

--*****role KhachHang******
--Để tăng mức độ bảo mật nên chỉ cấp quyền view và procedure cho KhachHang
--Để tăng bảo mật chúng ta nên tạo view chỉ cho KhachHang thấy dữ liệu của họ
CREATE VIEW v_KhachHang_CaNhan
AS
SELECT MaKH, HoTen, NgaySinh, SoDienThoai, Email, DiaChi, GioiTinh
FROM KhachHang
WHERE MaKH = USER_NAME();

CREATE VIEW v_HopDong_CaNhan
AS
SELECT MaHD, NgayLap, NgayHetHan, GiaTriHD, TrangThai, MaLoaiBH, MaDoiTac, MaKH
FROM HopDong
WHERE MaKH = USER_NAME();

CREATE VIEW v_ThanhToan_CaNhan
AS
SELECT MaTT, MaHD, MaKH, MaNV, NgayTT, SoTien, PhuongThuc, TrangThai
FROM ThanhToan
WHERE MaKH = USER_NAME();

-- Cấp quyền trên view
GRANT SELECT ON v_KhachHang_CaNhan TO KhachHang;
GRANT SELECT ON v_HopDong_CaNhan TO KhachHang;
GRANT SELECT ON v_ThanhToan_CaNhan TO KhachHang;

-- Cấp quyền procedure
GRANT EXECUTE ON sp_LayThongTinKhachHang TO KhachHang;
GRANT EXECUTE ON sp_LayHopDongTheoKhachHang TO KhachHang;
GRANT EXECUTE ON sp_LayChiTietHopDong TO KhachHang;

-- Từ chối quyền trực tiếp trên bảng
DENY SELECT, INSERT, UPDATE, DELETE ON KhachHang TO KhachHang;
DENY SELECT, INSERT, UPDATE, DELETE ON HopDong TO KhachHang;
DENY SELECT, INSERT, UPDATE, DELETE ON ThanhToan TO KhachHang;

--******role DoiTac******
-- Tạo view chỉ cho DoiTac thấy dữ liệu của họ
CREATE VIEW v_DoiTac_CaNhan
AS
SELECT MaDoiTac, TenDoiTac, LoaiDoiTac, DiaChi, SoDienThoai
FROM DoiTac
WHERE MaDoiTac = USER_NAME();

CREATE VIEW v_HopDong_DoiTac
AS
SELECT MaHD, NgayLap, NgayHetHan, GiaTriHD, TrangThai, MaLoaiBH, MaDoiTac, MaKH
FROM HopDong
WHERE MaDoiTac = USER_NAME();

-- Cấp quyền trên view
GRANT SELECT ON v_DoiTac_CaNhan TO DoiTac;
GRANT SELECT ON v_HopDong_DoiTac TO DoiTac;

-- Cấp quyền procedure
GRANT EXECUTE ON sp_LayHopDongTheoKhachHang TO DoiTac;

-- Từ chối quyền trực tiếp trên bảng
DENY SELECT, INSERT, UPDATE, DELETE ON DoiTac TO DoiTac;
DENY SELECT, INSERT, UPDATE, DELETE ON HopDong TO DoiTac;

-- 3. Tạo người dùng và gán role
CREATE LOGIN NhanVien1 WITH PASSWORD = 'NhanVien';
CREATE USER NhanVien1 FOR LOGIN NhanVien1;
ALTER ROLE NhanVien ADD MEMBER NhanVien1;


CREATE LOGIN QuanLy1 WITH PASSWORD = 'QuanLy';
CREATE USER QuanLy1 FOR LOGIN QuanLy1;
ALTER ROLE QuanLy ADD MEMBER QuanLy1;

CREATE LOGIN KH001 WITH PASSWORD = 'KhachHang';
CREATE USER KH001 FOR LOGIN KH001;
ALTER ROLE KhachHang ADD MEMBER KH001;


CREATE LOGIN DT002 WITH PASSWORD = 'DoiTac';
CREATE USER DT002 FOR LOGIN DT002;
ALTER ROLE DoiTac ADD MEMBER DT002;


--Kiểm tra các quyền được cấp cho các role
SELECT 
    dp.class_desc AS PermissionType, -- Loại quyền (OBJECT, SCHEMA, DATABASE, etc.)
    OBJECT_NAME(dp.major_id) AS ObjectName, -- Tên đối tượng (bảng, view, procedure)
    dp.permission_name AS Permission, -- Quyền cụ thể (SELECT, INSERT, EXECUTE, etc.)
    dp.state_desc AS State, -- Trạng thái (GRANT, DENY)
    pr.name AS RoleName -- Tên role hoặc user được gán quyền
FROM sys.database_permissions dp
JOIN sys.database_principals pr ON dp.grantee_principal_id = pr.principal_id
WHERE pr.name IN ('NhanVien', 'QuanLy', 'KhachHang', 'DoiTac')
ORDER BY RoleName, ObjectName, Permission;

--Kiểm tra phân quyền thực tế bằng cách mô phỏng
--*****QuanLy******

EXECUTE AS USER = 'QuanLy1';

-- Kiểm tra quyền SELECT trên HopDong
SELECT * FROM HopDong; 

-- Kiểm tra quyền INSERT vào ThanhToan
INSERT INTO ThanhToan (MaTT, MaHD, NgayTT, SoTien, PhuongThuc, TrangThai)
VALUES ('TT00023', 'HD002', '2023-11-01', 600000, N'Chuyển khoản', N'Đã thanh toán');
SELECT * FROM ThanhToan WHERE MaTT = 'TT006'; 

-- Kiểm tra quyền UPDATE trên NhanVien
UPDATE NhanVien SET SoDienThoai = '0912345678' WHERE MaNV = 'NV001';
SELECT * FROM NhanVien WHERE MaNV = 'NV001'; 

-- Kiểm tra quyền DELETE trên HopDong
DELETE FROM ThanhToan WHERE MaTT = 'TT004'; 
SELECT * FROM ThanhToan WHERE MaTT = 'TT004'; 

-- Kiểm tra quyền EXECUTE procedure
EXEC sp_ThemHopDong 'HD00023', 'KH002', 'LBH01', NULL, '2023-12-01', '2024-12-01', 1500000, N'Đang hiệu lực'; 

REVERT;


--*******NhanVien*******
EXECUTE AS USER = 'NhanVien1';

-- Kiểm tra quyền SELECT trên HopDong
SELECT * FROM HopDong; 

-- Kiểm tra quyền INSERT vào ThanhToan
INSERT INTO ThanhToan (MaTT, MaHD, NgayTT, SoTien, PhuongThuc, TrangThai)
VALUES ('TT026', 'HD001', '2023-10-01', 300000, N'Tiền mặt', N'Đã thanh toán');
SELECT * FROM ThanhToan WHERE MaTT = 'TT026'; 

-- Kiểm tra quyền UPDATE trên HopDong
UPDATE HopDong SET TrangThai = N'Đã cập nhật' WHERE MaHD = 'HD002';
SELECT * FROM HopDong WHERE MaHD = 'HD002'; 

-- Kiểm tra quyền DELETE (không được phép)
DELETE FROM HopDong WHERE MaHD = 'HD002'; 
--Lỗi "The DELETE permission was denied" do không được phép

-- Kiểm tra quyền EXECUTE procedure
EXEC sp_LayHopDongTheoKhachHang 'KH001'; 

-- Kiểm tra quyền truy cập bảng không được phép đầy đủ (ví dụ: NhanVien)
UPDATE NhanVien SET SoDienThoai = '0912345678' WHERE MaNV = 'NV001'; 
-- Kết quả: Lỗi "The UPDATE permission was denied"

REVERT;

--*******KhachHang******
EXECUTE AS USER = 'KH001';

-- Kiểm tra quyền SELECT trên view v_KhachHang_CaNhan
SELECT * FROM v_KhachHang_CaNhan; 

-- Kiểm tra quyền SELECT trên view v_HopDong_CaNhan
SELECT * FROM v_HopDong_CaNhan; 

-- Kiểm tra quyền SELECT trên view v_ThanhToan_CaNhan
SELECT * FROM v_ThanhToan_CaNhan; 

-- Kiểm tra quyền SELECT trực tiếp trên bảng HopDong (không được phép)
SELECT * FROM HopDong; 
-- Lỗi "The SELECT permission was denied"

-- Kiểm tra quyền INSERT (không được phép)
INSERT INTO HopDong (MaHD, MaKH, MaLoaiBH, NgayLap, NgayHetHan, GiaTriHD, TrangThai)
VALUES ('HD007', 'KH001', 'LBH001', '2024-01-01', '2025-01-01', 1000000, N'Đang hiệu lực'); 
--Lỗi "The INSERT permission was denied"

-- Kiểm tra quyền EXECUTE procedure
EXEC sp_LayThongTinKhachHang 'KH001'; 

EXEC sp_LayHopDongTheoKhachHang 'KH001'; 

REVERT;

--*******DoiTac******
EXECUTE AS USER = 'DT002';

-- Kiểm tra quyền SELECT trên view v_DoiTac_CaNhan
SELECT * FROM v_DoiTac_CaNhan; 

-- Kiểm tra quyền SELECT trên view v_HopDong_DoiTac
SELECT * FROM v_HopDong_DoiTac; 

-- Kiểm tra quyền SELECT trực tiếp trên bảng HopDong (không được phép)
SELECT * FROM HopDong; 
-- Lỗi "The SELECT permission was denied"

-- Kiểm tra quyền INSERT (không được phép)
INSERT INTO HopDong (MaHD, MaKH, MaLoaiBH, MaDoiTac, NgayLap, NgayHetHan, GiaTriHD, TrangThai)
VALUES ('HD008', 'KH002', 'LBH001', 'DT001', '2024-02-01', '2025-02-01', 1000000, N'Đang hiệu lực'); 
-- Lỗi "The INSERT permission was denied"

-- Kiểm tra quyền EXECUTE procedure
EXEC sp_LayHopDongTheoKhachHang 'KH001'; 
-- Thấy HD001 (dù không giới hạn MaDoiTac trong procedure)

REVERT;

SELECT USER_NAME(); -- Trả về tên user hiện tại
SELECT SUSER_NAME(); -- Trả về tên login hiện tại
