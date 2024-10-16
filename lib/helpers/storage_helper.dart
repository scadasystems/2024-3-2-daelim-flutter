import 'package:daelim_project/models/auth_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static SharedPreferences? _pref;

  static const String _authKey = 'authKey';

  /// SharedPreference 초기화
  static Future<void> initialized() async {
    _pref = await SharedPreferences.getInstance();
  }

  /// NOTE: AuthData 불러오기
  static AuthData? get authData {
    final data = _pref!.getString(_authKey);
    return data != null ? AuthData.fromJson(data) : null;
  }

  /// NOTE: AuthData 저장하기
  static Future<bool> setAuthData(AuthData data) {
    return _pref!.setString(_authKey, data.toJson());
  }

  /// NOTE: AuthData 삭제하기
  static Future<bool> removeAuthData() {
    return _pref!.remove(_authKey);
  }
}
