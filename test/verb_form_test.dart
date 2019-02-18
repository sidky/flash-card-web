import 'package:angular/angular.dart';
import 'package:angular_test/angular_test.dart';
import 'package:flash_card_web/src/data/firebase_dao.dart';
import 'package:flash_card_web/src/service/flash_card_service.dart';
import 'package:flash_card_web/src/verb_form_card/verb_form_component.dart';
import 'package:flash_card_web/src/verb_form_card/verb_form_component.template.dart' as ng;
import 'package:pageloader/html.dart';
import 'package:test/test.dart';

import 'fake_firebase_dao.dart';
import 'page_objects/verb_form_po.dart';
import 'package:mockito/mockito.dart';

import 'verb_form_test.template.dart' as self;

@GenerateInjector([
  ClassProvider(FirebaseDAO, useClass: MockFirebaseDAO),
  ClassProvider(FlashCardService)
])
final InjectorFactory rootInjector = self.rootInjector$Injector;

void main() {
  final testBed = NgTestBed.forComponent<VerbFormComponent>(
      ng.VerbFormComponentNgFactory).addInjector(rootInjector);
  NgTestFixture<VerbFormComponent> fixture;

  VerbFormPO po;

  setUp(() async {
    fixture = await testBed.create();
    final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
    po = VerbFormPO.create(context);
  });

  tearDown(disposeAnyRunningTest);

  test('New card', () async {
    await fixture.update((c) => c.verbForm = null);

    await po.verb.type("some word");
    await po.translation.type("meaning");
    await po.ihr.type("ihr form");
    await po.ich.type("ich form");
    await po.du.type("du form");
    await po.erSieEs.type("er/sie/es form");
    await po.wir.type("wir form");
    await po.siePlural.type("sie plural form");
    await po.Sie.type("Sie form");

    await po.dialogHeader.save();

    var mockDAO = MockFirebaseDAO();

    var expected = {
      'value': 'meaning'
    };

    verify(mockDAO.setValue("verbs", "some word", expected)).called(1);
  });
}