import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import "package:flash_card_web/src/card_list/single_card_component.dart";
import "package:flash_card_web/src/service/flash_card_service.dart";
import 'package:flash_card_web/src/data/word_card.dart';
import 'package:angular_components/material_dialog/material_dialog.dart';
import 'package:flash_card_web/src/word_card/word_card_component.dart';

@Component(
  selector: "card-list",
  templateUrl: "card_list_component.html",
  directives: [
    SingleCardComponent,
    MaterialDialogComponent,
    MaterialButtonComponent,
    WordCardComponent,
    ModalComponent,
    NgFor,
    NgIf,
  ],
  providers: const [overlayBindings]
)
class CardListComponent implements OnCardEditEvent {
  final FlashCardService _service;
  bool _editMode = false;

  bool get editCard => _editMode;
  WordCard currentCard;

  List<WordCard> get words => _service.getWords();

  OnCardEditEvent get dialogHandler => this;

  CardListComponent(this._service);

  addNewCard() {
    currentCard = WordCard("", "", WordType.unknown, Map());
    _editMode = true;
  }

  @override
  void onCancelled() => _editMode = false;

  @override
  void onUpdated() => _editMode = false;
}