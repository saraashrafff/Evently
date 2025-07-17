import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  String text;
  VoidCallback onTap;

  DefaultElevatedButton({super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(onPressed: onTap, child: Text(text)),
    );
  }
}
