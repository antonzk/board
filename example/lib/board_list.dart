
import 'package:example/board_model.dart';

class BoardListModel {
  int count;
  List<BoardItemModel> items;
  String name;

  BoardListModel({ required this.count, required this.name, required this.items});
}
