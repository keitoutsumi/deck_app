import 'package:flutter/material.dart';
import 'package:deck_app/models/deck.dart';
import 'package:deck_app/models/card_item.dart';

class DeckViewScreen extends StatefulWidget {
  final Deck deck;

  DeckViewScreen({required this.deck});

  @override
  _DeckViewScreenState createState() => _DeckViewScreenState();
}

class _DeckViewScreenState extends State<DeckViewScreen> {
  late List<CardItem> _cards;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _cards = widget.deck.cards;
  }

  void _shuffle() {
    setState(() {
      _cards.shuffle();
      _currentIndex = 0;
    });
  }

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _cards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deck.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_cards.isNotEmpty)
            GestureDetector(
              onTap: _nextCard,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(_cards[_currentIndex].title,
                        style: TextStyle(fontSize: 24)),
                    SizedBox(height: 10),
                    Text(_cards[_currentIndex].content,
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    if (_cards[_currentIndex].imagePath.isNotEmpty)
                      Image.file(File(_cards[_currentIndex].imagePath)),
                  ],
                ),
              ),
            ),
          if (_cards.isEmpty) Center(child: Text('No cards in this deck.')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shuffle),
        onPressed: _shuffle,
      ),
    );
  }
}
