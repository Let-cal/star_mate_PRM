import 'package:flutter/foundation.dart';

class FilterProvider extends ChangeNotifier {
  List<int>? _selectedZodiacIds;
  String? _selectedGender;

  List<int>? get selectedZodiacIds => _selectedZodiacIds;
  String? get selectedGender => _selectedGender;

  void updateFilters(List<int> zodiacIds, String gender) {
    _selectedZodiacIds = zodiacIds;
    _selectedGender = gender;
    notifyListeners();
  }

  void clearFilters() {
    _selectedZodiacIds = null;
    _selectedGender = null;
    notifyListeners();
  }

  bool get hasFilters => _selectedZodiacIds != null && _selectedGender != null;
}
