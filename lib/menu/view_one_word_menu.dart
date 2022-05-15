import 'dart:io';
import 'package:learn_english_word_by_word/menu/create_word_menu.dart';
import 'package:learn_english_word_by_word/menu/home_menu.dart';
import 'package:learn_english_word_by_word/services/ext_service.dart';
import '../models/menu_model.dart';
import '../models/word_model.dart';
import '../services/file_service.dart';
import '../services/io_service.dart';
import 'etid_word_menu.dart';
import 'package:learn_english_word_by_word/services/navigation_service.dart';

class ViewOneWordMenu extends Menu {
  static const String id = "/view_one_note_menu";
  List<FileSystemEntity>? list;

  ViewOneWordMenu({this.list});

  Future<String> getFileFromPath(int id) async {
    FileSystemEntity fileSystemEntity = list![id - 1];
    String path = fileSystemEntity.path;
    Word word = await FileService().readFileFromPath(path);
    return word.toString();
  }

  Future<void> selectFunction(String selectedMenu, int id) async {
    FileSystemEntity fileSystemEntity = list![id - 1];
    String path = fileSystemEntity.path;
    switch(selectedMenu) {
      case "I": {
        write("\n\n\n");
        await Navigator.push(EditWordMenu(path: path));
      } break;
      case "II": {
        write("\n\n\n");
        FileService fileService = FileService();
        await fileService.deleteFileFromPath(path);
        await Navigator.pop();
      } break;
      case "III": {
        write("\n\n\n");
        await Navigator.pop();
      } break;
      case "IV": {
        write("\n\n\n");
        await Navigator.popUntil();
      } break;
      default: {
        redFont("error".tr);
      }
    }
  }


  @override
  Future<void> build() async {
    write("enter_word_number".tr);
    int noteNumber = read().toInt;
    String note = await getFileFromPath(noteNumber);
    font2(note + "\n");
    font2("I. " + "update".tr);
    font2("II. " + "delete".tr);
    font2("III. " + "back_to".tr);
    font2("IV. " + "back_to_home".tr);
    String selectedMenu = read();
    await selectFunction(selectedMenu, noteNumber);
  }
}