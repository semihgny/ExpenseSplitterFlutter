import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/providers/core_providers.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // Initialized in main.dart
});

class SettingsState {
  final ThemeMode themeMode;
  final String currency;
  final String language;

  SettingsState({
    this.themeMode = ThemeMode.system,
    this.currency = 'TL',
    this.language = 'Türkçe',
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    String? currency,
    String? language,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      currency: currency ?? this.currency,
      language: language ?? this.language,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SettingsState &&
      other.themeMode == themeMode &&
      other.currency == currency &&
      other.language == language;
  }

  @override
  int get hashCode => themeMode.hashCode ^ currency.hashCode ^ language.hashCode;
}

class SettingsController extends Notifier<SettingsState> {
  static const _themeKey = 'theme_mode';
  static const _currencyKey = 'currency';
  static const _languageKey = 'language';

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  SettingsState build() {
    final themeStr = _prefs.getString(_themeKey);
    final currency = _prefs.getString(_currencyKey) ?? 'TL';
    final language = _prefs.getString(_languageKey) ?? 'Türkçe';

    ThemeMode themeMode = ThemeMode.system;
    if (themeStr == 'dark') themeMode = ThemeMode.dark;
    if (themeStr == 'light') themeMode = ThemeMode.light;

    return SettingsState(
      themeMode: themeMode,
      currency: currency,
      language: language,
    );
  }

  void setThemeMode(ThemeMode mode) {
    String modeStr = 'system';
    if (mode == ThemeMode.dark) modeStr = 'dark';
    if (mode == ThemeMode.light) modeStr = 'light';
    
    _prefs.setString(_themeKey, modeStr);
    state = state.copyWith(themeMode: mode);
  }

  void setCurrency(String currency) {
    _prefs.setString(_currencyKey, currency);
    state = state.copyWith(currency: currency);
  }

  void setLanguage(String language) {
    _prefs.setString(_languageKey, language);
    state = state.copyWith(language: language);
  }

  Future<void> clearAllData() async {
    final db = ref.read(databaseProvider);
    await db.transaction(() async {
      await db.delete(db.groupsTable).go();
    });
  }
}

final settingsControllerProvider = NotifierProvider<SettingsController, SettingsState>(
  SettingsController.new,
);
