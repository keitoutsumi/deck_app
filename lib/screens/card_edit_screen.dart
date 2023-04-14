import 'package:flutter/material.dart';
import 'package:deck_app/models/card_item.dart';
import 'package:deck_app/widgets/image_selector.dart';

class CardEditScreen extends StatefulWidget {
  final CardItem? card;

  CardEditScreen({this.card});

  @override
  _CardEditScreenState createState() => _CardEditScreenState();
}

class _CardEditScreenState extends State<CardEditScreen> {
  late TextEditingController _contentController;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _contentController =
        TextEditingController(text: widget.card?.content ?? '');
    _imagePath = widget.card?.imagePath;
  }

  void _onImageSelected(String imagePath) {
    setState(() {
      _imagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Card'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _contentController,
            decoration: InputDecoration(
              labelText: 'Card Content',
            ),
          ),
          SizedBox(height: 16),
          ImageSelector(
            initialImage: _imagePath,
            onImageSelected: _onImageSelected,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // カードの変更を保存する処理を実装する
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
