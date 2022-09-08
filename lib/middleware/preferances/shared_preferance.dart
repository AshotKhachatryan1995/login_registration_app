import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences? _sharedPrefs;
  factory SharedPrefs() => SharedPrefs._();

  SharedPrefs._();

  dynamic valueByKey(String key, {dynamic defaultValue}) {
    return _sharedPrefs?.get(key) ?? defaultValue;
  }

  Future<void> setString(String key, String value) async {
    await _sharedPrefs?.setString(key, value);
  }

  Future<void> remove(String key) async {
    await _sharedPrefs?.remove(key);
  }
}
