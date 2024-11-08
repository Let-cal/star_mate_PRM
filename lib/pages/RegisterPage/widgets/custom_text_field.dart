import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String labelText;
  final bool isPassword;
  final bool? passwordVisibility;
  final VoidCallback? onTogglePassword;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    required this.labelText,
    this.isPassword = false,
    this.passwordVisibility,
    this.onTogglePassword,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onChanged,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _showError = false;

  @override
  void initState() {
    super.initState();

    // Detect focus changes
    widget.focusNode?.addListener(() {
      if (!widget.focusNode!.hasFocus) {
        // Trigger validation on focus loss
        setState(() {
          _showError = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: widget.isPassword && !(widget.passwordVisibility ?? false),
        textCapitalization: widget.textCapitalization,
        onChanged: (value) {
          if (_showError) {
            setState(() {}); // Rebuild to show the error message
          }
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        validator: _showError
            ? widget.validator
            : null, // Show error only if _showError is true
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(0, 16, 12, 8),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: widget.onTogglePassword,
                  icon: Icon(
                    widget.passwordVisibility ?? false
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : null,
        ),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
