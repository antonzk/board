import 'package:example/board_card.dart';
import 'package:example/board_list.dart';
import 'package:example/board_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginationScrollBoard extends StatefulWidget {
  const PaginationScrollBoard({super.key});

  @override
  State<PaginationScrollBoard> createState() => _PaginationScrollBoardState();
}

class _PaginationScrollBoardState extends State<PaginationScrollBoard> {
  final int _firstPage = 0;

  final _newPage = [
    BoardItemModel.stub(),
    BoardItemModel.stub(),
    BoardItemModel.stub(),
    BoardItemModel.stub(),
    BoardItemModel.stub(),
    BoardItemModel.stub(),
    BoardItemModel.stub(),
    BoardItemModel.stub(),
    BoardItemModel.stub(),
    BoardItemModel.stub(),
  ];

  final List<BoardListModel> _listData = [
    BoardListModel(count: 0, name: 'STATUS 1', items: [], pagingController: PagingController(firstPageKey: 0)),
    BoardListModel(count: 0, name: 'STATUS 2', items: [], pagingController: PagingController(firstPageKey: 0)),
  ];

  //Can be used to animate to different sections of the BoardView
  BoardViewController boardViewController = BoardViewController();

  @override
  void initState() {
    _listData.asMap().forEach((listIndex, list) {
      // init page controller for list
      list.pagingController!.addPageRequestListener((pageKey) {
        // if user wants to do swipe refresh - pageKey will be _firstPage
        if (pageKey == _firstPage) {
          // reset pageNumber and data - do refresh data
        }
        // fetch next part of data
        _fetchPage(pageKey, listIndex);
      });
      // list.pagingController!.appendPage([], 0);
    });
    super.initState();
  }

  @override
  void dispose() {
    // _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageNumber, int listIndex) async {
    // do request to get next page
    Future.delayed(const Duration(seconds: 2), () {
      List<BoardItem> items = [];
      for (int i = 0; i < _newPage.length; i++) {
        _listData[listIndex].items.add(_newPage[i]);
        setState(() {
          items.insert(i, buildBoardItem(_newPage[i]));
        });
      }
      _listData[listIndex].pagingController!.appendPage(items, pageNumber);
    });
  }

  void _handleDropList(int? listIndex, int? oldListIndex) {
    //Update our local list data
    var list = _listData[oldListIndex!];
    _listData.removeAt(oldListIndex);
    _listData.insert(listIndex!, list);
  }

  void _handleCardTap() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item tap')));
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

  BoardItem buildBoardItem(BoardItemModel itemObject) {
    return BoardItem(
        draggable: true,
        onStartDragItem: (int? listIndex, int? itemIndex, BoardItemState? state) {},
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex, int? oldItemIndex, BoardItemState? state) {
          //Used to update our local item data
          var item = _listData[oldListIndex!].items[oldItemIndex!];
          _listData[oldListIndex].items.removeAt(oldItemIndex);
          _listData[listIndex!].items.insert(itemIndex!, item);
        },
        onTapItem: (int? listIndex, int? itemIndex, BoardItemState? state) async {},
        item: BoardCard(item: itemObject, onTap: _handleCardTap));
  }

  Widget _createBoardList(BoardListModel list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items.length; i++) {
      items.insert(i, buildBoardItem(list.items[i]));
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
                child: Text(list.name, style: const TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
      ],
      items: items,
      listBuilder: (itemBuilder) {
        return PagedListView<int, BoardItem>.separated(
          pagingController: list.pagingController!,
          builderDelegate: PagedChildBuilderDelegate<BoardItem>(
            animateTransitions: true,
            itemBuilder: (ctx, item, index) => itemBuilder(ctx, index)!,
          ),
          separatorBuilder: (context, index) => const SizedBox(),
        );
      },
    );
  }
}
