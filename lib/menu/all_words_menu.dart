import 'package:learn_english_word_by_word/menu/home_menu.dart';
import 'package:learn_english_word_by_word/menu/select_delete_menu.dart';
import 'package:learn_english_word_by_word/services/navigation_service.dart';
import 'dart:io';

import 'package:learn_english_word_by_word/menu/view_one_word_menu.dart';
import 'package:learn_english_word_by_word/services/ext_service.dart';

import '../models/menu_model.dart';
import '../services/file_service.dart';
import '../services/io_service.dart';
import 'create_word_menu.dart';

class AllWordsMenu extends Menu {
  static const String id = "all_notes_menu";

  Future<void> viewWordList() async {
    FileService fileService = FileService();
    await fileService.init();
    List<FileSystemEntity> files = fileService.directory.listSync();
    if(files.isNotEmpty) {
      for(int i = 0; i < files.length; i++) {
        font2("${i + 1}. ${files[i].path.substring(files[0].path.lastIndexOf("\\") + 1)}");
      }

      font1("I. " + "number_word".tr);
      font1("II. " + "delete_all".tr);
      font1("III. " + "delete_selected".tr);
      font1("IV. " + "back_to_home".tr);
      String selectedMenu = read();
      await selectFunctionIf(selectedMenu, files);
    } else {
      font2("no_word".tr);
      font("I. " + "create_word".tr);
      font("II. " + "back_to_home".tr);
      String selectedMenu = read();
      await selectFunctionElse(selectedMenu);
    }
  }

  Future<void> selectFunctionIf(String selectedMenu, List<FileSystemEntity> files) async {
    switch(selectedMenu) {
      case "I": {
        write("\n\n\n");
        await Navigator.push(ViewOneWordMenu(list: files));
      } break;
      case "II": {
        font2('sure'.tr);
        redFont('yes');
        font2('no');
        String sure = read();
        if(sure == 'yes') {
          write("\n\n\n");
          await FileService().deleteAllFile();
          font2("deleted_successfully".tr);
          await Navigator.popUntil();
        }else if(sure == 'no'){
          write("\n\n\n");
          await Navigator.push(AllWordsMenu());
        }else{
          redFont("error".tr);
          await Navigator.push(AllWordsMenu());
        }
      } break;
      case "III": {
        write("\n\n\n");
        await Navigator.push(SelectDeleteMenu(list: files));
      } break;
      case "IV":{
        write("\n\n\n");
        await Navigator.popUntil();
      }break;
      default: {
        redFont("error".tr);
        await Navigator.push(AllWordsMenu());
      }
    }
  }


  Future<void> selectFunctionElse(String selectedMenu) async {
    switch(selectedMenu) {
      case "I": {
        write("\n\n\n");
        await Navigator.pushReplacement(CreateWordMenu());
      } break;
      case "II": {
        write("\n\n\n");
        await Navigator.pop();
      } break;
      default: {
        redFont("error".tr);
      }
    }
  }

  @override
  Future<void> build() async {
    await viewWordList();
  }

}