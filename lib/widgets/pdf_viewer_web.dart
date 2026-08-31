import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfWebViewer extends StatefulWidget {
  final String assetPath;
  const PdfWebViewer({Key? key, required this.assetPath}) : super(key: key);

  @override
  State<PdfWebViewer> createState() => _PdfWebViewerState();
}

class _PdfWebViewerState extends State<PdfWebViewer> {
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openAsset(widget.assetPath),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PdfView(
      controller: _pdfController,
      backgroundDecoration: const BoxDecoration(
        color: Colors.transparent,
      ),
    );
  }
}