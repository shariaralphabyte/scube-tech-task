import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/mock_data.dart';

class AuthRepositoryImpl implements AuthRepository {
  User? _currentUser;

  @override
  Future<User?> login(String email, String password) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final user = MockData.getUserByCredentials(email, password);
    if (user != null) {
      _currentUser = user;
    }
    return user;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  @override
  Future<User?> getCurrentUser() async {
    return _currentUser;
  }
}
