import 'package:flutter/cupertino.dart';
import 'package:ude/resources/app_strings.dart';
import 'package:ude/ui/features/auth/auth_wm.dart';
import 'package:ude/ui/ui_kit/buttons/app_button.dart';

class Auth extends StatelessWidget {
  const Auth({
    Key? key,
    required this.wm,
  }) : super(key: key);

  final IAuthScreenWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppButton.primary(
          text: AppStrings.loginButton,
          onPressed: () => wm.changeState(AuthState.login),
        ),
        AppButton.primary(
          onPressed: () => {wm.changeState(AuthState.registrate)},
          text: AppStrings.regButton,
        ),
      ],
    );
  }
}
