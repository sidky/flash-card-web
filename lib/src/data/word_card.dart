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
