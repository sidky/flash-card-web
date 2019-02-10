import 'package:angular/angular.dart';
import 'package:flash_card_web/src/dialog_header/dialog_header_component.dart';

@Component(
  selector: 'verb-form-card',
  templateUrl: 'verb_form_component.html',
  directives: [
    DialogHeaderComponent,
  ]
)
class VerbFormComponent {
  String verb;
  String translation;
  String ichForm;
  String duForm;
  String erSieEsForm;
  String wirForm;
  String SieForm;

  saveWord() {

  }

  cancel() {

  }

  resetWord() {

  }
}