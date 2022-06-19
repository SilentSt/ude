import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ude/resources/app_colors.dart';
import 'package:ude/ui/features/editor/editor_wm.dart';

class SenseWidget extends StatelessWidget {
  const SenseWidget({
    Key? key,
    required this.wm,
  }) : super(key: key);

  final IEditorScreenWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * .2,
      child: EntityStateNotifierBuilder<List<String>>(
        listenableEntityState: wm.sense,
        builder: (context, sense) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: sense == null
              ? []
              : sense
                  .map(
                    (e) => GestureDetector(
                      onTap: () => wm.implementSense(e),
                      child: Text(
                        e,
                        style: const TextStyle(color: AppColors.text),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
