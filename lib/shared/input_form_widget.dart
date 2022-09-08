import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'horizontal_padded_widget.dart';

class InputFormWidget extends StatelessWidget {
  const InputFormWidget(
      {required this.formTitle, required this.child, super.key});

  final String formTitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_renderTitle(), _renderForm()],
    );
  }

  Widget _renderTitle() {
    return Text(
      formTitle,
      style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.tuataraColor),
    );
  }

  Widget _renderForm() {
    return Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 12,
                  color: Colors.black.withOpacity(0.05))
            ]),
        child: HorizontalPaddedWidget(child: child));
  }
}
