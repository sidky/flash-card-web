import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/material_input/material_input.dart';
import 'package:flash_card_web/src/data/verb_form_card.dart';
import 'package:flash_card_web/src/dialog_header/dialog_header_component.dart';
import 'package:flash_card_web/src/service/flash_card_service.dart';

@Component(
  selector: 'verb-form-card',
  templateUrl: 'verb_form_component.html',
  directives: [
    DialogHeaderComponent,
    MaterialCheckboxComponent,
    MaterialDropdownSelectComponent,
    MaterialFabComponent,
    MaterialButtonComponent,
    MaterialIconComponent,
    materialInputDirectives,
    materialProviders,
    ModalComponent,
    NgFor,
    NgIf,
  ],
  providers: [
    materialProviders
  ]
)
class VerbFormComponent {

  final StreamController<bool> _dialogClosed = StreamController<bool>.broadcast(sync: true);

  @Output()
  Stream<bool> get onClosed => _dialogClosed.stream;

  FlashCardService _service;

  String verb;
  String translation;
  String ichForm;
  String duForm;
  String erSieEsForm;
  String wirForm;
  String ihrForm;
  String siePluralForm;
  String SieForm;

  @Input()
  set verbForm(VerbFormCard verbForm) {
    if (verbForm != null) {
      verb = verbForm.word;
      translation = verbForm.translation;
      ichForm = verbForm.pronouns['ich'];
      duForm = verbForm.pronouns['du'];
      erSieEsForm = verbForm.pronouns['er'];
      wirForm = verbForm.pronouns['wir'];
      ihrForm = verbForm.pronouns['ihr'];
      siePluralForm = verbForm.pronouns['sie'];
      SieForm = verbForm.pronouns['Sie'];
    } else {
      print('Reset');
      resetWord();
    }
  }

  VerbFormComponent(this._service);

  saveWord() {
    var card = _getCard();
    print(card);
    _service.addVerb(card);
    resetWord();
    _dialogClosed.add(true);
  }

  cancel() {
    resetWord();
    _dialogClosed.add(false);
  }

  resetWord() {
    verb = '';
    translation = '';
    ichForm = '';
    duForm = '';
    erSieEsForm = '';
    wirForm = '';
    ihrForm = '';
    siePluralForm = '';
    SieForm = '';
  }

  VerbFormCard _getCard() {
    var pronouns = {
      VerbPronounForm.ich: ichForm,
      VerbPronounForm.du: duForm,
      VerbPronounForm.er: erSieEsForm,
      VerbPronounForm.sie: erSieEsForm,
      VerbPronounForm.es: erSieEsForm,
      VerbPronounForm.wir: wirForm,
      VerbPronounForm.ihr: ihrForm,
      VerbPronounForm.siePlural: siePluralForm,
      VerbPronounForm.Sie: SieForm
    };
    return VerbFormCard(verb, translation, pronouns);
  }
}