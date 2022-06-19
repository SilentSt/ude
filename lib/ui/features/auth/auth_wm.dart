import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ude/ui/features/editor/editor_widget.dart';
import 'package:ude/ui/widgets/app_error.dart';

import 'auth_model.dart';
import 'auth_widget.dart';

enum AuthState {
  auth,
  login,
  registrate,
}

abstract class IAuthScreenWidgetModel extends IWidgetModel {
  ListenableState<EntityState<AuthState>> get state;

  Future<void> authorize();

  Future<void> registrate();

  Future<void> changeState(AuthState state);

  TextEditingController get emailController;

  TextEditingController get passwordController;

  TextEditingController get nameController;
}

AuthScreenWidgetModel defaultProfileScreenWidgetModelFactory(
    BuildContext context) {
  return AuthScreenWidgetModel(
    AuthScreenModel(),
  );
}

class AuthScreenWidgetModel
    extends WidgetModel<AuthScreenWidget, AuthScreenModel>
    implements IAuthScreenWidgetModel {
  AuthScreenWidgetModel(AuthScreenModel model) : super(model);

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _nameController = TextEditingController();

  final _state = EntityStateNotifier<AuthState>();

  @override
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get passwordController => _passwordController;

  @override
  TextEditingController get nameController => _nameController;

  @override
  ListenableState<EntityState<AuthState>> get state => _state;

  @override
  void initWidgetModel() {
    _state.content(AuthState.auth);
    super.initWidgetModel();
  }

  @override
  Future<void> authorize() async {
    final res = await model.authService.login(
      //TODO: remove before deploy
      login: 'foo@bar.ru', //_emailController.text,
      password: '1namQfeg1_', //passwordController.text,
    );
    if (!res) {
      await showCupertinoDialog(
        context: context,
        builder: (context) => const AppError(),
      );
      return;
    }
    pushTo(const EditorScreenWidget());
  }

  void pushTo(ElementaryWidget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  @override
  Future<void> registrate() async {
    final res = await model.authService.createUser(
      name: _nameController.text,
      email: _emailController.text,
      password: passwordController.text,
    );
    if (!res) {
      await showCupertinoDialog(
        context: context,
        builder: (context) => const AppError(),
      );
      return;
    }
    await changeState(AuthState.login);
  }

  @override
  Future<void> changeState(AuthState state) async {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _state.loading();
    _state.content(state);
  }
}
