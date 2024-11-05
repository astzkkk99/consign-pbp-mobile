import 'package:consign_pbp/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.lightBlue,
        ).copyWith(secondary: Colors.lightBlue[50]),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
