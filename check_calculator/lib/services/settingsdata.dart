import 'package:flutter/material.dart';
import 'package:check_calculator/services/preset.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsData extends ChangeNotifier {
  bool _isDarkModeEnabled = false;
  bool _tipAsPercentage = false;
  double _defaultVat = 0;
  double _defaultService = 0;
  double _defaultTip = 0;
  List<Preset> _savedPresets = [];

  bool get isDarkModeEnabled => _isDarkModeEnabled;
  bool get tipAsPercentage => _tipAsPercentage;
  double get defaultVat => _defaultVat;
  double get defaultService => _defaultService;
  double get defaultTip => _defaultTip;
  List<Preset> get savedPresets => _savedPresets;

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkModeEnabled = prefs.getBool('isDarkModeEnabled') ?? false;
    _tipAsPercentage = prefs.getBool('tipAsPercentage') ?? false;
    _defaultVat = prefs.getDouble('defaultVat') ?? 0;
    _defaultService = prefs.getDouble('defaultService') ?? 0;
    _defaultTip = prefs.getDouble('defaultTip') ?? 0;
    List<String>? presetStrings = prefs.getStringList('savedPresets');
    _savedPresets = presetStrings
            ?.map((preset) => Preset.fromJson(preset))
            .toList()
            .cast<Preset>() ??
        [];
    notifyListeners();
  }

  Future<void> updateValue<T>(T value, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (key) {
      case 'isDarkModeEnabled':
        _isDarkModeEnabled = value as bool;
        prefs.setBool('isDarkModeEnabled', value);
        break;
      case 'tipAsPercentage':
        _tipAsPercentage = value as bool;
        prefs.setBool('tipAsPercentage', value);
        break;
      case 'defaultVat':
        _defaultVat = value as double;
        prefs.setDouble('defaultVat', value);
        break;
      case 'defaultService':
        _defaultService = value as double;
        prefs.setDouble('defaultService', value);
        break;
      case 'defaultTip':
        _defaultTip = value as double;
        prefs.setDouble('defaultTip', value);
        break;
      case 'savedPresets':
        _savedPresets = value as List<Preset>;
        prefs.setStringList(
            'savedPresets', _savedPresets.map((preset) => preset.toJson()) as List<String>);
        break;
    }
    notifyListeners();
  }
}
