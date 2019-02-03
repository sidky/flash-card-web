import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:flash_card_web/src/word_card/word_card_service.dart';

@Component(
    selector: 'related-word',
    styleUrls: ['related_word_component.css'],
    templateUrl: 'related_word_component.html',
    directives: [
      MaterialCheckboxComponent,
      MaterialDropdownSelectComponent,
      MaterialFabComponent,
      MaterialIconComponent,
      materialInputDirectives,
      NgFor,
      NgIf,
    ],
    providers: [
      materialProviders,
    ]
)
class RelatedWordComponent {
  final WordCardService _service;

  RelatedWordComponent(this._service);

  List<RelatedWord> get relatedWords  => _service.getRelatedWords();

  static const List<RelatedWordSelectionType> _relatedWordTypes = [
    RelatedWordSelectionType(RelatedWordType.masculine, "masculine"),
    RelatedWordSelectionType(RelatedWordType.feminine, "feminine"),
    RelatedWordSelectionType(RelatedWordType.neutral, "singular"),
    RelatedWordSelectionType(RelatedWordType.plural, "plural")
  ];

  List<RelatedWordSelectionType> get availableTypes {
    var types = RelatedWordType.values.toSet();
    if (relatedWords != null) {
      relatedWords.forEach((r) => types.remove(r.wordType));
    }

    List<RelatedWordSelectionType> availables = List();

    _relatedWordTypes.forEach((t) {
      if (types.contains(t.wordType)) {
        availables.add(t);
      }
    });
    return availables;
  }

  final SelectionModel<RelatedWordSelectionType> currentSelection = SelectionModel.single();

  String get relatedWordTypeLabel {
    if (currentSelection.isNotEmpty) {
      return currentSelection.selectedValues.first.displayName;
    } else {
      return "Select a type";
    }
  }

  String currentWord = '';

  bool canAdd() => currentWord.isEmpty || currentSelection.isEmpty;

  add() {
    var r = RelatedWord(currentSelection.selectedValues.first.wordType, currentWord);
    _service.addRelatedWord(r);

    currentWord = '';
    currentSelection.clear();
  }

  String relatedWordDisplayName(RelatedWordType type) =>
    _relatedWordTypes.firstWhere((t) => t.wordType == type).displayName;

  remove(int index) {

  }
}
