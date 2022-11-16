class Language {
  late final String name;
  final String languageCode;
  Language(this.name, this.languageCode);
  static List<Language> languageList() {
    return <Language>[
      Language("English", "en"),
      Language("Romania","ro"),
    ];
  }
  // int get hashCode => languageCode.hashCode;
  // bool operator==(Object other) => other is Language && other.languageCode == languageCode;
}
Language language = Language("English","en");