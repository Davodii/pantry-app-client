import 'package:flutter/material.dart';
import 'package:pantry_app/data/models/pantry_item.dart';
import 'package:pantry_app/features/pantry/widgets/pantry_item_card.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => PantryScreenState();
}

class PantryScreenState extends State<PantryScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<PantryItem> _allItems = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void refresh() {
    _loadItems();
  }

  void _loadItems() {
    setState(() {
      // _allItems = _repo.getItems();
    });
  }

  void _deleteItem(int id) async {
    // await _repo.removeItem(id);
    // _loadItems();
  }

  List<PantryItem> get _filteredItems {
    if (_searchQuery.isEmpty) return _allItems;
    return _allItems
        .where(
          (item) =>
              item.name.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantry')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Theme.of(context).colorScheme.surface,
                filled: true,
              ),
            ),
          ),
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(child: Text('No items found.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return Dismissible(
                        key: Key(
                          item.name,
                        ), // TODO: change this to actually be good
                        direction: DismissDirection.endToStart,
                        background: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.red,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 4),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => _deleteItem(item.id),
                        child: PantryItemCard(item: item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
