import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class PdfWebViewer extends StatefulWidget {
  final String assetPath;
  const PdfWebViewer({Key? key, required this.assetPath}) : super(key: key);

  @override
  State<PdfWebViewer> createState() => _PdfWebViewerState();
}

class _PdfWebViewerState extends State<PdfWebViewer> {
  String? _blobUrl;
  final String viewId = 'pdf-iframe-\';

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final ByteData data = await rootBundle.load(widget.assetPath);
      final buffer = data.buffer.asUint8List();
      final blob = html.Blob([buffer], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      setState(() {
        _blobUrl = url;
      });
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        viewId,
        (int id) => html.IFrameElement()
          ..src = _blobUrl
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%',
      );
    } catch (e) {
      debugPrint('Error loading PDF: \');
    }
  }

  @override
  void dispose() {
    if (_blobUrl != null) {
      html.Url.revokeObjectUrl(_blobUrl!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_blobUrl == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return HtmlElementView(viewType: viewId);
  }
}