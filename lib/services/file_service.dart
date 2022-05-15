import 'dart:convert';
import 'dart:io';

import 'package:learn_english_word_by_word/services/ext_service.dart';

import '../models/word_model.dart';
import 'io_service.dart';

class FileService {
  Directory directory = Directory(Directory.current.path + "\\assets\\files");

  /// this method use for initialization...
  Future<void> init() async {
    bool isDirectoryCreated = await directory.exists();
    if (!isDirectoryCreated) {
      await directory.create();
    }
  }

  Future<String> createFile(String word) async {
    File file = File(directory.path + "\\$word");
    bool isFileCreated = await file.exists();
    if (isFileCreated) {
      /// this below code will be edited when I set language service
      throw Exception("\t\x1b[31m ${"file_error".tr}\x1b[0m");
    }
    await file.create();
    return file.path;
  }

  Future<String> writeFile(Word word, String path) async {
    File file = File(path);
    ///this code will write when I set language service
    await file.writeAsString(jsonEncode(word.toJson()));
    await file.setLastModified(DateTime.parse(word.time));
    return file.path;
  }

  Future<Word> readFile(String note) async {
    File file = File(directory.path + "\\$note");
    bool isFileCreated = await file.exists();
    if (!isFileCreated) {
      ///this below code will be edited when I set language service
      throw Exception("File not found");
    }
    String result = await file.readAsString();
    Word word = Word.fromJson(jsonDecode(result));
    return word;
  }

  Future<Word> readFileFromPath(String path) async {
    File file = File(path);
    String result = await file.readAsString();
    Word word = Word.fromJson(jsonDecode(result));
    return word;
  }



  Future<String> updateFileFromPath(String path) async {
    Word word = await readFileFromPath(path);

    writeln("previous_word".tr);
    writeln(word);
    writeln("edit_word".tr);
    String content = stdin.readLineSync()!;
    // String exit = read();
    // content += (exit + "\n");
    word.translation = content;
    word.time = DateTime.now().toString();
    return await writeFile(word, path);
  }

  Future<void> deleteFile(String word) async {
    File file = File(directory.path + "\\$word");
    await file.delete();
  }

  Future<void> deleteFileFromPath(String path) async {
    File file = File(path);
    await file.delete();
  }

  Future<void> deleteAllFile() async {
    List<FileSystemEntity> list = directory.listSync();
    for (var item in list) {
      await item.delete();
    }
  }
}
