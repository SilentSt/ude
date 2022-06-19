import 'package:flutter/material.dart';
import 'package:ude/ui/ui_kit/theme/kit_colors.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    Key? key,
    required this.child,
    this.height = 400,
    this.width = 500,
  }) : super(key: key);

  final Widget child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: KitColors.card,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}
