import 'package:deck_app/models/card_item.dart';

class Deck {
  final String id;
  final String title;
  final List<CardItem> cards;

  Deck({required this.id, required this.title, required this.cards});

  Deck.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        cards = List<CardItem>.from(
            json['cards'].map((cardJson) => CardItem.fromJson(cardJson)));

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'cards': cards.map((card) => card.toJson()).toList(),
      };
}
