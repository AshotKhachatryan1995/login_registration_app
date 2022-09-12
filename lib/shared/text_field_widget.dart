import 'package:flutter/material.dart';
import 'package:login_registration_app/constants/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.textAlign = TextAlign.left,
      this.readOnly = false,
      this.prefixIcon,
      this.keyboardType,
      this.onChanged,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextAlign textAlign;
  final bool readOnly;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final StringCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: TextFormField(
          controller: controller,
          cursorColor: AppColors.keppelColor,
          textAlign: textAlign,
          keyboardType: keyboardType,
          readOnly: readOnly,
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              label: Align(
                  alignment: textAlign == TextAlign.center
                      ? Alignment.center
                      : Alignment.centerLeft,
                  child: Text(hintText)),
              disabledBorder: InputBorder.none,
              border: InputBorder.none,
              hintStyle: const TextStyle(
                color: AppColors.tuataraColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
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
