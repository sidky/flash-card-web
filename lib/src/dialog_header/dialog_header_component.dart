
import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/material_input/material_input.dart';

typedef void EditDialogFunction();

@Component(
  selector: 'edit-dialog-header',
  templateUrl: 'dialog_header_component.html',
  directives: [
    MaterialInputComponent,
    materialInputDirectives,
    materialProviders,
    MaterialButtonComponent,
    materialInputDirectives,
    materialProviders,
  ]
)
class DialogHeaderComponent {

  final _onSave = StreamController<bool>.broadcast(sync: true);
  final _onCancel = StreamController<bool>.broadcast(sync: true);
  final _onReset = StreamController<bool>.broadcast(sync: true);

  @Output()
  Stream<void> get onSave => _onSave.stream;

  @Output()
  Stream<void> get onCancel => _onCancel.stream;

  @Output()
  Stream<void> get onReset => _onReset.stream;

  void onSaveClicked() {
    _onSave.add(true);
  }

  void onCancelClicked() {
    _onCancel.add(true);
  }

  void onResetClicked() {
    _onReset.add(true);
  }
}
