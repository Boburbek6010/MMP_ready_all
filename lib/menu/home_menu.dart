import 'dart:io';
import 'package:learn_english_word_by_word/menu/test_menu.dart';
import 'package:learn_english_word_by_word/services/ext_service.dart';
import '../models/menu_model.dart';
import '../services/io_service.dart';
import '../services/setting_language.dart';
import 'all_words_menu.dart';
import 'package:learn_english_word_by_word/services/navigation_service.dart';
import 'create_word_menu.dart';

void font1(String value){
  print('\x1b[51m $value \x1b[0m');
}

void font(String value){
  writeln('\x1b[7m $value \x1b[0m');
}

void redFont(String value){
  writeln('\t\x1b[31m $value\x1b[0m');
}

class HomeMenu extends Menu{
  static const String id = "/home_menu";

  Future<void> selectFunction(String selectedMenu) async {
    switch(selectedMenu) {
      case "I": {
        write("\n\n\n");
        await Navigator.push(CreateWordMenu());
      } break;
      case "II": {
        write("\n\n\n");
        await Navigator.push(AllWordsMenu());
      } break;
      case "III": {
        write("\n\n\n");
        await Navigator.push(TestMenu());
      } break;
      case "IV": {
        write("\n\n\n");
        await Navigator.push(SettingLanguage());
      } break;
      case "V": exit(0);
      default: {
        writeln("error".tr);
        await Navigator.popUntil();
      }
    }
  }

  @override
  Future<void> build() async {

    print('\n');
    font1("\t\t\t""I. " + "create_word".tr+"\t\t\t");
    font1("\t\t\t""II. " + "view_all_words".tr+"\t\t\t\t");
    font1("\t\t\t""III. " + "test".tr+"\t\t\t\t\t\t");
    font1("\t\t\t""IV. " + "settings".tr+"\t\t\t");
    font1("\t\t\t""V. " + "exit".tr+"\t\t\t");
    String selectedMenu = read();
    await selectFunction(selectedMenu);
  }
}