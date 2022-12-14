import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'detail_app_bar_widget.dart';

class UnfocusScaffold extends StatelessWidget {
  const UnfocusScaffold({required this.body, this.appBar, super.key});

  final Widget? appBar;

  final Widget body;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.pampasColor,
          appBar: PreferredSize(
              preferredSize: const Size(0, 120),
              child: appBar ?? const DetailAppBarWidget()),
          body: body,
        ));
  }
}
