import 'package:angular/angular.dart';
import 'package:flash_card_web/src/data/firebase_dao.dart';

import 'src/todo_list/todo_list_component.dart';
import 'src/word_card/word_card_component.dart';
import 'package:flash_card_web/src/service/flash_card_service.dart';
import 'package:flash_card_web/src/card_list/single_card_component.dart';
import 'package:flash_card_web/src/card_list/card_list_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [TodoListComponent, WordCardComponent, SingleCardComponent, CardListComponent],
  providers: [
    ClassProvider(FlashCardService),
    ClassProvider(FirebaseDAO)
  ]
)
class AppComponent {
  // Nothing here yet. All logic is in TodoListComponent.
}
