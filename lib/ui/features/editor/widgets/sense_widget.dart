import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ude/data/local_storage/user_storage.dart';
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
        builder: (context, sense) => SingleChildScrollView(
          controller: wm.senseScroll,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sense == null
                ? []
                : sense
                    .map(
                      (e) => GestureDetector(
                        onLongPress: () => wm.showRemoveSenseDialog(
                            UserStorage.sense.sense.indexOf(e)),
                        onTap: () => wm.implementSense(e),
                        child: SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width * .2,
                          child: Text(
                            e,
                            style: const TextStyle(
                              color: AppColors.text,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}
