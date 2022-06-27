import 'package:flutter/material.dart';

class Token with ChangeNotifier {
  String _token = "";

  String get token => _token;

  void updateToken(token) {
    _token = token;
    notifyListeners();
  }

  void resetToken(token) {
    _token = "";
    notifyListeners();
  }
}
