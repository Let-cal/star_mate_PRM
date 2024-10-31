import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/api_service.dart'; // Import ApiService
import 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;
  final _apiService = ApiService(); // Initialize ApiService
  @override
  void initState() {
    super.initState();
    _model = LoginPageModel();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _model,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  _buildLoginForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Container(
        width: 200,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(
          'StarMate',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontFamily: 'ABeeZee',
                letterSpacing: 0.0,
              ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 570),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontFamily: 'ABeeZee',
                      letterSpacing: 0.0,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Fill out the information below to access your account.',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontFamily: 'Abel',
                      letterSpacing: 0.0,
                    ),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _model.emailAddressTextController,
                focusNode: _model.emailAddressFocusNode,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: _model.emailAddressTextControllerValidator,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _model.passwordTextController,
                focusNode: _model.passwordFocusNode,
                labelText: 'Password',
                obscureText: !_model.passwordVisibility,
                validator: _model.passwordTextControllerValidator,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      _model.passwordVisibility = !_model.passwordVisibility;
                    });
                  },
                  child: Icon(
                    _model.passwordVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildSignInButton(context),
              const SizedBox(height: 24),
              // _buildDivider(),
              const SizedBox(height: 24),
              _buildForgotPassText(context),
              const SizedBox(height: 12),
              _buildSignUpText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String labelText,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline, width: 2),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 2),
          borderRadius: BorderRadius.circular(40),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
          borderRadius: BorderRadius.circular(40),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.fromLTRB(24, 24, 0, 24),
        suffixIcon: suffixIcon,
      ),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontFamily: 'ABeeZee',
            letterSpacing: 0.0,
          ),
      validator: validator,
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () async {
          if (_model.emailAddressTextController.text.isNotEmpty &&
              _model.passwordTextController.text.isNotEmpty) {
            // Call the login API
            final response = await _apiService.login(
              email: _model.emailAddressTextController.text,
              password: _model.passwordTextController.text,
            );

            if (response != null && response['success'] == true) {
              // Handle successful login (e.g., navigate to home screen)
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              // Display the message from response if available
              final errorMessage = response?['message'] ?? 'Login failed';
              print('Error: $errorMessage'); // Debug log to check the message

              // Show error message in SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(errorMessage)),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please fill out all fields')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          minimumSize: const Size(230, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Text(
          'Sign In',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontFamily: 'ABeeZee',
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  // Widget _buildDivider() {
  //   return Row(
  //     children: [
  //       Expanded(child: Divider()),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16),
  //         child: Text(
  //           'Or sign in with',
  //           style: Theme.of(context).textTheme.labelLarge?.copyWith(
  //                 color:
  //                     Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //         ),
  //       ),
  //       Expanded(child: Divider()),
  //     ],
  //   );
  // }

  // Widget _buildGoogleSignInButton(BuildContext context) {
  //   return ElevatedButton.icon(
  //     onPressed: () {
  //       // TODO: Implement Google sign in
  //     },
  //     icon: const FaIcon(FontAwesomeIcons.google, size: 20),
  //     label: const Text('Continue with Google'),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: Theme.of(context).colorScheme.surface,
  //       foregroundColor: Theme.of(context).colorScheme.onSurface,
  //       minimumSize: const Size(230, 44),
  //       side:
  //           BorderSide(color: Theme.of(context).colorScheme.outline, width: 2),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(40),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildForgotPassText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Forgot your password? ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: Navigate to forgot password page
              Navigator.pushNamed(context, '/forgot_pass');
            },
            child: Text(
              'Reset here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account? ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/register');
            },
            child: Text(
              'Sign Up here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
