import 'package:flutter/material.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final FormFieldValidator<String>? validator;
  final TextCapitalization textCapitalization;
  final bool? obscureText;
  final VoidCallback? toggle;

  const PasswordInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.inputType,
    this.inputAction,
    this.validator,
    this.obscureText,
    this.toggle,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: IconButton(
          icon: obscureText!
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: toggle,
        ),
      ),
      keyboardType: inputType,
      textInputAction: inputAction,
      obscureText: obscureText!,
      validator: validator,
      textCapitalization: textCapitalization,
    );
  }
}
