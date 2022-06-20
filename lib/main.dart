import 'package:flutter/material.dart';
import 'package:ude/ui/features/auth/auth_widget.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: AuthScreenWidget(),
    );
  }
}
