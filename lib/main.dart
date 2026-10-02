import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '買い物リスト',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const ShoppingListPage(),
    );
  }
}

/// 買い物リストの1項目
class ShoppingItem {
  ShoppingItem(this.name);

  final String name;
  bool isDone = false;
}

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  // アプリ起動中だけ保持するデータ
  final List<ShoppingItem> _items = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addItem() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    setState(() {
      _items.add(ShoppingItem(name));
    });
    _controller.clear();
  }

  void _toggleItem(int index, bool? value) {
    setState(() {
      _items[index].isDone = value ?? false;
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('買い物リスト'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '買うものを入力',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addItem,
                  child: const Text('追加'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  leading: Checkbox(
                    value: item.isDone,
                    onChanged: (value) => _toggleItem(index, value),
                  ),
                  title: Text(
                    item.name,
                    style: TextStyle(
                      decoration:
                          item.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: '削除',
                    onPressed: () => _deleteItem(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
