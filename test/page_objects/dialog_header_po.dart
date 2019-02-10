import 'package:pageloader/pageloader.dart';

part 'dialog_header_po.g.dart';

@PageObject()
abstract class DialogHeaderPO {

  DialogHeaderPO();

  factory DialogHeaderPO.create(PageLoaderElement ctx) = $DialogHeaderPO.create;

  @ById('save-button')
  PageLoaderElement get _saveButton;

  @ById('cancel-button')
  PageLoaderElement get _cancelButton;

  @ById('reset-button')
  PageLoaderElement get _resetButton;

  Future<void> save() async => _saveButton.click();
  Future<void> cancel() async => _cancelButton.click();
  Future<void> reset() async => _cancelButton.click();
}