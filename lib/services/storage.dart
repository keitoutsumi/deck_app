import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:deck_app/models/deck.dart';
import 'package:deck_app/models/card_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Storage {
  static const databaseName = 'deck_app.db';

  static Future<Database> get _database async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocDir.path, databaseName);
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE decks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE cards(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            deck_id INTEGER,
            title TEXT,
            content TEXT,
            image TEXT,
            FOREIGN KEY(deck_id) REFERENCES decks(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  static Future<List<Deck>> readData() async {
    final db = await _database;
    final decksMap = await db.query('decks');
    final decks = decksMap.map((e) => Deck.fromJson(e)).toList();

    for (final deck in decks) {
      final cardsMap =
          await db.query('cards', where: 'deck_id = ?', whereArgs: [deck.id]);
      deck.cards = cardsMap.map((e) => CardItem.fromJson(e)).toList();
    }

    return decks;
  }

  static Future<void> insertDeck(Deck deck) async {
    final db = await _database;
    deck.id = await db.insert('decks', deck.toJson());
  }

  static Future<void> updateDeck(Deck deck) async {
    final db = await _database;
    await db
        .update('decks', deck.toJson(), where: 'id = ?', whereArgs: [deck.id]);
  }

  static Future<void> deleteDeck(int id) async {
    final db = await _database;
    await db.delete('decks', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> insertCard(int deckId, CardItem card) async {
    final db = await _database;
    card.deckId = deckId;
    card.id = await db.insert('cards', card.toJson());
  }

  static Future<void> updateCard(int deckId, CardItem card) async {
    final db = await _database;
    card.deckId = deckId;
    await db
        .update('cards', card.toJson(), where: 'id = ?', whereArgs: [card.id]);
  }

  static Future<void> deleteCard(int deckId, int cardId) async {
    final db = await _database;
    await db.delete('cards',
        where: 'id = ? AND deck_id = ?', whereArgs: [cardId, deckId]);
  }
}
