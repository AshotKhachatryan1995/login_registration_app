import '../models/user.dart';

abstract class ApiRepository {
  Future<dynamic> createUser({required User user});
  Future<dynamic> signIn({required String userName, required String password});
  Future<dynamic> verifyCode({required String code});
  Future<dynamic> setNewPassword(
      {required String userName, required String password});
  Future<dynamic> getUserByID({required String userId});
}
