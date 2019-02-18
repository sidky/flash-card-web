import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart';

import 'package:flash_card_web/secret.dart';

@Injectable()
class FirebaseDAO {

  static FirebaseDAO _instance;

  Database _db;

  FirebaseDAO._internal() {
    var app = initializeApp(
        apiKey: firebaseApiKey,
        authDomain: authDomain,
        databaseURL: databaseURL,
        projectId: projectId,
        storageBucket: storageBucketId,
        messagingSenderId: messagingSenderId
    );
    _db = database(app);
  }

  factory FirebaseDAO() {
    if (_instance == null) {
      _instance = FirebaseDAO._internal();
    }
    return _instance;
  }

  Stream<QueryEvent> onValue(String root) => _db.ref(root).onValue;

  setValue(String root, String child, dynamic value) async => await _db.ref(root).child(child).set(value);
}