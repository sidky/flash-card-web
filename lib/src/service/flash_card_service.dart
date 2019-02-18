import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart';
import 'package:flash_card_web/src/data/firebase_dao.dart';
import 'package:flash_card_web/src/data/sentence_card.dart';
import 'package:flash_card_web/src/data/verb_form_card.dart';
import 'package:flash_card_web/src/data/word_card.dart';

enum SortOrder {
  word, type
}

@Injectable()
class FlashCardService {
  FirebaseDAO _dao;

  List<WordCard> _words;
  List<VerbFormCard> _verbs;
  List<SentenceCard> _sentences;

  SortOrder _sortOrder = SortOrder.word;

  String _searchPrefix;

  set sortOrder(SortOrder order) {
    _sortOrder = order;
  }

  set searchPrefix(String prefix) {
    _searchPrefix = prefix;
  }

  static final Function _orderByWord = (WordCard card1, WordCard card2) => card1.word.toLowerCase().compareTo(card2.word.toLowerCase());
  static final Function _orderByType = (WordCard card1, WordCard card2) => card1.wordType != card2.wordType ?
  card1.wordType.index.compareTo(card2.wordType.index) : card1.word.toLowerCase().compareTo(card2.word.toLowerCase());

  FlashCardService(this._dao) {
    _dao.onValue("words").listen((e) {
      DataSnapshot snapshot = e.snapshot;
      List<WordCard> cards = List();

      snapshot.forEach((child) {
        String value = child.child("value").val();
        WordType type = _parseWordType(child.child("type").val());

        Map<String, String> related = Map();

        child.child("related").forEach((r) {
          String key = r.key;
          String value = r.val();
          related[key] = value;
        });

        var w = WordCard(child.key, value, type, related);
        cards.add(w);
      });
      _words = cards;
    });

    _dao.onValue("verbs").listen((e) {
      DataSnapshot snapshot = e.snapshot;
      List<VerbFormCard> cards = List();

      snapshot.forEach((child) {
        String  value = child.child("value").val();

        Map<VerbPronounForm, String> forms = Map();
        
        child.child("forms").forEach((r) {
          VerbPronounForm key = _parsePronounForm(r.key);
          String value = r.val();
          forms[key] = value;
        });

        VerbFormCard card = VerbFormCard(child.key, value, forms);
        cards.add(card);
      });
      _verbs = cards;
    });

    _dao.onValue("sentences").listen((e) {
      DataSnapshot snapshot = e.snapshot;
      List<SentenceCard> cards = List();

      snapshot.forEach((child) {
        String question = child.key;
        String questionTranslation = child.child("translation").val();
        String answer = child.child("answer").val();
        String answerTranslation = child.child("answer_translation").val();

        cards.add(SentenceCard(question, questionTranslation, answer, answerTranslation));
      });

      _sentences = cards;
    });
  }

  List<WordCard> getWords() {

    List<WordCard> cards = List();

    if (_words == null) return List();

    _words.forEach((card) {
      if (_searchPrefix == null || card.word.startsWith(_searchPrefix)) {
        cards.add(card);
      }
    });

    if (_sortOrder == SortOrder.word) {
      cards.sort(_orderByWord);
    } else if (_sortOrder == SortOrder.type) {
      cards.sort(_orderByType);
    }

    return cards;
  }

  List<VerbFormCard> getVerbs() {

    List<VerbFormCard> cards = List();

    if (_verbs == null) return List();

    _verbs.forEach((card) {
      if (_searchPrefix == null || card.word.startsWith(_searchPrefix)) {
        cards.add(card);
      }
    });

//    if (_sortOrder == SortOrder.word) {
//      cards.sort(_orderByWord);
//    } else if (_sortOrder == SortOrder.type) {
//      cards.sort(_orderByType);
//    }

    return cards;
  }

  List<SentenceCard> getSentences() {
    List<SentenceCard> cards = List();

    if (_sentences == null) return List();

    _sentences.forEach((card) {
      if (_searchPrefix == null || card.question.startsWith(_searchPrefix)) {
        cards.add(card);
      }
    });

    return cards;
  }


  addWord(WordCard card) async {
    await _dao.setValue("words", card.word, {
      "type": _wordType(card.wordType),
      "value": card.value,
      "related": card.related
    });
  }

  addVerb(VerbFormCard card) async {
    await _dao.setValue("verbs", card.word, {
      "value": card.translation,
      "forms": card.pronouns
    });
  }

  addSentence(SentenceCard card) async {
    await _dao.setValue("sentences", card.question, {
      "translation": card.questionTranslation,
      "answer": card.answer,
      "answer_translation": card.answerTranslation
    });
  }

  String _wordType(WordType t) {
    switch (t) {
      case WordType.female: return "female";
      case WordType.male: return "male";
      case WordType.neutral: return "neutral";
      case WordType.plural: return "plural";
      default: return null;
    }
  }

  WordType _parseWordType(String t) {
    switch (t) {
      case "male": return WordType.male;
      case "female": return WordType.female;
      case "neutral": return WordType.neutral;
      case "plural": return WordType.plural;
      default: return WordType.unknown;
    }
  }

  VerbPronounForm _parsePronounForm(String pronoun) {
    switch (pronoun) {
      case "ich": return VerbPronounForm.ich;
      case "du": return VerbPronounForm.du;
      case "er": return VerbPronounForm.er;
      case "sie": return VerbPronounForm.sie;
      case "es": return VerbPronounForm.es;
      case "wir": return VerbPronounForm.wir;
      case "ihr": return VerbPronounForm.ihr;
      case "sie_plural": return VerbPronounForm.siePlural;
      case "Sie": return VerbPronounForm.Sie;
      default: return null;
    }
  }
}
