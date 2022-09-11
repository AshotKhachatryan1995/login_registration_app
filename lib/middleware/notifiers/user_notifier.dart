import 'package:flutter/material.dart';

import '../models/user.dart';

class UserNotifier extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  void setNewUser({required User user}) {
    _user = user;

    notifyListeners();
  }
}
