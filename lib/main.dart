import 'package:example_package/example_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:golden_poc/core/gen/l10n.dart';
import 'package:golden_poc/pages/home_page.dart';

void main() {
  final round = ClassA().multiplyAndRoundAsFixed(a: 12.1, b: 2.321, fractionDigits: 5);
  final palindrome1 = ClassB().isStringPalindrome('word');
  final palindrome2 = ClassB().isStringPalindrome('radar');
  print('round: $round');
  print('palindrome1: $palindrome1');
  print('palindrome2: $palindrome2');
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      locale: const Locale('ar'),
      home: const HomePage(),
    );
  }
}
