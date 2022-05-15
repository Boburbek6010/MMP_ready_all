import '../models/menu_model.dart';
import '../services/file_service.dart';
import 'package:learn_english_word_by_word/services/navigation_service.dart';
class EditWordMenu extends Menu {
  static const String id = "/edit_note_menu";
  String? path;

  EditWordMenu({this.path});

  @override
  Future<void> build() async {
    FileService fileService = FileService();
    await fileService.updateFileFromPath(path!);
    await Navigator.popUntil();
  }

}