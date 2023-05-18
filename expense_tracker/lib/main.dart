import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

final kColorSchema = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 172, 122, 219),
);

final kDarkColorSchema = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 62, 119, 84),
  brightness: Brightness.dark,
);
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((value) => startApp());
  startApp();
}

void startApp() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorSchema,
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: kDarkColorSchema.secondaryContainer,
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorSchema,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorSchema.onPrimaryContainer,
          foregroundColor: kColorSchema.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: kColorSchema.secondaryContainer,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                color: kColorSchema.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
      ),
      home: const Expenses(),
    ),
  );
}
