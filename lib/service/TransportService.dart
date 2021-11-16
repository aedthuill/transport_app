// @dart=2.9


//ПОБОЙТЕСЬ БОГА И НЕ ТРОГАЙТЕ ТУТ НИЧЕГО
//ОНО ЛУЧШЕ ВСЕ РАВНО НЕ СТАНЕТ
//ЕСЛИ МОЖЕТЕ ЧТО-ТО ПОМЕНЯТЬ, ТО В СЛУЧАЕ ЕСЛИ БУДЕТЕ ПРЯМ ОЧЕНЬ УВЕРЕНЫ В ТОМ, ЧТО ДЕЛАЕТЕ В ОСТАЛЬНЫХ СЛУЧАЯХ НЕ НАДО НИЧЕГО ТРОГАТЬ

import 'package:fl_app/models/CurrentArrival.dart';
import 'package:fl_app/models/MarshrutVariant.dart';
import 'package:fl_app/models/RaceCard.dart';
import 'package:fl_app/models/RouteWithStops.dart';
import 'package:fl_app/models/Routes.dart';
import 'package:fl_app/models/Stops.dart';
import 'package:fl_app/models/TransportType.dart';
import 'package:fl_app/models/TransportWithRoutes.dart';
import 'package:fl_app/service/ApiService.dart';

//здесь вся магия и просиходит. Это и есть основной алгоритм этого приложения.
//менять что-либо можно только в двух случаях: а)под страхом смерти; б)если вы 100 проуентов уверены, что все будет классно
//работает, да, медленно, но дело даже не в скорости, а в том, чтобы просто заставить это работать.
//если вы (один или вас много) решите, что вы такие молодцы-огурцы и сейчас лихо все переделаете, то тысячу раз подумайте.

//Что тут происходит? Первая функция создает мапу, в которую кладется ключ значения, внутри мы проверяем, что в запросе что-то есть и он не пустой,
//потом создаем метод, который для нас ищет по ключу пару вид транспорта/маршрут (там есть цикл фор, вот он и идет по всем значениям и ищет пару).
// Как только эта функци отработала - создаем другую.
//потом когда пара найдена, мы создаем еще одну функцию и пилим туда поиск варианта маршрута, т.к он связан с самим маршрутом и ищем сооьтвествия по ключу
//и вот последняя функция нам ищем все остановки, прикрепленные к данному маршртуту, но делаете это через вариант маршрута и карточку рейса
//в предыдущей функции мы уже нашли пару маршрут/вариант маршрута, поэтому сейчас нам надо найти пару карточка рейса/остановка
// в послендней функции мы по ключу находим пару остановка/карточка рейса, во внутрь остановки добавляем время прибытия на нее и - ВУАЛЯ
// все работает.

class TransportService {
  final ApiService api = ApiService();

  Map<int, TransportWithRoutes> routesbyTransportType = {};

  Future<List<TransportWithRoutes>> getTransportWithRoutes() async {
    if (routesbyTransportType.isEmpty) {
      await fetchTransportWithRoutes();
    }
    var list = routesbyTransportType.values.toList();
    print(list.join());
    return list;
  }

  Future<void> fetchTransportWithRoutes() async {
    print('dedg');
    List<Transport> transportList = [];
    List<Routes> routeList = [];

    transportList.addAll((await api.fetchTransport()));
    print('hwgdehehe');
    routeList.addAll((await api.fetchroutes()));
    print('deghgberhjd');

    Map<int, Transport> tranportbyTransportId =
        Map<int, Transport>.fromIterable(
      transportList,
      key: (e) => e.ttId,
      value: (e) => e,
    );

    for (Routes route in routeList) {
      if (routesbyTransportType[route.ttId] == null) {
        routesbyTransportType[route.ttId] = TransportWithRoutes()
          ..routes = []
          ..transport = tranportbyTransportId[route.ttId];
      }
      routesbyTransportType[route.ttId].routes.add(route);
    }
    print('object');
    print(routesbyTransportType.values.join());
  }

  Future<List<RouteWithStops>> getMarshrutWithStops(int ttId) async {
    if (routesbyTransportType.isEmpty) {
      await fetchTransportWithRoutes();
    }
    print('I AM HERE WITH THE ERRORS FOR YA');
    List<Routes> routes = routesbyTransportType[ttId].routes.toList();
    print(routes);
    print('I AM HERE AFTER THE SECOND PRINT');
    List<ScheduleVariants> variants = [];

    variants.addAll(await api.fetchSchedule());

    List<RouteWithStops> routesWithStops = [];

    for (Routes route in routes) {
      final routeWithStops = RouteWithStops();

      routesWithStops.add(routeWithStops);
      routeWithStops.route = route;

      print(routes);
      print('I AM HERE AFTER THE SECOND PRINT');

      routeWithStops.variant =
          variants.where((variant) => variant.mrId == route.mrId).first;
      print(routesWithStops);
      print('the goddamit bug');
    }
    return routesWithStops;

  }


  Future<RouteWithStops> fetchStopsInfo(routeWithStops) async {
    List<RaceCard> cards = [];
    List<StopList> stops = [];
    List<CurrentArrivalTime> arrivals = [];

    cards.addAll(await api.fetchRaceCard(routeWithStops.variant.mvId));
    stops.addAll(await api.fetchStops());
    arrivals.addAll(await api.fetchArrivals(routeWithStops.variant.mvId));

    print(cards);
    print(arrivals);
    List<StopList> currentRouteStops = [];

    cards.forEach((card) {
      stops.forEach((stop) {
        if (card.stId == stop.stId) {
          currentRouteStops.add(stop);
        }
      });
    });
    currentRouteStops.forEach((stop) {
      arrivals.forEach((arrival) {
        if(stop.stId == arrival.stId){
          print('sdfsdf');
          stop.timeArrival = arrival.tcArrivetime;
        }
      });
    });
    routeWithStops.stop = currentRouteStops;
    return routeWithStops;
  }
}



/*
*
*
*
* */