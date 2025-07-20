import 'package:flutter/material.dart';
import 'package:pantry_app/src/features/pantry/data/models/pantry_item.dart';

class PantryItemCard extends StatelessWidget {
  final PantryItem item;

  const PantryItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        title: Text(item.product.name!),
        subtitle:
            // TODO: show expiration date if this entry has an expiration date associated with it
            // item.expiryDate != null
            // ? Text('Expires: ${_formatDate(item.expiryDate!)}')
            const Text('No expiry'),
        trailing: Text('x${item.quantity}'),
        onTap: () {
          // TODO: Navigate to item editing
        },
      ),
    );
  }

  // String _formatDate(DateTime date) {
  //   return '${date.day}/${date.month}/${date.year}';
  // }
}
