import 'dart:convert';
import 'package:deck_app/models/deck.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/decks.json');
  }

  Future<List<Deck>> readDecks() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();

      List<dynamic> jsonDecks = jsonDecode(contents);
      List<Deck> decks = jsonDecks.map((json) => Deck.fromJson(json)).toList();
      return decks;
    } catch (e) {
      return [];
    }
  }

  Future<File> writeDecks(List<Deck> decks) async {
    final file = await _localFile;
    List<dynamic> jsonDecks = decks.map((deck) => deck.toJson()).toList();
    return file.writeAsString(jsonEncode(jsonDecks));
  }
}
