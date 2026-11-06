import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CachePreferencias {
  static const String keyPrefijo = 'cache_api_';
  static const String keyTimePrefijo = 'time_api_';

  Future<void> guardar(String clave, Map<String, dynamic> mapa) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('$keyPrefijo$clave', jsonEncode(mapa));
    await pref.setString('$keyTimePrefijo$clave', DateTime.now().toIso8601String());
  }

  Future<(Map<String, dynamic>?, DateTime?)> recuperar(String clave) async {
    final pref = await SharedPreferences.getInstance();
    final jsonStr = pref.getString('$keyPrefijo$clave');
    final timeStr = pref.getString('$keyTimePrefijo$clave');

    if (jsonStr != null && timeStr != null) {
      return (jsonDecode(jsonStr) as Map<String, dynamic>, DateTime.parse(timeStr));
    }
    return (null, null);
  }
}