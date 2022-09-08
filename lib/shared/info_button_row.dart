import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'horizontal_padded_widget.dart';

class InfoButtonRow extends StatelessWidget {
  const InfoButtonRow(
      {required this.message,
      required this.buttonTitle,
      this.decoration,
      this.onTapButton,
      super.key});

  final String message;
  final String buttonTitle;
  final BoxDecoration? decoration;
  final VoidCallback? onTapButton;

  @override
  Widget build(BuildContext context) {
    return HorizontalPaddedWidget(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        message,
        style: const TextStyle(
            color: AppColors.tuataraColor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
      ),
      InkWell(
          onTap: onTapButton,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: decoration ??
                BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4)),
            child: Text(
              buttonTitle.toUpperCase(),
              style: const TextStyle(
                  color: AppColors.curiousBlueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ))
    ]));
  }
}
