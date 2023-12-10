import 'package:example/example_board.dart';
import 'package:flutter/material.dart';

import 'pagination_scroll_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tab> tabs = [
    Tab("Board", const ExampleBoard(), const Icon(Icons.table_chart)),
    Tab("Pagination (infinite scroll)", const PaginationScrollBoard(), const Icon(Icons.list_alt_outlined)),
  ];

  int _selectedIndex = 0;
  late final List<Widget> _widgetOptions = tabs.map((Tab tab) => tab.widget).toList();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tabs[_selectedIndex].label)),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs
            .map((Tab tab) => BottomNavigationBarItem(
                  icon: tab.icon,
                  label: tab.label,
                ))
            .toList(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Tab {
  final String label;
  final Widget widget;
  final Widget icon;

  Tab(this.label, this.widget, this.icon);
}
