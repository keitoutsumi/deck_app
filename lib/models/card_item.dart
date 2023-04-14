class CardItem {
  final String id;
  final String content;
  final String? imagePath;

  CardItem({required this.id, required this.content, this.imagePath});

  CardItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        imagePath = json['imagePath'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'imagePath': imagePath,
      };
}
