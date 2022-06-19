// ignore_for_file: depend_on_referenced_packages

import 'package:code_text_field/code_text_field.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:ude/data/local_storage/user_storage.dart';
import 'package:ude/data/models/code.dart';
import 'package:ude/ui/widgets/app_error.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/matlab.dart';

import 'editor_model.dart';
import 'editor_widget.dart';

enum Language {
  matlab,
  css,
  cpp,
}

abstract class IEditorScreenWidgetModel extends IWidgetModel {
  ListenableState<EntityState<CodeController>> get codeController;
  TextEditingController get fileNameController;
  TextEditingController get senseController;
  ListenableState<EntityState<Language>> get languageController;
  ListenableState<EntityState<String>> get console;
  ListenableState<EntityState<List<String>>> get sense;
  ListenableState<EntityState<Language>> get language;
  ListenableState<EntityState<List<File>>> get files;
  ListenableState<EntityState<File>> get currentFile;
  ListenableState<EntityState<bool>> get fileChanged;
  ListenableState<EntityState<TextSelection>> get currentSelection;
  BuildContext get getContext;
  Future<void> createFile();
  Future<void> compile();
  Future<void> createSense();
  Future<void> editFile();
  Future<void> removeSense(int index);
  Future<void> editSense(int index);
  void implementSense(String sense);
  void senseListener();
  void changeCurrentFile(int index);
}

EditorScreenWidgetModel defaultEditorScreenWidgetModelFactory(
    BuildContext context) {
  return EditorScreenWidgetModel(
    EditorScreenModel(),
  );
}

class EditorScreenWidgetModel
    extends WidgetModel<EditorScreenWidget, EditorScreenModel>
    implements IEditorScreenWidgetModel {
  EditorScreenWidgetModel(EditorScreenModel model) : super(model);

  @override
  Future<void> initWidgetModel() async {
    try {
      _codeController.content(CodeController(
        language: matlab,
        theme: monokaiSublimeTheme,
      ));
      _codeController.value!.data!.addListener(() {
        senseListener();
      });
      _currentSelection.content(_codeController.value!.data!.selection);
      await model.codeService.getFiles();
      if (UserStorage.files.isEmpty) {
        await model.codeService.sendFile(
          code: '',
        );
      }
      await model.senseService.getSense();
      _files.content(UserStorage.files);
      _language.content(Language.matlab);
      _languageController.content(Language.matlab);
      _currentFile.content(UserStorage.files.first);
      _sense.content(UserStorage.sense.sense);
      _console.content('');
    } on Exception catch (e) {
      await showCupertinoDialog(
        context: context,
        builder: (context) => AppError(error: e.toString()),
      );
      return;
    }
    super.initWidgetModel();
  }

  final _codeController = EntityStateNotifier<CodeController>();

  final _files = EntityStateNotifier<List<File>>();

  final _language = EntityStateNotifier<Language>();

  final _sense = EntityStateNotifier<List<String>>();

  final _console = EntityStateNotifier<String>();

  final _currentFile = EntityStateNotifier<File>();

  final _fileNameController = TextEditingController();

  final _languageController = EntityStateNotifier<Language>();

  final _senseController = TextEditingController();

  final _currentSelection = EntityStateNotifier<TextSelection>();

  final _fileChanged = EntityStateNotifier<bool>(
    const EntityState(data: false),
  );

  @override
  ListenableState<EntityState<CodeController>> get codeController =>
      _codeController;

  @override
  ListenableState<EntityState<List<File>>> get files => _files;

  @override
  ListenableState<EntityState<Language>> get language => _language;

  @override
  ListenableState<EntityState<List<String>>> get sense => _sense;

  @override
  ListenableState<EntityState<String>> get console => _console;

  @override
  ListenableState<EntityState<File>> get currentFile => _currentFile;

  @override
  TextEditingController get fileNameController => _fileNameController;

  @override
  ListenableState<EntityState<Language>> get languageController =>
      _languageController;

  @override
  ListenableState<EntityState<TextSelection>> get currentSelection =>
      _currentSelection;

  @override
  TextEditingController get senseController => _senseController;

  @override
  BuildContext get getContext => context;

  @override
  ListenableState<EntityState<bool>> get fileChanged => _fileChanged;

  @override
  Future<void> compile() async {
    final file = _currentFile.value!.data!;
    final res = await model.codeService.compile(
      lng: file.lng,
    );
    if (!res) {
      await showCupertinoDialog(
        context: context,
        builder: (context) => const AppError(),
      );
      return;
    }
    _console.content(UserStorage.results.last.data);
  }

  @override
  Future<void> editFile() async {
    final file = _currentFile.value!.data!;
    final res = await model.codeService.sendFile(
      lng: file.lng,
      name: file.name,
      code: file.code,
    );
    if (!res) {
      await showCupertinoDialog(
        context: context,
        builder: (context) => const AppError(),
      );
      return;
    }
    _files.content(UserStorage.files);
  }

  @override
  Future<void> createFile() async {
    final lng = languageConverterToInt(lang: _languageController.value!.data!);
    final res = await model.codeService.sendFile(
      lng: lng,
      name: _fileNameController.text,
      code: '',
    );
    if (!res) {
      await showCupertinoDialog(
        context: context,
        builder: (context) => const AppError(),
      );
      return;
    }
    _files.content(UserStorage.files);
  }

  @override
  Future<void> createSense() async {
    final res = await model.senseService.saveSense(_senseController.text);
    if (!res) {
      await showCupertinoDialog(
        context: context,
        builder: (context) => const AppError(),
      );
      return;
    }
    _sense.content(UserStorage.sense.sense);
  }

  @override
  Future<void> editSense(int index) async {
    await removeSense(index);
    final res = await model.senseService.saveSense(_senseController.text);
    if (!res) {
      await showCupertinoDialog(
        context: context,
        builder: (context) => const AppError(),
      );
      return;
    }
    _sense.content(UserStorage.sense.sense);
  }

  @override
  Future<void> removeSense(int index) async {
    final res = await model.senseService.removeSense(index);
    if (!res) {
      await showCupertinoDialog(
        context: context,
        builder: (context) => const AppError(),
      );
      return;
    }
  }

  int languageConverterToInt({Language? lang}) {
    final lng = lang ?? _language.value!.data!;
    switch (lng) {
      case Language.matlab:
        return 1;
      case Language.css:
        return 2;
      case Language.cpp:
        return 3;
      default:
        throw UnimplementedError(
          'Unknown language, please add it into language enum and languageConverterToInt(Language lng)',
        );
    }
  }

  Language languageConverterFromInt({required int lng}) {
    switch (lng) {
      case 1:
        return Language.matlab;
      case 2:
        return Language.css;
      case 3:
        return Language.cpp;
      default:
        throw UnimplementedError(
          'Unknown language, please add it into language enum and languageConverterFromInt(Language lng)',
        );
    }
  }

  @override
  void implementSense(String sense) {
    final selection = _currentSelection.value!.data!;
    if (selection.baseOffset < 0) {
      return;
    }
    String lastWord = '';
    final parsed = selection
        .textBefore(_codeController.value!.data!.text)
        .split('')
        .reversed;
    for (var ch in parsed) {
      if (ch == ' ' || ch == '\n' || ch == '&' || ch == '|') {
        break;
      }
      lastWord = ch + lastWord;
    }
    for (int i = 0; i < lastWord.length; i++) {
      _codeController.value!.data!.backspace();
    }
    _codeController.value!.data!.insertStr(sense);
    _sense.content(UserStorage.sense.sense);
  }

  @override
  void senseListener() {
    if (_codeController.value!.data!.text != _currentFile.value!.data!.code) {
      _fileChanged.content(true);
    } else {
      _fileChanged.content(false);
    }
    String lastWord = '';
    final selection = _codeController.value!.data!.selection;
    _currentSelection.content(selection);
    if (_codeController.value!.data!.text.isNotEmpty) {
      if (selection.baseOffset < 0) {
        return;
      }
      final parsed = selection
          .textBefore(_codeController.value!.data!.text)
          .split('')
          .reversed;
      for (var ch in parsed) {
        if (ch == ' ' || ch == '\n' || ch == '&' || ch == '|') {
          break;
        }
        lastWord = ch + lastWord;
      }
      _sense.content(UserStorage.sense.sense
          .where((element) => element.contains(lastWord))
          .toList());
    }
  }

  @override
  void changeCurrentFile(int index) {
    _currentFile.content(_files.value!.data![index]);
  }
}
