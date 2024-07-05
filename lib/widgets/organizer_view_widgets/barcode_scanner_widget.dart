import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerWidget extends StatefulWidget {
  final Function(String) onCodeDetected;

  BarcodeScannerWidget({required this.onCodeDetected});

  @override
  _BarcodeScannerWidgetState createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  late MobileScannerController scannerController;
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    scannerController = MobileScannerController();
    subscription = scannerController.barcodes.listen((barcodeCapture) {
      if (barcodeCapture.barcodes.isNotEmpty) {
        final String code = barcodeCapture.barcodes.first.rawValue ?? "---";
        widget.onCodeDetected(code);
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: MobileScanner(
        controller: scannerController,
      ),
    );
  }
}
