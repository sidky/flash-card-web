import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:flash_card_web/src/data/word_card.dart';
import 'package:flash_card_web/src/dialog_header/dialog_header_component.dart';
import 'package:flash_card_web/src/service/edit_card_service.dart';
import 'package:flash_card_web/src/word_card/related_word_component.dart';
import 'package:flash_card_web/src/word_card/word_card_service.dart';
import 'package:flash_card_web/src/service/flash_card_service.dart';

@Component(
  selector: 'word-card',
  templateUrl: 'word_card_component.html',
  directives: [
    DialogHeaderComponent,
    MaterialCheckboxComponent,
    MaterialDropdownSelectComponent,
    MaterialFabComponent,
    MaterialButtonComponent,
    MaterialIconComponent,
    RelatedWordComponent,
    materialInputDirectives,
    materialProviders,
    ModalComponent,
    NgFor,
    NgIf,
  ],
  providers: [
    materialProviders,
    ClassProvider(WordCardService)
  ]
)
class WordCardComponent implements OnInit {

  @Input() OnCardEditEvent handler;

  final WordCardService _wordCardService;
  final FlashCardService _flashCardService;
  final EditCardService _editCardService;

  bool showDialog;

  WordCardComponent(this._wordCardService, this._flashCardService, this._editCardService);

  var word = '';
  var translation = '';
  final SelectionModel<WordTypeSelection> selectionModel = SelectionModel.single(selected: wordTypes[2]);

  static const wordTypes = [
    WordTypeSelection(WordType.female, "Female"),
    WordTypeSelection(WordType.male, "Male"),
    WordTypeSelection(WordType.neutral, "Neutral"),
    WordTypeSelection(WordType.plural, "Plural"),
    WordTypeSelection(WordType.unknown, "Unknown")];

  List<WordTypeSelection> get wordTypeSelections => wordTypes;

  String get wordTypeLabel =>
    selectionModel.selectedValues.isNotEmpty ? selectionModel.selectedValues.first.uiDisplayName : "Select a word type";

  WordTypeSelection _findSelection(WordType wordType) {
    return wordTypes.firstWhere((selection) => selection.wordType == wordType);
  }

  ngOnInit() {
    print("ngOnInit");
    _editCardService.onDialogVisibilityChange.listen((showDialog) {
      if (showDialog) {
        word = _editCardService.word;
        translation = _editCardService.translation;
        selectionModel.select(_findSelection(_editCardService.cardType));
      }
      this.showDialog = showDialog;
    });

  }

  saveWord() {
    Map<String, String> relatedWords = Map();

    _wordCardService.getRelatedWords().forEach((word) {
      relatedWords[_relatedWordType(word.wordType)] = word.relatedWord;
    });
    var card = WordCard(word, translation, selectionModel.selectedValues.first.wordType, relatedWords);
    _flashCardService.addWord(card);

    if (handler != null) {
      handler.onUpdated();
    }
  }

  cancel() {
    if (handler != null) {
      handler.onCancelled();
    }
  }

  reset() {
    _wordCardService.clear();
    word = '';
    translation = '';
    selectionModel.clear();
  }

  String _relatedWordType(RelatedWordType t) {
    switch (t) {
      case RelatedWordType.feminine: return "female";
      case RelatedWordType.masculine: return "male";
      case RelatedWordType.neutral: return "neutral";
      case RelatedWordType.plural: return "plural";
      default: return null;
    }
  }
}

class WordTypeSelection implements HasUIDisplayName {
  final WordType wordType;
  final String label;

  const WordTypeSelection(this.wordType, this.label);

  @override
  String get uiDisplayName => label;

  @override
  String toString() => uiDisplayName;
}

abstract class OnCardEditEvent {
  void onCancelled();
  void onUpdated();
}