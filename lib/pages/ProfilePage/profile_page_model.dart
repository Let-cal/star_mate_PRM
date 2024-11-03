import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './theme_provider.dart';

class ProfilePageModel extends ChangeNotifier {
  final BuildContext context;

  ProfilePageModel(this.context);

  bool get isDarkMode => context.read<ThemeProvider>().isDarkMode;

  void toggleDarkMode() {
    context.read<ThemeProvider>().toggleTheme();
  }
}
