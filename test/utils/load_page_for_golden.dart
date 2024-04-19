import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:golden_poc/core/gen/l10n.dart';

/// A simple function that returns A MaterialApp which allows golden tests to use config same or similar to what's in the app.
/// This example uses the same ThemeData and Locales as the app.
/// It can also be easily modified to allow providing overrides/mocks for the page to stub them.
Widget loadPageForGolden({required Widget page, bool rtl = false}) {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    // locale: Locale(rtl ? 'pl' : 'en'),
    locale: Locale(rtl ? 'ar' : 'en'),
    home: page,
  );
}
