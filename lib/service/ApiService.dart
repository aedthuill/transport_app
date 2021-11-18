// @dart=2.9


import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:developer';
import 'package:fl_app/models/Arrival.dart';
import 'package:fl_app/models/CurrentArrival.dart';
import 'package:fl_app/models/MarshrutVariant.dart';
import 'package:fl_app/models/RaceCard.dart';
import 'package:fl_app/models/Routes.dart';
import 'package:fl_app/models/Stops.dart';
import 'package:fl_app/models/StopsForMap.dart';
import 'package:http/http.dart' as http;

import 'package:fl_app/models/TransportType.dart';

class ApiService {

///виды транспортного средства
  Future<List<Transport>> fetchTransport() async {
    String username = 'VOLGA';
    String password = 'NET';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var response = await http.get(
        Uri.parse(
            "http://asunav-ws.volganet.ru/volgograd/getTransportTypes.php?fmt=json"),
        headers: <String, String>{'authorization': basicAuth});
    var jsonResponse = convert.jsonDecode(response.body) as List;
    return jsonResponse.map((e) => Transport.fromJson(e)).toList();
  }

  ///сами маршруты
  Future<List<Routes>> fetchroutes() async {
    String username = 'VOLGA';
    String password = 'NET';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var response = await http.get(
        Uri.parse(
            "http://asunav-ws.volganet.ru/volgograd/getMarshes.php?fmt=json"),
        headers: <String, String>{'authorization': basicAuth});
    var jsonResponse = convert.jsonDecode(response.body) as List;
    return jsonResponse.map((e) => Routes.fromJson(e)).toList();
  }

//получает время сформированное "вотпрямщас". Принципиальных отличий я не заметила, но может плохо искала
//очень фигово написана документация к АПИ, придется немного ее переделать или тут в комментах написать, что к чему
//на трамвай подземный не получает время и на некоторые троллейбусы, но это уже проблема не приложения

  Future<List<CurrentArrivalTime>> fetchArrivals(mvId) async {
    String username = 'VOLGA';
    String password = 'NET';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var response = await http.get(
        Uri.parse(
            "http://asunav-ws.volganet.ru/volgograd/getTableCur.php?fmt=json"),
        headers: <String, String>{'authorization': basicAuth});
    var jsonResponse = convert.jsonDecode(response.body) as List;
   try{
     return jsonResponse.map((e) => CurrentArrivalTime.fromJson(e)).toList();
   }catch(e, s){
     log('ne poluchilos', error: e, stackTrace: s);
   }
  }

/*Карточка рейса*/
  Future<List<RaceCard>> fetchRaceCard(int mv_id) async {
    String username = 'VOLGA';
    String password = 'NET';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var response = await http.get(
        Uri.parse(
            "http://asunav-ws.volganet.ru/volgograd/getRaceCard.php?fmt=json&mv_id=$mv_id"),
        headers: <String, String>{'authorization': basicAuth});
    var body = response.body;
    print(body);
    var jsonResponse = convert.jsonDecode(body) as List;
    return jsonResponse.map((e) => RaceCard.fromJson(e)).toList();
  }

  /// вот это используется для того, чтобы настроить направление
  /// на самом деле я его не настраивала и просто предупреждаю что такое есть
  /// его можно добавить в алгоритм
  Future<List<RaceList>> fetchRaceList(int mv_id) async {
    String username = 'VOLGA';
    String password = 'NET';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var response = await http.get(
        Uri.parse(
            "http://asunav-ws.volganet.ru/volgograd/getRaceList.php?fmt=json&mv_id=$mv_id"),
        headers: <String, String>{'authorization': basicAuth});
    var body = response.body;
    print(body);
    var jsonResponse = convert.jsonDecode(body) as List;
    return jsonResponse.map((e) => RaceList.fromJson(e)).toList();
  }

  /* вариант маршрута*/
  Future<List<ScheduleVariants>> fetchSchedule() async {
    String username = 'VOLGA';
    String password = 'NET';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var response = await http.get(
        Uri.parse(
            "http://asunav-ws.volganet.ru/volgograd/getMarshVariants.php?fmt=json"),
        headers: <String, String>{'authorization': basicAuth});
    var jsonResponse = convert.jsonDecode(response.body) as List;
    return jsonResponse.map((e) => ScheduleVariants.fromJson(e)).toList();
  }

  /*остановки*/
  Future<List<StopList>> fetchStops() async {
    String username = 'VOLGA';
    String password = 'NET';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var response = await http.get(
        Uri.parse(
            "http://asunav-ws.volganet.ru/volgograd/getStops.php?fmt=json"),
        headers: <String, String>{'authorization': basicAuth});
    var jsonResponse = convert.jsonDecode(response.body) as List;
    return jsonResponse.map((e) => StopList.fromJson(e)).toList();
  }


  //все расписание
  //если поместить в алгоритм, то работать будет медленно.
  // Ожидание составляет 30-40 секунд, потому что он выгражет вообще все расписание
  //как оптимизировать - не придумала.

  Future <List<AllArrivalsTransport>> fetchAllArrivals(int mv_id)async{
    String username = 'VOLGA';
    String password = 'NET';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    var response = await http.get(
        Uri.parse(
            "http://asunav-ws.volganet.ru/volgograd/getTableAll.php?fmt=json&mv_id=$mv_id"),
        headers: <String, String>{'authorization': basicAuth});
    var jsonResponse = convert.jsonDecode(response.body) as List;
      return jsonResponse.map((e) => AllArrivalsTransport.fromJson(e)).toList();
  }

}


//это запрос для вывода на карту значков остановок. Идет отдельно от всего
//Также создан отдельный класс модели. Почему-то внутри класса не работает, хз, что ему надо
///переодически не может правильно распарсить:
///первый элемент он видит как нулевой и поэтому начинает думать, что все остальное тоже нулл
///в АПИ первый элемент реально нулл.

Future<List<Stop>> fetchStops() async {
  String username = 'VOLGA';
  String password = 'NET';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  print(basicAuth);
  var response = await http.get(
      Uri.parse(
          "http://asunav-ws.volganet.ru/volgograd/getStops.php?fmt=json"),
      headers: <String, String>{'authorization': basicAuth});
  var jsonResponse = convert.jsonDecode(response.body) as List;
  var body = response.body;
  print(body);
  return jsonResponse.map((e) => Stop.fromJson(e)).toList();
}
