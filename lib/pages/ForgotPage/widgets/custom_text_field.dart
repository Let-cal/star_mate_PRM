// widgets/custom_text_field.dart
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String labelText;
  final bool isPassword;
  final bool? passwordVisibility;
  final VoidCallback? onTogglePassword;
  final TextCapitalization textCapitalization;

  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    required this.labelText,
    this.isPassword = false,
    this.passwordVisibility,
    this.onTogglePassword,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isPassword ? !(passwordVisibility ?? false) : false,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.labelLarge,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          contentPadding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: onTogglePassword,
                  icon: Icon(
                    passwordVisibility ?? false
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                )
              : null,
        ),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 3,
            ),
      ),
    );
  }
}
