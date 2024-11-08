import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_profile_form.dart';
import 'edit_profile_model.dart';
import '../../services/api_service.dart';
import '../../../loading_screen.dart'; // Import LoadingScreen

class EditProfilePageWidget extends StatefulWidget {
  const EditProfilePageWidget({super.key});

  @override
  _EditProfilePageWidgetState createState() => _EditProfilePageWidgetState();
}

class _EditProfilePageWidgetState extends State<EditProfilePageWidget> {
  late EditProfileModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = EditProfileModel(context.read<ApiService>());
    _model.fetchProfileData();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return ChangeNotifierProvider<EditProfileModel>.value(
      value: _model,
      child: Consumer<EditProfileModel>(
        builder: (context, model, child) {
          return Stack(
            children: [
              GestureDetector(
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
                    title: Text(
                      '',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                    ),
                  ),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: EditProfileForm(
                        model: model,
                        isKeyboardVisible: isKeyboardVisible,
                      ),
                    ),
                  ),
                ),
              ),
              // Đặt LoadingScreen ở đây, ngoài Scaffold
              LoadingScreen(isLoading: model.isLoading),
            ],
          );
        },
      ),
    );
  }
}
