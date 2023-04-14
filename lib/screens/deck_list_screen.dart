import 'package:flutter/material.dart';
import 'package:deck_app/models/deck.dart';
import 'package:deck_app/services/storage.dart';
import 'package:deck_app/screens/deck_edit_screen.dart';

class DeckListScreen extends StatefulWidget {
  @override
  _DeckListScreenState createState() => _DeckListScreenState();
}

class _DeckListScreenState extends State<DeckListScreen> {
  List<Deck> _decks = [];
  Storage _storage = Storage();

  @override
  void initState() {
    super.initState();
    _loadDecks();
  }

  void _loadDecks() async {
    List<Deck> decks = await _storage.readDecks();
    setState(() {
      _decks = decks;
    });
  }

  void _addDeck() {
    // 新しい山札を追加する処理を実装する
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decks'),
      ),
      body: ListView.builder(
        itemCount: _decks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_decks[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeckEditScreen(deck: _decks[index]),
                ),
              ).then((_) => _loadDecks());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDeck,
        child: Icon(Icons.add),
      ),
    );
  }
}
