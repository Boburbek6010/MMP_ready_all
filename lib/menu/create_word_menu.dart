

import 'dart:io';


import 'package:learn_english_word_by_word/models/content_model.dart';
import 'package:learn_english_word_by_word/services/ext_service.dart';

import 'package:learn_english_word_by_word/services/navigation_service.dart';
import '../models/menu_model.dart';
import '../models/word_model.dart';
import '../services/file_service.dart';
import '../services/io_service.dart';
import 'home_menu.dart';

void font2(String value){
  writeln('\t\x1b[36m $value\x1b[0m');
}

void font2_2(String value){
  write('\t\x1b[36m $value\x1b[0m');
}

class CreateWordMenu extends Menu {
  static final String id = "/create_note_menu";


  Future<void> createWord() async {
    FileService fileService = FileService();
    await fileService.init();


    font2_2("new_word_name".tr);

    String words = read();
    if (words.length > 2) {
      String path = "";

      try {
        path = await fileService.createFile(words);
      } catch (error) {
        writeln(error);
        await createWord();
      }

      font2_2("write_word".tr);
      String translate = "";
      String stopWrite = stdin.readLineSync()!;
      translate += (stopWrite);

      List enList = [];
      enList.add(words);
      List uzList = [];
      uzList.add(translate);

      font2_2("write_description".tr);
      String description = read();

      font2_2("write_example".tr);
      String example = read();
      Content content = Content(description: description, example: example);

      Word word = Word(word: words, translation: translate, content: content);
      await fileService.writeFile(word, path);
      font2("word_save".tr);
      write("\n\n\n");
      await Navigator.popUntil();
    }else{
      print("length_word_error".tr);
      await Navigator.push(CreateWordMenu());
    }
  }

  @override
  Future<void> build() async {
    font2("Menu: " + "create_word".tr);
    await createWord();
  }
}