@TestOn('browser')
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';
import 'package:flash_card_web/src/dialog_header/dialog_header_component.dart';
import 'package:flash_card_web/src/dialog_header/dialog_header_component.template.dart' as ng;

import 'package:pageloader/html.dart';

import 'page_objects/dialog_header_po.dart';

void main() {
  final testBed = NgTestBed.forComponent<DialogHeaderComponent>(ng.DialogHeaderComponentNgFactory);
  NgTestFixture<DialogHeaderComponent> fixture;

  DialogHeaderPO po;

  setUp(() async {
    fixture = await testBed.create();
    final context = HtmlPageLoaderElement.createFromElement(fixture.rootElement);
    po = DialogHeaderPO.create(context);
  });

  tearDown(disposeAnyRunningTest);

  test('Save button', () async {
    await po.save();
    await fixture.update((c) async => expect(await c.onSave.length, 1));
  });

  test('Cancel button', () async {
    await po.cancel();
    await fixture.update((c) async => expect(await c.onCancel.length, 1));
  });

  test('Reset button', () async {
    await po.reset();
    await fixture.update((c) async => expect(await c.onReset.length, 1));
  });}