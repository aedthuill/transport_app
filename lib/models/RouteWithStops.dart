// @dart=2.9


import 'package:fl_app/models/CurrentArrival.dart';
import 'package:fl_app/models/Stops.dart';
import 'package:hive/hive.dart';

import 'MarshrutVariant.dart';
import 'RaceCard.dart';
import 'Routes.dart';
import 'TransportType.dart';


part 'RouteWithStops.g.dart';
@HiveType(typeId: 0)
class RouteWithStops{

  @HiveField(0)
  Routes route;
  @HiveField(1)
  List<StopList> stop;
  @HiveField(2)
  List <RaceCard> cards;
  @HiveField(3)
  ScheduleVariants variant;
  @HiveField(4)
  Transport transport;
  @HiveField(5)
  List<CurrentArrivalTime> arrivals;
  List <RaceList> list;

}