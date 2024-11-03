import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './user_model.dart';
import '../../services/api_service.dart';
import './theme_provider.dart';

class ProfilePageModel extends ChangeNotifier {
  final BuildContext context;
  User? currentUser;
  bool isLoading = false;

  ProfilePageModel(this.context) {
    loadUserInfo();
  }

  bool get isDarkMode => context.read<ThemeProvider>().isDarkMode;

  void toggleDarkMode() {
    context.read<ThemeProvider>().toggleTheme();
  }

  Future<void> loadUserInfo() async {
    isLoading = true;
    notifyListeners();

    final apiService = ApiService();
    final user = await apiService.getUserInfo();
    
    currentUser = user;
    isLoading = false;
    notifyListeners();
  }
}
