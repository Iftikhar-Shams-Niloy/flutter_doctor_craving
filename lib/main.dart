import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorSchemeLight = ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent, brightness: Brightness.light);
final colorSchemeDark = ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent, brightness: Brightness.dark);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: colorSchemeLight),
      darkTheme: ThemeData.dark().copyWith(colorScheme: colorSchemeDark),
      home: //TO DO,
    );
  }
}
