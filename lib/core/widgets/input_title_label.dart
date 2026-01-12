import 'package:flutter/material.dart';

class InputTitleLable extends StatelessWidget {
  final String text;
  const InputTitleLable(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xFF2E3D5B),
        ),
      ),
    );
  }
}
