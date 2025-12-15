import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter username';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void onForgetPasswordTap() {
    // TODO: Implement forget password functionality
    print('Forget password tapped');
  }

  void onRegisterNowTap() {
    // TODO: Implement register navigation
    print('Register now tapped');
  }

  Future<void> onLoginPressed(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      _isLoading = true;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      _isLoading = false;
      notifyListeners();

      // TODO: Implement actual login logic here
      print('Login with ${usernameController.text}');
    }
  }
}
