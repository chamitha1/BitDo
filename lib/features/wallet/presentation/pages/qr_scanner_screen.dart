import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code'), toolbarHeight: 56),
      body: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
           if (barcodes.isNotEmpty) {
             final String? code = barcodes.first.rawValue;
             if (code != null) {
               Get.back(result: code);
             }
           }
        },
      ),
    );
  }
}
