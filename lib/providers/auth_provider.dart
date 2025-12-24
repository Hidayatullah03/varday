import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _init();
  }

  void _init() {
    try {
      _authService.user.listen((User? user) async {
        if (user != null) {
          try {
            _user = await _authService.getCurrentUserData();
          } catch (e) {
            print('Failed to get user data: $e');
            _user = user; // fallback
          }
        } else {
          _user = null;
        }
        notifyListeners();
      });
    } catch (e) {
      print('Firebase not initialized: $e');
      // _user remains null
    }
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      User? result = await _authService.signInWithEmailAndPassword(email, password);
      _isLoading = false;
      notifyListeners();
      return result != null;
    } catch (e) {
      print('Sign in failed: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password, String name, UserRole role) async {
    _isLoading = true;
    notifyListeners();
    try {
      User? result = await _authService.registerWithEmailAndPassword(email, password, name, role);
      _isLoading = false;
      notifyListeners();
      return result != null;
    } catch (e) {
      print('Register failed: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      print('Sign out failed: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
    } catch (e) {
      print('Reset password failed: $e');
    }
  }
}