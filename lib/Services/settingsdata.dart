import 'package:flutter/material.dart';

class SettingsData extends ChangeNotifier {
  bool _isDarkModeEnabled = false;
  double _defaultVat = 0;
  double _defaultService = 0;
  double _defaultTip = 0;

  bool get isDarkModeEnabled => _isDarkModeEnabled;
  double get defaultVat => _defaultVat;
  double get defaultService => _defaultService;
  double get defaultTip => _defaultTip;

  void updateValue<T>(T value, String key) {
    if (T == bool) {
      _isDarkModeEnabled = value as bool;
    } else if (T == double && key == 'defaultVat') {
      _defaultVat = value as double;
    } else if (T == double && key == 'defaultService') {
      _defaultService = value as double;
    } else if (T == double && key == 'defaultTip') {
      _defaultTip = value as double;
    }
    notifyListeners();
  }
}