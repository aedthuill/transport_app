// @dart=2.9

import 'dart:convert';

import 'package:fl_app/models/StopsForMap.dart';
import 'package:shared_preferences/shared_preferences.dart';


// это меняет имя остановки в алерт диалоге но не перезаписывает его в общем списке
//наверное к лучшему, так как разрабы апи оторвут голову за изменение
//оно и так тут все еле работает поэтому лучше никого не бесить и не пытаться реализовать эту плохую идею
//чисто технически оно работает - в алерт диалоге все меняется, но не сохраняется на постоянку
//также совет не надо пытаться пут-запросом менять название остановки, так как это будет писаться на сервер
// разрабы АПИ за это не поблагодарят
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
