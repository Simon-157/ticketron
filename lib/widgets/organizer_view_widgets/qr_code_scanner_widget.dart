import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScannerWidget extends StatefulWidget {
  final Function(String) onCodeDetected;

  QRCodeScannerWidget({required this.onCodeDetected});

  @override
  _QRCodeScannerWidgetState createState() => _QRCodeScannerWidgetState();
}

class _QRCodeScannerWidgetState extends State<QRCodeScannerWidget> {
  late MobileScannerController scannerController;
  StreamSubscription? subscription;
  bool scannerActive = true;

  @override
  void initState() {
    super.initState();
    scannerController = MobileScannerController();
    subscription = scannerController.barcodes.listen((barcodeCapture) {
      if (barcodeCapture.barcodes.isNotEmpty && scannerActive) {
        setState(() {
          scannerActive = false; // Pause scanner on detection
        });
        final String code = barcodeCapture.barcodes.first.rawValue ?? "---";
        showConfirmationDialog(code);
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    scannerController.dispose();
    super.dispose();
  }

  void showConfirmationDialog(String code) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enroll Attendee?'),
        content: Text('Do you want to enroll this attendee with QR code: $code?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close dialog
              setState(() {
                scannerActive = true; // Resume scanner
              });
              bool continueScanning = await widget.onCodeDetected(code);
              if (continueScanning) {
                showContinueDialog();
              } else {
                Navigator.of(context).pop(false); // Close QRCodeScannerWidget
              }
            },
            child: Text('Enroll'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              setState(() {
                scannerActive = true; // Resume scanner
              });
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void showContinueDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Continue Scanning?'),
        content: Text('Do you want to continue scanning for more attendees?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Continue scanning
              setState(() {
                scannerActive = true; // Resume scanner
              });
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Stop scanning
              Navigator.of(context).pop(false); // Close QRCodeScannerWidget
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: MobileScanner(
        controller: scannerController,
      ),
    );
  }
}
