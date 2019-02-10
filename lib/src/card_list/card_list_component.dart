import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import "package:flash_card_web/src/card_list/single_card_component.dart";
import 'package:flash_card_web/src/service/edit_card_service.dart';
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
    MaterialInputComponent,
    WordCardComponent,
    ModalComponent,
    NgFor,
    NgIf,
  ],
  providers: const [
    overlayBindings,
    ClassProvider(EditCardService)
  ]
)
class CardListComponent extends OnInit implements OnCardEditEvent {
  final FlashCardService _service;
  final EditCardService _editCardService;

  bool _editMode = false;

  bool get editCard => _editMode;
  WordCard currentCard;

  List<WordCard> get words => _service.getWords();

  OnCardEditEvent get dialogHandler => this;

  CardListComponent(this._service, this._editCardService);

  @override
  Future<Null> ngOnInit() async {
    _editCardService.onDialogVisibilityChange.listen((showDialog) {
      _editMode = showDialog;
      print(_editMode);
    });
  }

  addNewCard() {
    print("Edit");
    _editCardService.newCard();
  }

  @override
  void onCancelled() => _editMode = false;

  @override
  void onUpdated() => _editMode = false;

  void onChange(String prefix) {
    _service.searchPrefix = prefix;
  }
}