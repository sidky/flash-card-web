import 'dart:async';

import 'package:angular/angular.dart';
import 'package:flash_card_web/src/data/sentence_card.dart';

@Component(
  selector: 'single-sentence-card',
  templateUrl: 'single_sentence_card_component.html',
  styleUrls: ['single_sentence_card_component.css']
)
class SingleSentenceCardComponent {

  StreamController<SentenceCard> _streamController = StreamController<SentenceCard>.broadcast(sync: true);

  @Input() SentenceCard card;

  @Output() Stream<SentenceCard> get onEdit => _streamController.stream;

  String get sentence => card != null ? card.question : '';

  edit() {
    _streamController.add(card);
  }
}