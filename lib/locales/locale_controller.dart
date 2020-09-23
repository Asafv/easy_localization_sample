import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  StreamController<bool> _localeChangedStreamController =
      StreamController.broadcast();

  Stream<bool> get localeChangedStream => _localeChangedStreamController.stream;

  RxBool isLanguagePickerOpen = false.obs;

  updateLocale(String selectedLocale) {
    debugPrint("updateLocale: $selectedLocale");

    Future.delayed(Duration(milliseconds: 200),
        () => _localeChangedStreamController.add(true));
  }

  setIsLanguagePickerOpen(bool isOpen) {
    debugPrint('setIsLanguagePickerOpen: $isOpen');
    isLanguagePickerOpen.value = isOpen;
  }

  @override
  void onClose() {
    _localeChangedStreamController.close();
    super.onClose();
  }
}
