import 'package:flutter/material.dart';
import 'package:pantry_app/data/models/product.dart';
import 'package:pantry_app/data/repositories/pantry_item_repository.dart';
import 'package:pantry_app/features/pantry/widgets/pantry_item_card.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => PantryScreenState();
}

class PantryScreenState extends State<PantryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PantryItemRepository _repo = PantryItemRepository();

  List<Product> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void refresh() {
    _loadItems();
  }

  void _loadItems() async {
    // final items = await _repo.allPantryItems();
    // setState(() {
    //   _items = items;
    // });
  }

  void _deleteItem(int id) async {
    // await _repo.removePantryItem(id);
    // _loadItems();
  }

  void _onSearchChanged(String query) async {
    // final items = await _repo.searchPantryItems(query);
    // setState(() {
    //   _items = items;
    // });
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
            child: _items.isEmpty
                ? const Center(child: Text('No items found.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return Dismissible(
                        key: Key(
                          // TODO: change key to use barcode instead
                          "aaa",
                        ),
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
                        onDismissed: (_) => {
                          /* TODO: delete all entries for this item */
                        },
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
