import 'package:flutter/material.dart';
import 'package:deck_app/models/deck.dart';
import 'package:deck_app/screens/card_edit_screen.dart';
import 'package:deck_app/services/storage.dart';

class DeckEditScreen extends StatefulWidget {
  final Deck? deck;

  DeckEditScreen({this.deck});

  @override
  _DeckEditScreenState createState() => _DeckEditScreenState();
}

class _DeckEditScreenState extends State<DeckEditScreen> {
  late TextEditingController _titleController;
  late Deck _deck;

  @override
  void initState() {
    super.initState();
    _deck = widget.deck ?? Deck(id: -1, title: '', cards: []);
    _titleController = TextEditingController(text: _deck.title);
  }

  void _saveDeck() async {
    _deck =
        Deck(id: _deck.id, title: _titleController.text, cards: _deck.cards);
    if (_deck.id == -1) {
      await Storage.insertDeck(_deck);
    } else {
      await Storage.updateDeck(_deck);
    }
    Navigator.pop(context);
  }

  void _deleteDeck() async {
    await Storage.deleteDeck(_deck.id);
    Navigator.pop(context);
  }

  void _editCard(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardEditScreen(card: _deck.cards[index]),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          _deck.cards[index] = value;
        });
      }
    });
  }

  void _addCard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardEditScreen(),
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          _deck.cards.add(value);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck Edit'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Deck Title'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _deck.cards.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_deck.cards[index].title),
                  leading: _deck.cards[index].imagePath.isNotEmpty
                      ? Image.file(File(_deck.cards[index].imagePath))
                      : null,
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editCard(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'deleteDeck',
            child: Icon(Icons.delete),
            onPressed: _deleteDeck,
            backgroundColor: Colors.red,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'addCard',
            child: Icon(Icons.add),
            onPressed: _addCard,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _saveDeck,
              icon: Icon(Icons.save),
              label: Text('Save Deck'),
            ),
          ],
        ),
      ),
    );
  }
}
