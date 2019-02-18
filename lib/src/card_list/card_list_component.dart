import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import "package:flash_card_web/src/card_list/single_card_component.dart";
import 'package:flash_card_web/src/card_list/single_sentence_card_component.dart';
import 'package:flash_card_web/src/card_list/single_verb_card_component.dart';
import 'package:flash_card_web/src/data/sentence_card.dart';
import 'package:flash_card_web/src/data/verb_form_card.dart';
import 'package:flash_card_web/src/sentence_card/sentence_card_component.dart';
import 'package:flash_card_web/src/service/edit_card_service.dart';
import "package:flash_card_web/src/service/flash_card_service.dart";
import 'package:flash_card_web/src/data/word_card.dart';
import 'package:angular_components/material_dialog/material_dialog.dart';
import 'package:flash_card_web/src/verb_form_card/verb_form_component.dart';
import 'package:flash_card_web/src/word_card/word_card_component.dart';

@Component(
  selector: "card-list",
  templateUrl: "card_list_component.html",
  directives: [
    SingleCardComponent,
    SingleVerbCardComponent,
    SingleSentenceCardComponent,
    MaterialDialogComponent,
    MaterialButtonComponent,
    MaterialInputComponent,
    SentenceCardComponent,
    WordCardComponent,
    VerbFormComponent,
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

  bool _editVerb = false;
  VerbFormCard _verb;

  bool _editSentence = false;
  SentenceCard _sentence;

  bool get editCard => _editMode;
  bool get editVerb => _editVerb;
  bool get editSentence => _editSentence;

  VerbFormCard get verb => _verb;
  SentenceCard get sentence => _sentence;

  WordCard currentCard;

  List<WordCard> get words => _service.getWords();
  List<VerbFormCard> get verbs => _service.getVerbs();
  List<SentenceCard> get sentences => _service.getSentences();

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

  addNewVerb() {
    print("Verb");
    _verb = null;
    _editVerb = true;
  }

  addNewSentence() {
    print("Sentence");
    _sentence = null;
    _editSentence = true;
  }

  editVerbCard(VerbFormCard card) {
    _verb = card;
    _editVerb = true;
  }

  editSentenceCard(SentenceCard card) {
    _sentence = card;
    _editSentence = true;
  }

  @override
  void onCancelled() => _editMode = false;

  @override
  void onUpdated() => _editMode = false;

  void onChange(String prefix) {
    _service.searchPrefix = prefix;
  }

  void onClosedVerbFormDialog() => _editVerb = false;

  void onClosedSentenceDialog() => _editSentence = false;
}