import 'package:angular/angular.dart';
import 'package:flash_card_web/src/data/word_card.dart';
import 'package:flash_card_web/src/service/edit_card_service.dart';

@Component(
  selector: "single-card",
  styleUrls: ["single_card_component.css"],
  templateUrl: "single_card_component.html",
  directives: const [NgClass]
)
class SingleCardComponent {

  final EditCardService _editCardService;

  SingleCardComponent(this._editCardService);

  @Input() WordCard card;

  String get word => card != null ? card.word : "";

  String get cardClass {
    if (card == null) {
      return "unknown";
    }
    switch (card.wordType) {
      case WordType.male: return "male";
      case WordType.female: return "female";
      case WordType.neutral: return "neutral";
      case WordType.plural: return "plural";
      default: return "unknown";
    }
  }

  edit() {
    _editCardService.editCard(card);
  }
}