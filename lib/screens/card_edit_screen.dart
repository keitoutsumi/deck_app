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
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.card?.title ?? '');
    _contentController =
        TextEditingController(text: widget.card?.content ?? '');
    _imagePath = widget.card?.imagePath ?? '';
  }

  void _saveCard() {
    CardItem updatedCard = CardItem(
      id: widget.card?.id ?? -1,
      title: _titleController.text,
      content: _contentController.text,
      imagePath: _imagePath,
    );
    Navigator.pop(context, updatedCard);
  }

  void _selectImage(String imagePath) {
    setState(() {
      _imagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Edit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Card Title'),
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Card Content'),
                minLines: 3,
                maxLines: 5,
              ),
              ImageSelector(
                onImageSelected: _selectImage,
                imagePath: _imagePath,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _saveCard,
              icon: Icon(Icons.save),
              label: Text('Save Card'),
            ),
          ],
        ),
      ),
    );
  }
}
