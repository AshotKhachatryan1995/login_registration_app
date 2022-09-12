import 'package:flutter/material.dart';
import 'package:login_registration_app/constants/app_colors.dart';

class CustomDivider extends Divider {
  const CustomDivider({super.key});

  @override
  Color get color => AppColors.tuataraColor.withOpacity(0.25);

  @override
  double get height => 0.5;
}
