import 'package:firebase/firebase.dart';

enum CardType {
  word, conversation
}

enum WordType {
  male, female, neutral, plural, unknown
}

class WordCard {
  String word;
  String value;
  WordType wordType;
  Map<String, String> related;

  WordCard(this.word, this.value, this.wordType, this.related);
}

class FlashCardDAO {
  Database _db = database();

  void addWordCard(WordCard wordCard) {
    var card = {
      "type": wordCard.wordType.toString(),
      "value": wordCard.value,
      "related": wordCard.related
    };
    try {
      _db.ref("words").child(wordCard.word).push(card);
    } catch (e) {
      print("Error writing to db: $e");
    }
  }
}

