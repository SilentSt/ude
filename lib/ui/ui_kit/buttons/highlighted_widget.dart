import 'package:flutter/material.dart';

typedef HighlightedBuilder = Widget Function(
  BuildContext context,
  bool isHovered,
  bool isPressed,
);

class HighlightedWidget extends StatefulWidget {
  const HighlightedWidget({
    Key? key,
    required this.builder,
    this.onHoverCursor = SystemMouseCursors.click,
  }) : super(key: key);

  final HighlightedBuilder builder;
  final MouseCursor onHoverCursor;

  @override
  State<HighlightedWidget> createState() => _HighlightedWidgetState();
}

class _HighlightedWidgetState extends State<HighlightedWidget> {
  bool isHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      cursor: widget.onHoverCursor,
      child: widget.builder(
        context,
        isHovered,
        isPressed,
      ),
    );
  }
}
