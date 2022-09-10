import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'detail_app_bar_widget.dart';

class UnfocusScaffold extends StatelessWidget {
  const UnfocusScaffold({required this.body, super.key});

  final Widget body;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.pampasColor,
          appBar: const PreferredSize(
              preferredSize: Size(0, 120), child: DetailAppBarWidget()),
          body: body,
        ));
  }
}
