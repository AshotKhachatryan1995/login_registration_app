import 'package:flutter/material.dart';
import 'package:login_registration_app/constants/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {required this.controller,
      required this.hintText,
      this.onChanged,
      this.obscureText = false,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final StringCallback? onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: TextFormField(
          controller: controller,
          cursorColor: AppColors.keppelColor,
          decoration: InputDecoration(
              labelText: hintText,
              disabledBorder: InputBorder.none,
              border: InputBorder.none,
              hintStyle: const TextStyle(
                  color: AppColors.tuataraColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              fillColor: AppColors.pampasColor,
              filled: true,
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.curiousBlueColor, width: 1),
              ),
              hintText: hintText),
          onChanged: onChanged,
          obscureText: obscureText,
        ));
  }
}

typedef StringCallback = void Function(String);
