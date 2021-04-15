import 'dart:ui';

import 'package:flutter/material.dart';

import 'UI/Player/PlayerPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.dark(),
          primarySwatch: Colors.blue,
          accentColor: const Color(0xFF79FFFF),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme()),
      home: PlayerPage(),
    );
  }
}
// 0xFFDD001E
// 0xFF79FFFF