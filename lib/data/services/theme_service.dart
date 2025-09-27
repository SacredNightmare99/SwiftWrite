import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ThemeService {
  final _box = Hive.box('settings');
  final _key = 'isDarkMode';

  ThemeMode get theme {
    if (!_box.containsKey(_key)) {
      return ThemeMode.system; // first launch
    }
    return _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  }

  bool _loadThemeFromBox() => _box.get(_key, defaultValue: false);

  void saveTheme(bool isDarkMode) => _box.put(_key, isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(
      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
    saveTheme(!Get.isDarkMode);
  }
}
