import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:flash_card_web/src/service/edit_card_service.dart';

@Injectable()
class WordCardService {

  EditCardService _editCardService;

  WordCardService(this._editCardService) {
    this._editCardService.onDialogVisibilityChange.listen((visible) {
      if (visible) {
        var current = _editCardService.relatedWords;

        _relatedWords.clear();

        current.forEach((key, value) {
          _relatedWords = List();
          switch (key) {
            case "male": _relatedWords.add(RelatedWord(RelatedWordType.masculine, value));
              break;
            case "female": _relatedWords.add(RelatedWord(RelatedWordType.feminine, value));
              break;
            case "neutral": _relatedWords.add(RelatedWord(RelatedWordType.neutral, value));
              break;
            case "plural": _relatedWords.add(RelatedWord(RelatedWordType.plural, value));
              break;
          }
        });
      }
    });
  }
  List<RelatedWord> _relatedWords = List();

  List<RelatedWord> getRelatedWords() => _relatedWords;
  addRelatedWord(RelatedWord word) => _relatedWords.add(word);

  clear() => _relatedWords.clear();
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

