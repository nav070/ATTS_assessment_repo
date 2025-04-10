import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userId;

  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;

  Future<String> getUserId(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'admin@example.com' && password == 'password') {
      _isLoggedIn = true;
      _userId = 'user_123'; 
      notifyListeners();
      return _userId!;
    } else {
      throw Exception('Invalid email or password');
    }
  }

  void logout() {
    _isLoggedIn = false;
    _userId = null;
    notifyListeners();
  }
}
