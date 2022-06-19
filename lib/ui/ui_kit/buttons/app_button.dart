import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ude/resources/app_colors.dart';
import 'highlighted_widget.dart';

enum IconPosition {
  left,
  right,
}

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.icon,
    this.fontColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.borderRadius = 0,
    this.width = 200,
    this.height = 50,
    this.iconPosition = IconPosition.right,
    this.padding = const EdgeInsets.all(15),
    this.borderColor = Colors.transparent,
    this.onLongPressed,
    this.hoveredColor = Colors.black54,
    this.pressedColor = Colors.black38,
  }) : super(key: key);

  final VoidCallback onPressed;
  final VoidCallback? onLongPressed;
  final String? text;
  final String? icon;
  final IconPosition iconPosition;
  final EdgeInsets padding;
  final Color fontColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color hoveredColor;
  final Color pressedColor;
  final double borderRadius;
  final double width;
  final double height;

  Widget get child {
    if (icon == null && text != null) {
      return Text(
        text!,
        textAlign: TextAlign.center,
        style: TextStyle(color: fontColor),
      );
    }
    if (icon != null && text == null) {
      return FittedBox(
        fit: BoxFit.cover,
        child: Image.asset(icon!),
      );
    }
    if (icon == null && text == null) {
      return const Text('TODO: add text or icon =)');
    } else {
      if (iconPosition == IconPosition.right) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(color: fontColor),
            ),
            FittedBox(
              fit: BoxFit.cover,
              child: Image.asset(icon!),
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              fit: BoxFit.cover,
              child: Image.asset(icon!),
            ),
            Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(color: fontColor),
            ),
          ],
        );
      }
    }
  }

  VoidCallback get onLongPress => onLongPressed ?? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: HighlightedWidget(
        builder: ((context, isHovered, _) => GestureDetector(
              onLongPress: onLongPress,
              child: CupertinoButton(
                onPressed: onPressed,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: ColoredBox(
                      color: isHovered ? hoveredColor : backgroundColor,
                      child: Padding(
                        padding: padding,
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  factory AppButton.primary({
    required VoidCallback onPressed,
    required String text,
  }) =>
      AppButton(
        onPressed: onPressed,
        text: text,
        backgroundColor: AppColors.primaryButton,
        fontColor: AppColors.text,
        borderRadius: 15,
      );

  factory AppButton.outlined({
    required VoidCallback onPressed,
    Color borderColor = Colors.black,
  }) =>
      AppButton(
        onPressed: onPressed,
        backgroundColor: Colors.transparent,
        borderColor: borderColor,
      );

  factory AppButton.ghost({
    required VoidCallback onPressed,
    required String text,
  }) =>
      AppButton(
        onPressed: onPressed,
        text: text,
        backgroundColor: Colors.transparent,
        hoveredColor: Colors.transparent,
        fontColor: AppColors.text,        
      );
}
