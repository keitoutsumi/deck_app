import 'package:deck_app/models/card_item.dart';

class Deck {
  final int id;
  final String title;
  final List<CardItem> cards;

  Deck({required this.id, required this.title, required this.cards});
}
