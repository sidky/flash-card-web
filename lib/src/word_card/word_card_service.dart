import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Injectable()
class WordCardService {
  List<RelatedWord> _relatedWords = List();

  List<RelatedWord> getRelatedWords() => _relatedWords;
  addRelatedWord(RelatedWord word) => _relatedWords.add(word);
}

enum RelatedWordType {
  masculine, feminine, neutral, plural
}

class RelatedWordSelectionType implements HasUIDisplayName {

  final RelatedWordType wordType;
  final String displayName;

  const RelatedWordSelectionType(this.wordType, this.displayName);

  @override
  String get uiDisplayName => displayName;

  @override
  String toString() => displayName;
}

class RelatedWord {
  final RelatedWordType wordType;
  final String relatedWord;

  const RelatedWord(this.wordType, this.relatedWord);
}

