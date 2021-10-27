// @dart=2.9

import 'dart:convert';

import 'package:fl_app/models/StopsForMap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {

  Future <void> save(String key, List<Stop> stop) async {
    final prefences = await SharedPreferences.getInstance();
    print('POINT2');
    prefences.setString(key, json.encode(stop));
  }

  remove(String key) async {
    final prefences = await SharedPreferences.getInstance();
    print("POINT3");
    prefences.remove(key);
  }
}
