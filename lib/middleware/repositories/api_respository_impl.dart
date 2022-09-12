import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:login_registration_app/middleware/extensions/string_extension.dart';
import 'package:login_registration_app/middleware/repositories/api_repository.dart';

import '../models/user.dart';

class ApiRepositoryImpl implements ApiRepository {
  @override
  Future<dynamic> createUser({required User user}) async {
    final box = await Hive.openBox<User>('users_db');

    final newUser = box.values.firstWhereOrNull((element) =>
        element.email == user.email || element.phone == user.phone);

    if (newUser != null) {
      return;
    }

    await box.put(user.id, user);

    return user;
  }

  @override
  Future<dynamic> signIn(
      {required String userName, required String password}) async {
    final box = await Hive.openBox<User>('users_db');

    final users = box.values
        .where((user) => user.email == userName || user.phone == userName)
        .toList();

    if (users.isEmpty) {
      return;
    }

    final user = users.first;

    if (user.password == password.generateMd5()) {
      return user;
    }
  }

  @override
  Future<dynamic> verifyCode({required String code}) async {
    return code == '00000';
  }

  @override
  Future<dynamic> setNewPassword(
      {required String userName, required String password}) async {
    final box = await Hive.openBox<User>('users_db');

    final existsUser = box.values.firstWhereOrNull(
        (element) => element.email == userName || element.phone == userName);

    if (existsUser == null) {
      return;
    }

    existsUser.password = password;

    await box.put(existsUser.id, existsUser);

    return existsUser;
  }

  @override
  Future<dynamic> getUserByID({required String userId}) async {
    final box = await Hive.openBox<User>('users_db');

    final users = box.values.where((user) => user.id == userId).toList();

    if (users.isEmpty) {
      return;
    }

    final user = users.first;

    return user;
  }

  @override
  Future<dynamic> resendCode() async {}
}
