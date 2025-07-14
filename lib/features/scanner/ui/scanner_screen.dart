import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pantry_app/data/store/pantry_item_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
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

    _hasShownDialog = true;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Scanned Barcode'),
        content: Text('Value: $value'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _hasShownDialog = false;
              });
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
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
