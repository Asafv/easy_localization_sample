import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_sample/language_picker.dart';
import 'package:get/get.dart';

import 'locales/app_locales.dart';
import 'locales/locale_controller.dart';

/// 1. Wrap you app with EasyLocalization Widget.
void main() {
  runApp(
    EasyLocalization(
      path: AppLocales.localesPath,
      supportedLocales: AppLocales.supportedLocales,
      fallbackLocale: AppLocales.fallbackLocale,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    /// I use this as a Dependency Injection to notify on locale changes
    Get.put(LocaleController());
  }

  @override
  Widget build(BuildContext context) {
    /// 2. Add the relevant localization support to the MaterialApp
    /// XXX GetMaterialApp uses the same params as MaterialApp.
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  bool _isMale = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Flutter Localization Sample",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'You can change localization using this dropDown menu.',
              ),
            ),
            LanguagePicker(width: Get.width * 0.6),
            StreamBuilder<bool>(
              stream: Get.find<LocaleController>().localeChangedStream,
              builder: (context, snapshot) {
                return _translationTexts(context);
              },
            )
          ],
        ),
      ),
    );
  }

  /// 3. All you need to do is use:
  /// Text(tr(KEY))
  /// or
  /// Text(KEY).tr()
  /// or
  /// Text(plural(KEY, NUMBER))
  Expanded _translationTexts(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'current Locale: ${EasyLocalization.of(context).locale}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Text(tr('helloWorld')),
          Text(tr('save')),
          Text(tr('start')),
          Text(tr('back')),
          Text(
            tr('args'),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.yellow,
                fontSize: 20),
          ),
          Text(
            tr('money', args: ['200']),
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
          Text(
            tr(
              'moneyCurrency',
              args: ['400'],
              namedArgs: {'currency': '\$'},
            ),
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),

          /// Nested translations
          Text(
            'gender',
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ).tr(
            gender: _isMale ? 'male' : 'female',
            args: ['alien'],
          ),

          /// Plurals support is important!
          /// change values: [0, 1, >1, >1000 + format]
          Text(
            plural(
              'moneyPlural',
              2000,
              format: NumberFormat.compact(locale: context.locale.toString()),
            ),
            style: TextStyle(color: Colors.blue, fontSize: 18),
          )
        ],
      ),
    );
  }
}
