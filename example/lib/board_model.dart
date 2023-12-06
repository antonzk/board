import 'dart:math';

class BoardItemModel {
  final int? id;
  final String title;
  final String subtitle;
  final String description;

  BoardItemModel(
      {this.id,
      required this.title,
      required this.subtitle,
      required this.description});

  static BoardItemModel stub() {
    return BoardItemModel(
        title: "Task #${Random().nextInt(100)}",
        subtitle: "Subtitle of task",
        description: "Description of task");
  }
}
