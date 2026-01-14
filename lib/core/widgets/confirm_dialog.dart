import 'package:flutter/material.dart';

void showCommonConfirmDialog(
  BuildContext context, {
  required String title,
  String? message,
  String primaryText = "Confirm",
  String secondaryText = "Cancel",
  required VoidCallback onPrimary,
  VoidCallback? onSecondary,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => CommonConfirmDialog(
      title: title,
      message: message,
      primaryText: primaryText,
      secondaryText: secondaryText,
      onPrimary: onPrimary,
      onSecondary: onSecondary,
    ),
  );
}

class CommonConfirmDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String primaryText;
  final String secondaryText;
  final VoidCallback onPrimary;
  final VoidCallback? onSecondary;

  const CommonConfirmDialog({
    super.key,
    required this.title,
    this.message,
    this.primaryText = "Confirm",
    this.secondaryText = "Cancel",
    required this.onPrimary,
    this.onSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      content: message != null ? Text(message!) : null,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onSecondary?.call();
          },
          child: Text(secondaryText),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onPrimary();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2F6CFF),
          ),
          child: Text(primaryText),
        ),
      ],
    );
  }
}
