import 'package:flutter/material.dart';
import 'package:deck_app/models/deck.dart';
import 'package:deck_app/models/card_item.dart';
import 'package:deck_app/screens/card_edit_screen.dart';

class DeckEditScreen extends StatefulWidget {
  final Deck? deck;

  DeckEditScreen({this.deck});

  @override
  _DeckEditScreenState createState() => _DeckEditScreenState();
}

class _DeckEditScreenState extends State<DeckEditScreen> {
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.deck?.title ?? '');
  }

  void _addCard() {
    // 新しいカードを追加する処理を実装する
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Deck'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Deck Title',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.deck?.cards.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.deck!.cards[index].content),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CardEditScreen(card: widget.deck!.cards[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        child: Icon(Icons.add),
      ),
    );
  }
}
