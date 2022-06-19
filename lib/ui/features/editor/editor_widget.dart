import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ude/data/models/code.dart';
import 'package:ude/resources/app_colors.dart';
import 'package:ude/ui/features/editor/widgets/code_card.dart';
import 'package:ude/ui/features/editor/widgets/console.dart';
import 'package:ude/ui/features/editor/widgets/file_system.dart';
import 'package:ude/ui/features/editor/widgets/sense_widget.dart';

import 'editor_wm.dart';

class EditorScreenWidget extends ElementaryWidget<IEditorScreenWidgetModel> {
  const EditorScreenWidget({
    Key? key,
    WidgetModelFactory<
            WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel>>
        wmFactory = defaultEditorScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(wm) {
    return Scaffold(
      appBar: AppBar(
        title: EntityStateNotifierBuilder<File>(
          listenableEntityState: wm.currentFile,
          builder: (context, file) => Text(
            file == null ? 'file name' : file.name,
          ),
        ),
        backgroundColor: AppColors.cardColor,
        actions: [
          EntityStateNotifierBuilder<bool>(
            listenableEntityState: wm.fileChanged,
            builder: (context, changed) => IconButton(
              onPressed: wm.editFile,
              icon: changed!
                  ? const Icon(
                      CupertinoIcons.arrow_up_doc_fill,
                      color: AppColors.primaryButton,
                    )
                  : const Icon(
                      CupertinoIcons.arrow_up_doc,
                      color: AppColors.primaryButton,
                    ),
            ),
          ),
          IconButton(
            onPressed: wm.compile,
            icon: const Icon(
              CupertinoIcons.play_arrow_solid,
              color: AppColors.primaryButton,
            ),
          ),
        ],
      ),
      drawer: FileSystem(wm: wm),
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(wm.getContext).size.width * .7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CodeCard(wm: wm),
                SizedBox(
                  width: MediaQuery.of(wm.getContext).size.width * .7,
                  height: 1,
                  child: const ColoredBox(
                    color: AppColors.primaryButton,
                  ),
                ),
                Console(wm: wm),
              ],
            ),
          ),
          const VerticalDivider(
            color: AppColors.primaryButton,
            width: 1,
          ),
          SenseWidget(wm: wm),
        ],
      ),
    );
  }
}
