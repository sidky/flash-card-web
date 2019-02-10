import 'dart:async';

import 'package:flash_card_web/src/data/word_card.dart';
import 'package:angular/angular.dart';
import 'package:flash_card_web/src/service/flash_card_service.dart';

@Injectable()
class EditCardService {
  final FlashCardService _flashCardService;

  EditCardService(this._flashCardService);

  WordCard _card;
  StreamController<bool> _showEdit = new StreamController<bool>.broadcast();

  editCard(WordCard card) {
    _card = card;
    _showEdit.add(true);
  }

  newCard() {
    _card = null;
    _showEdit.add(true);
  }

  saveCard(WordCard card) {
    _flashCardService.addWord(card);
    _showEdit.add(false);
  }

  cancel() {
    _showEdit.add(false);
  }

  String get word => _card != null ? _card.word : '';
  String get translation => _card != null ? _card.value : '';
  WordType get cardType => _card != null ? _card.wordType : WordType.unknown;

  Map<String, String> get relatedWords => _card != null ? _card.related : Map();

  Stream<bool> get onDialogVisibilityChange => _showEdit.stream;
}