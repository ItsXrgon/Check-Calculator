import 'package:check_calculator/Pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:check_calculator/services/settingsdata.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Check Calculator',
      home: HomeScreen(),
    );
  }
}

