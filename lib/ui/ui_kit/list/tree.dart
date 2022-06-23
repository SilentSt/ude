// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ude/resources/app_colors.dart';

class Tree extends StatefulWidget {
  const Tree({
    Key? key,
    this.parentWidget,
    this.parentText,
    this.childrenWidget,
    this.childrenTexts,
  }) : super(key: key);

  final Widget? parentWidget;
  final String? parentText;
  final List<Widget>? childrenWidget;
  final List<String>? childrenTexts;

  @override
  _TreeState createState() => _TreeState();

  factory Tree.text({
    required String parent,
    required final List<String> children,
  }) =>
      Tree(
        parentText: parent,
        childrenTexts: children,
      );

  factory Tree.widget({
    required Widget parent,
    required List<Widget> children,
  }) =>
      Tree(
        parentWidget: parent,
        childrenWidget: children,
      );
}

class _TreeState extends State<Tree> {
  bool isOpened = false;

  Widget get parent =>
      widget.parentWidget ??
      Row(
        children: [
          Text(
            widget.parentText!,
            style: const TextStyle(
              color: AppColors.text,
            ),
          ),
          const SizedBox(width: 5),
          Icon(isOpened
              ? Icons.keyboard_arrow_right_outlined
              : Icons.keyboard_arrow_down_outlined)
        ],
      );

  List<Widget> get children =>
      widget.childrenWidget ??
      widget.childrenTexts!
          .map(
            (e) => Text(
              e,
              style: const TextStyle(
                color: AppColors.text,
              ),
            ),
          )
          .toList();

  @override
  Widget build(BuildContext context) {
    if (!isOpened) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isOpened = true;
              });
            },
            child: parent,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isOpened = false;
              });
            },
            child: parent,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              children: children,
            ),
          )
        ],
      );
    }
  }
}
