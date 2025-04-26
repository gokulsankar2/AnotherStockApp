import 'package:flutter/material.dart';
import 'package:whos_the_imposter/core/configs/theme/app_colors.dart';

class BasicButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? height;

  const BasicButton({
    required this.text,
    required this.onPressed,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: Size.fromHeight(height ?? 80),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
