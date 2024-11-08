import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widget/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 60, 183, 228));

var kDarkColorScheme = 
    ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Color.fromARGB(255, 255, 214, 90));

void main() {
  runApp(MaterialApp(
    themeMode: ThemeMode.system,
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kDarkColorScheme,
    ),
    theme: ThemeData(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.secondaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primary,
                foregroundColor: kColorScheme.onPrimary)),
        textTheme: ThemeData().textTheme.copyWith(
                titleLarge: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ))),
    home: const Expenses(),
  ));
}
