enum CardType {
  word, conversation
}

enum WordType {
  male, female, neutral, plural, unknown
}

class WordCard {
  final String word;
  final String value;
  final WordType wordType;
  final Map<String, String> related;

  const WordCard(this.word, this.value, this.wordType, this.related);
}
