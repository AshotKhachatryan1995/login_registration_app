import 'package:flutter/material.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
          onChanged: onChanged,
          obscureText: obscureText,
        ));
  }
}

typedef StringCallback = void Function(String);
