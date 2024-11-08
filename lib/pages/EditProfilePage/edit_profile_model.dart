import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class EditProfileModel extends ChangeNotifier {
  final ApiService apiService;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? email; // Giữ nguyên kiểu String? để có thể nhận giá trị null
  int zodiacId = 1; // Mặc định là 1 (Aries)
  bool _isLoading = false; // Thêm thuộc tính isLoading

  EditProfileModel(this.apiService);

  bool get isLoading => _isLoading; // Getter cho isLoading

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners(); // Thông báo cho UI cập nhật
  }

  Future<void> fetchProfileData() async {
    try {
      final user = await apiService.getUserInfo();
      if (user != null) {
        fullNameController.text = user.fullName;
        telephoneController.text = user.telephoneNumber ?? '';
        descriptionController.text = user.description ?? '';
        email = user.email; // Lưu email từ user info
        zodiacId = user.zodiacId ?? 1;
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching profile data: $e');
      rethrow;
    }
  }

  Future<void> updateProfile() async {
    try {
      print('1. Bắt đầu cập nhật profile');
      setLoading(true);

      if (fullNameController.text.isEmpty) {
        throw Exception('Please enter your full name');
      }

      if (telephoneController.text.isEmpty) {
        throw Exception('Please enter your phone number');
      } else if (!RegExp(r'^\d+$').hasMatch(telephoneController.text)) {
        throw Exception('Phone number must contain only numbers');
      }

      if (email == null || email!.isEmpty) {
        throw Exception('Không tìm thấy thông tin email người dùng');
      }

      print('2. Dữ liệu chuẩn bị gửi:');
      print('- Email: $email'); // Log để debug
      print('- Họ tên: ${fullNameController.text}');
      print('- Số điện thoại: ${telephoneController.text}');
      print('- Zodiac ID: $zodiacId');
      print('- Mô tả: ${descriptionController.text}');

      // Gọi API update
      await apiService.updateUser(
        fullName: fullNameController.text.trim(),
        telephoneNumber: telephoneController.text.trim(),
        zodiacId: zodiacId,
        description: descriptionController.text.trim(),
        email: email!, // Gửi email đã lưu
      );

      print('3. Cập nhật thành công');
    } catch (e) {
      print('3. Error: $e');
      throw Exception('$e');
    } finally {
      setLoading(false);
    }
  }
}
