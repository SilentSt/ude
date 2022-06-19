import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ude/data/models/code.dart';
import 'package:ude/resources/app_colors.dart';
import 'package:ude/ui/features/editor/editor_wm.dart';
import 'package:ude/ui/ui_kit/list/tree.dart';

class FileSystem extends StatelessWidget {
  const FileSystem({
    Key? key,
    required this.wm,
  }) : super(key: key);

  final IEditorScreenWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return Drawer(      
      backgroundColor: AppColors.cardColor,
      child: EntityStateNotifierBuilder<List<File>>(
        listenableEntityState: wm.files,      
        builder: (context, files) => Tree.text(
          parent: 'root',
          children: files == null ? [] : files.map((e) => e.name).toList(),
        ),
      ),
    );
  }
}
