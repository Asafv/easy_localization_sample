import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Locales class will be used to add new locales to application
///
/// for each Locale we add, make sure you create the following as well.
/// add ALocale object to supportedALocales
///
/// ALocale: English
///   * Locale('en') - added to supportedALocales
///   * english_flag.png - the file name of the locale/language flag 'getImagePath(FILE_NAME)'
///   * English - the name we would like to display to the user.
///
///   NOTE:
///     * en.json - we must add to assets/translations folder.
///     This JSON file will hold all the translations by key:value which will used across the app.
class AppLocales {
  static List<ALocale> supportedALocales = [
    ALocale(Locale('en'), getImagePath('english_flag.png'), 'English'),
    ALocale(Locale('es'), getImagePath('spanish_flag.png'), 'Spanish'),

    // TODO: uncomment this and you will see some errors
    ALocale(Locale('hi'), getImagePath('hindi_flag.png'), 'Hindi'),
    // ALocale(Locale('ru'), getImagePath('russian_flag.png'), 'Russian'),
    // ALocale(Locale('pt'), getImagePath('portuguese_flag.png'), 'Portuguese'),
    // ALocale(Locale('vi'), getImagePath('vietnamese_flag.png'), 'Vietnamese'),
    // ALocale(Locale('th'), getImagePath('thai_flag.png'), 'Thai'),
    // ALocale(Locale('ja'), getImagePath('japanese_flag.png'), 'Japanese'),
    // ALocale(Locale('id'), getImagePath('indonesian_flag.png'), 'Indonesian'),
    // ALocale(Locale('tr'), getImagePath('turkish_flag.png'), 'Turkish'),
  ];

  static String getImagePath(String fileName) => 'assets/flags/$fileName';

  static String get defaultLocale => 'English';

  static String get localesPath => 'assets/translations';

  static List<Locale> get supportedLocales =>
      supportedALocales.map((e) => e.locale).toList();

  static Locale get fallbackLocale => Locale('en');

  static Future<String> getLastLocaleString() async {
    switch (EasyLocalization.of(Get.context).locale.toLanguageTag()) {
      case 'es':
        return 'Spanish';

      case 'en':
        return 'English';
    }
    return 'English';
  }
}

class ALocale {
  final Locale locale;
  final String flagImagePath;
  final String localeName;

  ALocale(this.locale, this.flagImagePath, this.localeName);
}
