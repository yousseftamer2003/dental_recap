import 'package:dental_recap/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.mainBlue),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }