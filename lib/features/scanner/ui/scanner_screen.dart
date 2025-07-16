import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pantry_app/data/models/product.dart';
import 'package:pantry_app/data/repositories/pantry_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final PantryRepository repo = PantryRepository();
  bool _hasPermission = false;
  bool _hasShownDialog = false;

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }

    if (status.isGranted) {
      setState(() {
        _hasPermission = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    requestCameraPermission();
  }

  void _handleBarcodeScanned(Barcode barcode) {
    final String? value = barcode.rawValue;
    if (value == null || _hasShownDialog) return;

    int? upcCode = int.tryParse(value);

    if (upcCode == null) {
      // This is an error, do not scan the barcode

      // TODO: show to user that the product is invalid

      return;
    }

    Product item = _getProductInformation(upcCode);

    // TODO: insert product information into the dialog window
    // TODO: create layout for dialog window

    _hasShownDialog = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('ITEM NAME'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Value $value'),
            const SizedBox(height: 16),
            const Text('What would you like to do?'),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () {
              _addItemAndCloseDialog(item);
            },
            child: const Text('Add to Pantry'),
          ),
          TextButton(onPressed: _closeDialog, child: const Text('Cancel')),
        ],
      ),
    );
  }

  Product _getProductInformation(int code) {
    // TODO: emulate local request to a database that returns information as JSONn instead

    // Product item = Product(id: code, name: "Temp Item", quantity: 1);
    return Product(barcode: "12313");
  }

  void _closeDialog() {
    Navigator.of(context).pop();
    setState(() {
      _hasShownDialog = false;
    });
  }

  void _addItemAndCloseDialog(Product item) async {
    // TODO: handle error inserting pantry item,
    // await repo.insertPantryItem(item);

    // Ensure no errors have occurred before closing the dialog
    _closeDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _hasPermission
          ? Stack(
              children: [
                MobileScanner(
                  onDetect: (capture) {
                    final barcode = capture.barcodes.first;
                    _handleBarcodeScanned(barcode);
                  },
                ),
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Scan a barcode',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
