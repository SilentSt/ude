import 'package:flutter/material.dart';
import 'package:ude/resources/app_strings.dart';
import 'package:ude/ui/features/auth/auth_wm.dart';
import 'package:ude/ui/ui_kit/buttons/app_button.dart';
import 'package:ude/ui/ui_kit/text_fields/app_text_field.dart';

class Login extends StatelessWidget {
  const Login({
    Key? key,
    required this.wm,
  }) : super(key: key);

  final IAuthScreenWidgetModel wm;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppTextField(
          controller: wm.emailController,
          label: AppStrings.email,
        ),
        AppTextField(
          controller: wm.passwordController,
          label: AppStrings.password,
        ),
        AppButton.primary(
          text: AppStrings.loginButton,
          onPressed: wm.authorize,
        ),
        AppButton.ghost(
          onPressed: () => wm.changeState(AuthState.registrate),
          text: AppStrings.regButton,
        ),
      ],
    );
  }
}
