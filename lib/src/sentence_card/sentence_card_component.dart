import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:flash_card_web/src/data/sentence_card.dart';
import 'package:flash_card_web/src/dialog_header/dialog_header_component.dart';
import 'package:flash_card_web/src/service/flash_card_service.dart';

@Component(
  selector: 'sentence-card',
  templateUrl: 'sentence_card_component.html',
  directives: const [
    DialogHeaderComponent,
    materialInputDirectives,
  ]
)
class SentenceCardComponent {

  final StreamController<bool> _onClosed = StreamController<bool>.broadcast(sync: true);

  @Output()
  Stream<bool> get onClosed => _onClosed.stream;

  FlashCardService _service;

  SentenceCardComponent(this._service);

  String question;
  String questionTranslation;
  String answer;
  String answerTranslation;

  @Input()
  set card(SentenceCard card) {
    question = card.question;
    questionTranslation = card.questionTranslation;
    answer = card.answer;
    answerTranslation = card.answerTranslation;
  }

  saveSentence() async {
    var card = SentenceCard(question, questionTranslation, answer, answerTranslation);
    _service.addSentence(card);
    resetSentence();
    _onClosed.add(true);
  }

  cancel() {
    resetSentence();
    _onClosed.add(true);
  }

  resetSentence() {
    question = '';
    questionTranslation = '';
    answer = '';
    answerTranslation = '';
  }
}