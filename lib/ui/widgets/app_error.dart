import 'package:flutter/cupertino.dart';
import 'package:ude/data/local_storage/user_storage.dart';

class AppError extends StatelessWidget {
  const AppError({
    Key? key,
    this.error,
  }) : super(key: key);

  final String? error;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text(error ?? UserStorage.errors.last.errors),
      actions: [
        CupertinoDialogAction(
          onPressed: Navigator.of(context).pop,
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
