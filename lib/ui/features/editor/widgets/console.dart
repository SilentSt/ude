import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ude/resources/app_colors.dart';
import 'package:ude/ui/features/editor/editor_wm.dart';

class Console extends StatelessWidget {
  const Console({
    Key? key,
    required this.wm,
  }) : super(key: key);

  final IEditorScreenWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder<String>(
      listenableEntityState: wm.console,
      builder: (context, console) => SizedBox(
        height: MediaQuery.of(context).size.height * .2,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          controller: wm.consoleScroll,
          child: ColoredBox(
            color: AppColors.background,
            child: Text(
              console ?? '',
              style: const TextStyle(color: AppColors.text),
            ),
          ),
        ),
      ),
    );
  }
}
