import 'dart:async';

import 'package:firebase/src/database.dart';
import 'package:mockito/mockito.dart';
import 'package:flash_card_web/src/data/firebase_dao.dart';

//class SetValue {
//  final String root;
//  final String child;
//  final dynamic value;
//
//  const SetValue(this.root, this.child, this.value);
//}
//
//class FakeFirebaseDAO implements FirebaseDAO {
//
//  final List<SetValue> _setValues = List();
//
//  FakeFirebaseDAO();
//
//  @override
//  Stream<QueryEvent> onValue(String root) {
//    // TODO: implement onValue
//    return null;
//  }
//
//  @override
//  setValue(String root, String child, value) =>
//      _setValues.add(SetValue(root, child, value));
//}
class MockFirebaseDAO extends Mock implements FirebaseDAO {
  StreamController<QueryEvent> _stream = StreamController<QueryEvent>.broadcast();

  static MockFirebaseDAO _instance;
  MockFirebaseDAO._internal() {
    when(this.onValue(any)).thenAnswer((_O) => _stream.stream);
  }

  factory MockFirebaseDAO() {
    if (_instance == null) {
      _instance = MockFirebaseDAO._internal();
    }
    return _instance;
  }
}