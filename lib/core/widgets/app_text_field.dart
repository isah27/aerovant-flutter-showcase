import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radii.dart';
import '../theme/app_sizes.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    super.key,
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final IconData? prefixIcon;

  static const OutlineInputBorder _border = OutlineInputBorder(
    borderRadius: AppRadii.field,
    borderSide: BorderSide(color: AppColors.hairline),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.fieldHeight,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: AppTypography.title,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTypography.body,
          filled: true,
          fillColor: AppColors.glass,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          prefixIcon: prefixIcon == null
              ? null
              : Icon(prefixIcon, color: AppColors.steel),
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border.copyWith(
            borderSide: const BorderSide(color: AppColors.ionBlue),
          ),
        ),
      ),
    );
  }
}
