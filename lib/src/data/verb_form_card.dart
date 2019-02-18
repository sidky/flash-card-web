enum VerbPronounForm {
  ich, du, er, sie, es, wir, ihr, siePlural, Sie
}

class VerbFormCard {
  final String word;
  final String translation;
  final Map<VerbPronounForm, String> forms;

  const VerbFormCard(this.word, this.translation, this.forms);

  Map<String, String> get pronouns {
    Map<String, String> ret = Map();

    forms.forEach((pronoun, word) {
      ret[_getPronounName(pronoun)] = word;
    });

    return ret;
  }

  String _getPronounName(VerbPronounForm pronoun) {
    switch (pronoun) {
      case VerbPronounForm.ich: return "ich";
      case VerbPronounForm.du: return "du";
      case VerbPronounForm.er: return "er";
      case VerbPronounForm.sie: return "sie";
      case VerbPronounForm.es: return "es";
      case VerbPronounForm.wir: return "wir";
      case VerbPronounForm.ihr: return "ihr";
      case VerbPronounForm.siePlural: return "sie_plural";
      case VerbPronounForm.Sie: return "Sie";
    }
    return null;
  }

  @override
  String toString() {
    return 'VerbFormCard{word: $word, translation: $translation, forms: $forms}';
  }
}