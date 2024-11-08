import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatefulWidget {
  final String labelText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const CustomDropdownField({
    super.key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  _CustomDropdownFieldState<T> createState() => _CustomDropdownFieldState<T>();
}

class _CustomDropdownFieldState<T> extends State<CustomDropdownField<T>> {
  bool _showError = false; // Flag to show error when focus is lost

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Focus(
        onFocusChange: (hasFocus) {
          // If focus is lost and no value selected, trigger validation error
          if (!hasFocus && widget.value == null) {
            setState(() {
              _showError = true;
            });
          }
        },
        child: DropdownButtonFormField<T>(
          value: widget.value,
          items: widget.items,
          onChanged: (value) {
            widget.onChanged(value); // Pass value to the parent onChanged
            setState(() {
              _showError = false; // Hide error when a value is selected
            });
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
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          dropdownColor: Theme.of(context).colorScheme.surface,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
