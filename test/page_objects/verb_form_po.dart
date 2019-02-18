import 'package:pageloader/pageloader.dart';

import 'dialog_header_po.dart';

part 'verb_form_po.g.dart';

@PageObject()
abstract class VerbFormPO {
  VerbFormPO();

  factory VerbFormPO.create(PageLoaderElement ctx) = $VerbFormPO.create;

  @ByTagName('edit-dialog-header')
  DialogHeaderPO get dialogHeader;

  @ById('verb')
  PageLoaderElement get verb;

  @ById('translation')
  PageLoaderElement get translation;

  @ById('ich')
  PageLoaderElement get ich;

  @ById('du')
  PageLoaderElement get du;

  @ById('er_sie_es')
  PageLoaderElement get erSieEs;

  @ById('wir')
  PageLoaderElement get wir;

  @ById('ihr')
  PageLoaderElement get ihr;

  @ById('siePlural')
  PageLoaderElement get siePlural;

  @ById('Sie')
  PageLoaderElement get Sie;
}