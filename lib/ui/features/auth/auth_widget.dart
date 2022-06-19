import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ude/resources/app_colors.dart';
import 'package:ude/ui/features/auth/widgets/auth.dart';
import 'package:ude/ui/features/auth/widgets/login.dart';
import 'package:ude/ui/features/auth/widgets/registrate.dart';
import 'package:ude/ui/ui_kit/cards/base_card.dart';

import 'auth_wm.dart';

class AuthScreenWidget extends ElementaryWidget<IAuthScreenWidgetModel> {
  const AuthScreenWidget({
    Key? key,
    WidgetModelFactory<
            WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel>>
        wmFactory = defaultProfileScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IAuthScreenWidgetModel wm) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: BaseCard(
            child: EntityStateNotifierBuilder<AuthState>(
              listenableEntityState: wm.state,
              builder: ((context, state) {
                switch (state) {
                  case AuthState.auth:
                    return Auth(
                      wm: wm,
                    );
                  case AuthState.login:
                    return Login(
                      wm: wm,
                    );
                  case AuthState.registrate:
                    return Registrate(
                      wm: wm,
                    );
                  default:
                    return Auth(
                      wm: wm,
                    );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
