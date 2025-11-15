import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const _keyIsDark = 'theme_is_dark';
  static const _keyFontSize = 'theme_font_index';

  bool _isDark = false;
  int _fontIndex = 1; // 0 small, 1 medium, 2 large

  bool get isDark => _isDark;
  int get fontIndex => _fontIndex;

  double get fontScale {
    switch (_fontIndex) {
      case 0:
        return 0.9;
      case 2:
        return 1.2;
      default:
        return 1.0;
    }
  }

  ThemeProvider() {
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_keyIsDark) ?? false;
    _fontIndex = prefs.getInt(_keyFontSize) ?? 1;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _isDark = isDark;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsDark, _isDark);
  }

  Future<void> setFontIndex(int idx) async {
    _fontIndex = idx;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyFontSize, _fontIndex);
  }
}
