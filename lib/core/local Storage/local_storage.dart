import 'package:flutter_dev_test/core/api/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<T?> get<T>(String key) async {
    final prefs = await _prefs;
    return prefs.get(key) as T?;
  }

  Future<void> set(String key, {required dynamic data}) async {
    final prefs = await _prefs;

    switch (data.runtimeType) {
      case const (bool):
        await prefs.setBool(key, data);
        break;
      case const (String):
        await prefs.setString(key, data);
        break;
      case const (int):
        await prefs.setInt(key, data);
        break;
      case const (double):
        await prefs.setDouble(key, data);
        break;
      case const (List<String>):
        await prefs.setStringList(key, data);
        break;
      default:
        throw ArgumentError('Tipo não suportado: ${data.runtimeType}');
    }
  }

  Future<void> delete(String key) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  Future<void> clearSecret() async {
    await delete(ApiConfig.secret);
  }
}
