import 'dart:io';
import 'package:learn_english_word_by_word/menu/create_word_menu.dart';
import 'package:learn_english_word_by_word/menu/home_menu.dart';
import 'package:learn_english_word_by_word/services/ext_service.dart';
import 'package:learn_english_word_by_word/services/navigation_service.dart';
import '../models/menu_model.dart';
import '../services/io_service.dart';


class SelectDeleteMenu extends Menu {
  static const String id = "/select_delete_menu";
  List<FileSystemEntity>? list;

  SelectDeleteMenu({this.list});

  @override
  Future<void> build() async {
    font2("select_file".tr);
    font2("stop_to_delete".tr);
    List<int> selectedList = [];
    String stopWrite = "";

    while(true) {
      stopWrite = read();
        if(stopWrite == 'save'.tr || selectedList.length >= list!.length) {
          break;
        }
      selectedList.add(int.parse(stopWrite, onError: (error) => 0));
    }
    try{
      for(var item in selectedList) {
        if(item - 1 >= 0) {
          await list![item - 1].delete();
        }
      }
      font2("success_delete_all".tr);
    }catch(e){
      font2('not_found'.tr+'\n\n');
    }
  }

}