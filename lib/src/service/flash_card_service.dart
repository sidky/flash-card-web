import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart';
import 'package:flash_card_web/src/data/word_card.dart';
import 'package:flash_card_web/secret.dart';

@Injectable()
class FlashCardService {
  Database _db;

  List<WordCard> _words;

  FlashCardService() {

    var app = initializeApp(
        apiKey: firebaseApiKey,
        authDomain: authDomain,
        databaseURL: databaseURL,
        projectId: projectId,
        storageBucket: storageBucketId,
        messagingSenderId: messagingSenderId
    );
    print(app);
    _db = database(app);

    refWords.onValue.listen((e) {
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
  }

  DatabaseReference get refWords => _db.ref("words");

  List<WordCard> getWords() => _words;

  addWord(WordCard card) async {
    await refWords.child(card.word).set({
      "type": _wordType(card.wordType),
      "value": card.value,
      "related": card.related
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
}