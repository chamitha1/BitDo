import 'package:flutter/material.dart';

class AppTextStyles {
  static const String _fontFamily = 'Inter';

  // Paragraph / P1
  static const TextStyle p1SemiBold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color(0xFF151E2F),
  );

  // Paragraph / P2
  static const TextStyle p2SemiBold = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF151E2F),
  );

  static const TextStyle p2Medium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF151E2F),
  );

  // Paragraph / P3
  static const TextStyle p3Regular = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF6A7282),
  );

  static const TextStyle p3Medium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Color(0xFF6A7282),
  );
}
