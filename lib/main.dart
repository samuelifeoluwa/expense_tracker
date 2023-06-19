import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

//light mode
var kColorscheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

//dark mode
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //dark mode
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDarkColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),

      //light mode
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorscheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kColorscheme.onPrimaryContainer,
          foregroundColor: kColorscheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorscheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorscheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorscheme.primaryContainer),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}
