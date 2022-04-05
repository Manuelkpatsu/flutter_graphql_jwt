import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String action;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.action,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(action),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        elevation: 0,
      ),
    );
  }
}
