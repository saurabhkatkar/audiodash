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
          scaffoldBackgroundColor: const Color(0xFF424242),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme()),
      home: PlayerPage(),
    );
  }
}
