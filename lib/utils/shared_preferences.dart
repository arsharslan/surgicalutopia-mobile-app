import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  PreferencesHelper._();
  static final PreferencesHelper instance = PreferencesHelper._();

  SharedPreferences? _sharedPreferences;

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> reload() async {
    return await _sharedPreferences?.reload();
  }

  Future<bool>? clearAll() {
    return _sharedPreferences?.clear();
  }

  String _MONGO_USER_ID = "mongo-user-id";

  Future<bool>? setMongoUserId(String value) =>
      _sharedPreferences?.setString(_MONGO_USER_ID, value);

  String? get mongoUserID => _sharedPreferences?.getString(_MONGO_USER_ID);
}
