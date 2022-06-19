import 'package:flutter/material.dart';
import 'package:ude/resources/app_strings.dart';
import 'package:ude/ui/features/auth/auth_wm.dart';
import 'package:ude/ui/ui_kit/buttons/app_button.dart';
import 'package:ude/ui/ui_kit/text_fields/app_text_field.dart';

class Registrate extends StatelessWidget {
  const Registrate({
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
          controller: wm.nameController,
          label: AppStrings.name,
        ),
        AppTextField(
          controller: wm.emailController,
          label: AppStrings.email,
        ),
        AppTextField(
          controller: wm.passwordController,
          label: AppStrings.password,
        ),
        AppButton.primary(
          text: AppStrings.regButton,
          onPressed: wm.registrate,
        ),
        AppButton.ghost(
          onPressed: () => wm.changeState(AuthState.login),
          text: AppStrings.loginButton,
        ),
      ],
    );
  }
}
