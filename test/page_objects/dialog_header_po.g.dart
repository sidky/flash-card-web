// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog_header_po.dart';

// **************************************************************************
// PageObjectGenerator
// **************************************************************************

// ignore_for_file: private_collision_in_mixin_application
// ignore_for_file: unused_field, non_constant_identifier_names
// ignore_for_file: overridden_fields, annotate_overrides
class $DialogHeaderPO extends DialogHeaderPO with $$DialogHeaderPO {
  PageLoaderElement $__root__;
  $DialogHeaderPO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([]);
  }
  factory $DialogHeaderPO.lookup(PageLoaderSource source) =>
      throw "'lookup' constructor for class "
      "DialogHeaderPO is not generated and can only be used on Page Object "
      "classes that have @CheckTag annotation.";
  static String get tagName =>
      throw '"tagName" is not defined by Page Object "DialogHeaderPO". Requires @CheckTag annotation in order for "tagName" to be generated.';
  Future<void> save() {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('DialogHeaderPO', 'save');
    }
    final returnMe = super.save();
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('DialogHeaderPO', 'save');
    }
    return returnMe;
  }

  Future<void> cancel() {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('DialogHeaderPO', 'cancel');
    }
    final returnMe = super.cancel();
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('DialogHeaderPO', 'cancel');
    }
    return returnMe;
  }

  Future<void> reset() {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('DialogHeaderPO', 'reset');
    }
    final returnMe = super.reset();
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('DialogHeaderPO', 'reset');
    }
    return returnMe;
  }
}

class $$DialogHeaderPO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__; // ignore: unused_field
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get _saveButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('DialogHeaderPO', '_saveButton');
    }
    final element = $__root__.createElement(ById('save-button'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('DialogHeaderPO', '_saveButton');
    }
    return returnMe;
  }

  PageLoaderElement get _cancelButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('DialogHeaderPO', '_cancelButton');
    }
    final element = $__root__.createElement(ById('cancel-button'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('DialogHeaderPO', '_cancelButton');
    }
    return returnMe;
  }

  PageLoaderElement get _resetButton {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('DialogHeaderPO', '_resetButton');
    }
    final element = $__root__.createElement(ById('reset-button'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('DialogHeaderPO', '_resetButton');
    }
    return returnMe;
  }
}
