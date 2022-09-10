import '../models/user.dart';

abstract class ApiRepository {
  Future<dynamic> createUser({required User user});
  Future<dynamic> signIn({required String userName, required String password});
}
