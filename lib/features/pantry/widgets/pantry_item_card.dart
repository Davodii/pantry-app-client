import 'package:flutter/material.dart';
import 'package:pantry_app/data/models/pantry_item.dart';

class PantryItemCard extends StatelessWidget {
  final PantryItem item;

  const PantryItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        title: Text(item.name),
        subtitle: item.expiryDate != null
            ? Text('Expires: ${_formatDate(item.expiryDate!)}')
            : const Text('No expiry'),
        trailing: Text('x${item.quantity}'),
        onTap: () {
          // todo: Navigate to item editing
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
