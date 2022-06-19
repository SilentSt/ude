import 'package:code_text_field/code_text_field.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ude/data/models/code.dart';
import 'package:ude/resources/app_colors.dart';
import 'package:ude/ui/features/editor/editor_wm.dart';

class CodeCard extends StatelessWidget {
  const CodeCard({
    Key? key,
    required this.wm,
  }) : super(key: key);

  final IEditorScreenWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width * .7,
      child: SingleChildScrollView(
        child: EntityStateNotifierBuilder<File>(
            listenableEntityState: wm.currentFile,
            builder: (context, file) {
              return CodeField(
                controller: wm.codeController.value!.data!,
                background: AppColors.background,
              );
            }),
      ),
    );
  }
}
