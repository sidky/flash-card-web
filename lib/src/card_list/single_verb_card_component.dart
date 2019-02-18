import 'dart:async';

import 'package:angular/angular.dart';
import 'package:flash_card_web/src/data/verb_form_card.dart';

@Component(
    selector: 'single-verb-card',
    styleUrls: ['single_verb_card_component.css'],
    templateUrl: 'single_verb_card_component.html',
    directives: const [
      NgClass
    ]
)
class SingleVerbCardComponent {
  @Input() VerbFormCard card;

  StreamController<VerbFormCard> _streamController = StreamController<VerbFormCard>.broadcast(sync: true);

  @Output() Stream get onEdit => _streamController.stream;

  String get word => card != null ? card.word : "";

  edit() {
    _streamController.add(card);
  }
}