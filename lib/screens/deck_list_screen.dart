import 'package:flutter/material.dart';
import 'package:deck_app/models/deck.dart';
import 'package:deck_app/screens/deck_view_screen.dart';
import 'package:deck_app/screens/deck_edit_screen.dart';
import 'package:deck_app/services/storage.dart';

class DeckListScreen extends StatefulWidget {
  @override
  _DeckListScreenState createState() => _DeckListScreenState();
}

class _DeckListScreenState extends State<DeckListScreen> {
  late List<Deck> _decks;

  @override
  void initState() {
    super.initState();
    _loadDecks();
  }

  void _loadDecks() async {
    _decks = await Storage.loadDecks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck List'),
      ),
      body: ListView.builder(
        itemCount: _decks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_decks[index].title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DeckViewScreen(deck: _decks[index]),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DeckEditScreen(deck: _decks[index]),
                      ),
                    ).then((value) => _loadDecks());
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeckEditScreen(),
            ),
          ).then((value) => _loadDecks());
        },
      ),
    );
  }
}
