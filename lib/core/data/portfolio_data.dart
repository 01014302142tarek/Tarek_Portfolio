import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PortfolioData {
  static bool _isLoaded = false;
  static Map<String, dynamic> _data = {};
  static Map<String, dynamic> get data => _data;

  static Future<void> load() async {
    if (_isLoaded) return;
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/portfolio_data.json',
      );
      _data = jsonDecode(jsonString);
      _isLoaded = true;
    } catch (e) {
      _data = {};
      debugPrint('Error loading portfolio data: $e');
    }
  }
}
