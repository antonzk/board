import 'package:example/board_model.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BoardListModel {
  int count;
  List<BoardItemModel> items;
  String name;
  PagingController<int, BoardItem>? pagingController;

  BoardListModel({required this.count, required this.name, required this.items, this.pagingController});
}
