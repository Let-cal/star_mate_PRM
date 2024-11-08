import 'package:flutter/material.dart';
class Zodiac {
  final int id;
  final String name;

  Zodiac(this.id, this.name);
}


class RegisterPageModel extends ChangeNotifier {
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;

  bool passwordVisibility = false;
  bool? checkboxListTileValue;
  bool _isLoading = false;
  String? selectedGender;
  Zodiac? selectedZodiac;

  // Add list of zodiacs
  final List<Zodiac> zodiacs = [
    Zodiac(1, 'Aries'),
    Zodiac(2, 'Taurus'),
    Zodiac(3, 'Gemini'),
    Zodiac(4, 'Cancer'),
    Zodiac(5, 'Leo'),
    Zodiac(6, 'Virgo'),
    Zodiac(7, 'Libra'),
    Zodiac(8, 'Scorpio'),
    Zodiac(9, 'Sagittarius'),
    Zodiac(10, 'Capricorn'),
    Zodiac(11, 'Aquarius'),
    Zodiac(12, 'Pisces'),
  ];

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setGender(String? value) {
    selectedGender = value;
    notifyListeners();
  }

  void setZodiac(Zodiac? value) {
    selectedZodiac = value;
    notifyListeners();
  }

  void initControllers() {
    textController1 = TextEditingController();
    textFieldFocusNode1 = FocusNode();
    textController2 = TextEditingController();
    textFieldFocusNode2 = FocusNode();
    textController3 = TextEditingController();
    textFieldFocusNode3 = FocusNode();
    textController4 = TextEditingController();
    textFieldFocusNode4 = FocusNode();
    checkboxListTileValue = true;
  }

  void togglePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  void setCheckboxValue(bool value) {
    checkboxListTileValue = value;
    notifyListeners();
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();
    textFieldFocusNode3?.dispose();
    textController3?.dispose();
    textFieldFocusNode4?.dispose();
    textController4?.dispose();
  }
}