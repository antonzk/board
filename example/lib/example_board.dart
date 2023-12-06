import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:example/board_card.dart';
import 'package:example/board_list.dart';
import 'package:example/board_model.dart';
import 'package:flutter/material.dart';

class ExampleBoard extends StatefulWidget {
  const ExampleBoard({super.key});

  @override
  State<ExampleBoard> createState() => _ExampleBoardState();
}

class _ExampleBoardState extends State<ExampleBoard> {
  final List<BoardListModel> _listData = [
    BoardListModel(count: 11, name: 'TODO', items: [
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
    ]),
    BoardListModel(count: 4, name: 'IN PROGRESS', items: [
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
    ]),
    BoardListModel(count: 6, name: 'REVIEW', items: [
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
    ]),
    BoardListModel(count: 1, name: 'DONE', items: [
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
      BoardItemModel.stub(),
    ]),
  ];

  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = BoardViewController();

  void _handleDropList(int? listIndex, int? oldListIndex) {
    //Update our local list data
    var list = _listData[oldListIndex!];
    _listData.removeAt(oldListIndex);
    _listData.insert(listIndex!, list);
  }

  void _handleCardTap() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Item tap')));
  }

  @override
  Widget build(BuildContext context) {
    List<BoardList> lists = [];
    for (int i = 0; i < _listData.length; i++) {
      lists.add(_createBoardList(_listData[i]) as BoardList);
    }
    return BoardView(
      lists: lists,
      boardViewController: boardViewController,
    );
  }

  Widget buildBoardItem(BoardItemModel itemObject) {
    return BoardItem(
        draggable: true,
        onStartDragItem:
            (int? listIndex, int? itemIndex, BoardItemState? state) {},
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
            int? oldItemIndex, BoardItemState? state) {
          //Used to update our local item data
          var item = _listData[oldListIndex!].items[oldItemIndex!];
          _listData[oldListIndex].items.removeAt(oldItemIndex);
          _listData[listIndex!].items.insert(itemIndex!, item);
        },
        onTapItem:
            (int? listIndex, int? itemIndex, BoardItemState? state) async {},
        item: BoardCard(item: itemObject, onTap: _handleCardTap));
  }

  Widget _createBoardList(BoardListModel list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items.length; i++) {
      items.insert(i, buildBoardItem(list.items[i]) as BoardItem);
    }

    return BoardList(
      draggable: true,
      onDropList: _handleDropList,
      header: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Badge(
                offset: const Offset(12, -4),
                label: Text("${list.count}"),
                child: Text(list.name,
                    style: const TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
      ],
      items: items,
    );
  }
}
