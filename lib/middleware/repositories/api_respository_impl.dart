import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:login_registration_app/middleware/extensions/string_extension.dart';
import 'package:login_registration_app/middleware/repositories/api_repository.dart';

import '../models/user.dart';

class ApiRepositoryImpl implements ApiRepository {
  @override
  Future<dynamic> createUser({required User user}) async {
    final box = await Hive.openBox<User>('users_db');

    final userEmail =
        box.values.firstWhereOrNull((element) => element.email == user.email);

    final userPhone =
        box.values.firstWhereOrNull((element) => element.phone == user.phone);

    if (userPhone != null || userEmail != null) {
      return;
    }

    await box.put(user.id, user);

    return user.id;
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
      return user.id;
    }
  }
}
