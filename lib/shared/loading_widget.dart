import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget(
      {required this.isLoading, required this.child, this.color, Key? key})
      : super(key: key);

  final bool isLoading;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Stack(children: [
            child,
            IgnorePointer(
                child: Container(
                    padding: const EdgeInsets.only(top: 100),
                    color: color ?? Colors.white.withOpacity(0.4),
                    child: const Center(
                        child: CupertinoActivityIndicator(
                            radius: 20, color: Colors.black))))
          ])
        : child;
  }
}
