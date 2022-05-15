import 'package:learn_english_word_by_word/models/content_model.dart';

class Word {
  late String word;
  late String translation;
  late Content content;
  late String time;

  Word({required this.word, required this.translation, required this.content}) {
    time = DateTime.now().toString();
  }

  Word.fromJson(Map<String, dynamic> json) {
    word = json["word"];
    translation = json["translation"];
    content = Content.fromJson(json ['content']);
    time = json["time"];

  }

  Map<String, dynamic> toJson() => {
    'word': word,
    'translation': translation,
    'content': content.toJson(),
    'time': time,
  };
  // ovveriding
  @override
  String toString() {
    return "Word: $word\nTranslation: $translation\n$content";
  }
}