import 'package:flutter/material.dart';
import 'package:your_app_name/screens/deck_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deck App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeckListScreen(),
    );
  }
}
