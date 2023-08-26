import 'package:flutter/material.dart';

class SearchModel extends ChangeNotifier {
  String _searchResult = '';

  String get searchResult => _searchResult;

  set searchResult(String value) {
    _searchResult = value;
    notifyListeners();
  }
}
