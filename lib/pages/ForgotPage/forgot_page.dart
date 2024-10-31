// forgot_page.dart
import 'package:flutter/material.dart';
import 'widgets/forgot_form.dart';
import 'forgot_page_model.dart';

class ForgotPageWidget extends StatefulWidget {
  const ForgotPageWidget({super.key});

  @override
  State<ForgotPageWidget> createState() => _ForgotPageWidgetState();
}

class _ForgotPageWidgetState extends State<ForgotPageWidget> {
  late ForgotPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = ForgotPageModel();
    _model.initControllers();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: ForgotForm(
            model: _model,
            isKeyboardVisible: isKeyboardVisible,
          ),
        ),
      ),
    );
  }
}
