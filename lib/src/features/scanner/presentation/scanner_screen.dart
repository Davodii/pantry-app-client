import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pantry_app/src/core/data/repositories/product_repository.dart';
import 'package:pantry_app/src/core/models/product.dart';
import 'package:pantry_app/src/features/pantry/data/pantry_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final PantryRepository pantryRepository = PantryRepository();
  final ProductRepository productRepository = ProductRepository();
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

  void _handleBarcodeScanned(Barcode barcode) async {
    final String? value = barcode.rawValue;
    if (value == null || _hasShownDialog) return;

    Product product = await _getProductInformation(value);
    // TODO: insert product information into the dialog window
    // TODO: create layout for dialog window

    _hasShownDialog = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('${product.name}'),
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
              _addItemAndCloseDialog(product);
            },
            child: const Text('Add to Pantry'),
          ),
          TextButton(onPressed: _closeDialog, child: const Text('Cancel')),
        ],
      ),
    );
  }

  Future<Product> _getProductInformation(String barcode) async {
    // TODO: need to handle exceptions from requests and other things !!!
    return await productRepository.getProduct(barcode);
  }

  void _closeDialog() {
    Navigator.of(context).pop();
    setState(() {
      _hasShownDialog = false;
    });
  }

  void _addItemAndCloseDialog(Product item) async {
    String quantity = item.quantity == null ? "1" : item.quantity!;

    // TODO: handle error inserting pantry item,
    // TODO: handle expiration date
    await pantryRepository.insertItem(item.barcode, quantity, "");

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
