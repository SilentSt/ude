import 'package:elementary/elementary.dart';
import 'package:ude/domain/code_service.dart';
import 'package:ude/domain/sense_service.dart';

class EditorScreenModel extends ElementaryModel {
  final CodeService codeService;
  final SenseService senseService;

  EditorScreenModel({
    this.codeService = const CodeService(),
    this.senseService = const SenseService(),
  });
}
