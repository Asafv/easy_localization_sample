import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'locales/app_locales.dart';
import 'locales/locale_controller.dart';

class LanguagePicker extends StatefulWidget {
  final double width;

  LanguagePicker({Key key, @required this.width}) : super(key: key);

  @override
  _LanguagePickerState createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  String _dropdownValue = AppLocales.defaultLocale;
  final _localeController = Get.find<LocaleController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    AppLocales.getLastLocaleString()
        .then((value) => setState(() => _dropdownValue = value));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.white,
              blurRadius: 0.2,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: DropdownButton<String>(
          value: _dropdownValue,
          icon: Icon(
            Icons.arrow_drop_down,
            size: 38,
            color: Colors.black,
          ),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          underline: Container(),
          onTap: () {
            debugPrint("dropdown onTap");
            _localeController.setIsLanguagePickerOpen(true);
          },
          isExpanded: true,
          onChanged: (String newValue) => _onLocaleChanged(newValue, context),
          items: AppLocales.supportedALocales
              .map<DropdownMenuItem<String>>(
                  (ALocale aLocale) => _dropdownLanguageItem(aLocale))
              .toList(),
        ),
      ),
    );
  }

  DropdownMenuItem<String> _dropdownLanguageItem(ALocale aLocale) {
    return DropdownMenuItem<String>(
      value: aLocale.localeName,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, right: 20),
            child: Image(
              image: AssetImage(aLocale.flagImagePath),
              height: 30,
              width: 50,
            ),
          ),
          Text(
            aLocale.localeName,
            style: TextStyle(
              fontSize: 18,
              // fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _onLocaleChanged(String newValue, BuildContext context) {
    debugPrint("_onLocaleChanged, newLocale: $newValue");

    var newLocale;
    if (newValue == "Spanish") {
      newLocale = Locale('es');
    } else {
      newLocale = Locale('en');
    }

    setState(() {
      _dropdownValue = newValue;
      EasyLocalization.of(context).locale = newLocale;
      _localeController.setIsLanguagePickerOpen(false);
      _localeController.updateLocale(_dropdownValue);
    });
  }
}
