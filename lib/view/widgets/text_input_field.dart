import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final FormFieldValidator<String>? validator;
  final TextCapitalization textCapitalization;

  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.inputType,
    this.inputAction,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: inputType,
      textInputAction: inputAction,
      validator: validator,
      textCapitalization: textCapitalization,
    );
  }
}
