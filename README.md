[![pub package](https://img.shields.io/pub/v/boardview.svg)](https://pub.dev/packages/boardview)

# Flutter_boardview
Introducing a powerful custom widget that crafts draggable Boards reminiscent of Trello or Jira interfaces. This versatile kanban-style view empowers users to effortlessly reorder and manage items via intuitive drag-and-drop functionality. Create, rearrange, and customize columns, offering a dynamic and flexible dashboard experience within your app.

# Source project

``https://pub.dev/packages/boardview``

## Installation
Just add ``` flutter_boardview ``` to the ``` pubspec.yaml ``` file.

## Usage Example

To get started you can look inside the ``` /example``` folder. This package is divided into three core parts.

### Simple dashboard

![Example](https://github.com/antonzk/board/blob/master/example.gif?raw=true)

### Infinite scroll columns

In example, we use ```https://pub.dev/packages/infinite_scroll_pagination``` for infinite scrolling list

![Example](https://github.com/antonzk/board/blob/master/infinite_scrolling.gif?raw=true)

### BoardView

The BoardView class takes in a List of BoardLists. It can also take in a BoardViewController which is can be used to animate to positions in the BoardView

``` dart

BoardViewController boardViewController = BoardViewController();

List<BoardList> _lists = List<BoardList>();

BoardView(
  lists: _lists,
  boardViewController: boardViewController,
);

```

### BoardList

The BoardList has several callback methods for when it is being dragged. The header item is a Row and expects a List<Widget> as its object. The header item on long press will begin the drag process for the BoardList.

``` dart

    BoardList(
      onStartDragList: (int? listIndex) {
    
      },
      onTapList: (int? listIndex) async {
    
      },
      onDropList: (int? listIndex, int? oldListIndex) {       
       
      },
      headerBackgroundColor: Color.fromARGB(255, 235, 236, 240),
      backgroundColor: Color.fromARGB(255, 235, 236, 240),
      header: [
        Expanded(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "List Item",
                  style: TextStyle(fontSize: 20),
                ))),
      ],
      items: items,
    );

```

### BoardItem

The BoardItem view has several callback methods that get called when dragging. A long press on the item field widget will begin the drag process.

``` dart

    BoardItem(
        onStartDragItem: (int? listIndex, int? itemIndex, BoardItemState state) {
        
        },
        onDropItem: (int? listIndex, int? itemIndex, int oldListIndex,
            int oldItemIndex, BoardItemState state) {
                      
        },
        onTapItem: (int? listIndex, int? itemIndex, BoardItemState state) async {
        
        },
        item: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text("Board Item"),
          ),
        )
    );

```
