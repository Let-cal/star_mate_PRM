# Hướng Dẫn Cài Đặt và Chạy Dự Án Flutter - PRM392

## Thông Tin Dự Án
- **Sinh viên:** Letcal
- **Trường:** FPT University
- **Chuyên Ngành:** BrSe
- **Môn Học:** PRM392

## Điều Kiện Tiên Quyết
Trước khi bắt đầu, hãy đảm bảo máy bạn đã cài đặt các công cụ sau:

### 1. Flutter SDK
- Tải và cài đặt từ: https://docs.flutter.dev/get-started/install
- Phiên bản khuyến nghị: Phiên bản ổn định mới nhất
- Kiểm tra cài đặt: Chạy `flutter doctor` trong terminal

### 2. Android Studio hoặc Visual Studio Code
#### Cài đặt Visual Studio Code:
1. Tải VSCode tại: https://code.visualstudio.com/
2. Cài đặt Extensions:
   - "Flutter" by Dart Code
   - "Dart" by Dart Code

### 3. Android SDK
- Cài đặt qua Android Studio hoặc SDK Tools
- Cấu hình biến môi trường ANDROID_HOME

## Các Bước Cài Đặt Dự Án

### Bước 1: Clone Dự Án
```bash
git clone [https://github.com/Let-cal/star_mate_PRM.git]
cd [TÊN_THƯ_MỤC_DỰ_ÁN]
```

### Bước 2: Cài Đặt Dependencies
```bash
flutter pub get
```

### Bước 3: Chạy Ứng Dụng
#### Trên Máy Ảo
```bash
flutter devices  # Kiểm tra danh sách thiết bị
flutter run      # Chạy trên thiết bị mặc định
```

#### Trên Thiết Bị Vật Lý
1. Bật chế độ Developer Options trên điện thoại
2. Bật USB Debugging
3. Kết nối điện thoại với máy tính
4. Chạy lệnh `flutter run`

## Cấu Trúc Thư Mục Dự Án
```
.
├── lib/                # Mã nguồn chính
│   ├── main.dart       # File khởi động ứng dụng
│   ├── models/         # Các lớp mô hình dữ liệu
│   ├── screens/        # Giao diện màn hình
│   ├── services/       # Các dịch vụ và API
│   └── widgets/        # Các widget tái sử dụng
├── pubspec.yaml        # File cấu hình dependencies
└── README.md           # Tài liệu hướng dẫn
```

## Lưu Ý
- Luôn chạy `flutter pub get` sau khi thêm dependencies mới
- Sử dụng `flutter format lib/` để định dạng mã
- Kiểm tra lỗi bằng `flutter analyze`

## Khắc Phục Sự Cố
- **Lỗi Dependencies:** Chạy `flutter pub get`
- **Lỗi Build:** Xóa thư mục `build/` và chạy lại
- **Máy Ảo Không Hoạt Động:** Kiểm tra cài đặt Android Studio

## Liên Hệ Hỗ Trợ
- Email: [letrancatlam123@gmail.com]
- Giảng Viên Hướng Dẫn: [PhuongLHK]

## Giấy Phép
[Chọn Giấy Phép Phù Hợp - Ví Dụ: MIT License]
```

## Ghi Chú Quan Trọng
- Thay thế `[https://github.com/Let-cal/star_mate_PRM.git]` bằng đường link GitHub/GitLab của dự án
- Điều chỉnh thông tin cá nhân và chi tiết dự án cho phù hợp
- Kiểm tra và cập nhật README khi có thay đổi trong dự án
