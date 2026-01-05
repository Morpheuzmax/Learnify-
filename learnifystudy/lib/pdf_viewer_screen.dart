import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewerScreen extends StatefulWidget {
  final String assetPath;
  final String title;
  const PdfViewerScreen({super.key, required this.assetPath, required this.title});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? localPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _preparePdf();
  }

  Future<void> _preparePdf() async {
    try {
      final byteData = await rootBundle.load(widget.assetPath);
      final dir = await getApplicationDocumentsDirectory();
      final filename = widget.assetPath.split('/').last;
      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);
      if (mounted) setState(() { localPath = file.path; isLoading = false; });
    } catch (e) {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), backgroundColor: const Color(0xFFD50000), foregroundColor: Colors.white),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : localPath != null
          ? PDFView(filePath: localPath, enableSwipe: true, swipeHorizontal: false, autoSpacing: false, pageFling: false)
          : const Center(child: Text("Failed to load PDF")),
    );
  }
}