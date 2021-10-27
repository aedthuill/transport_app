// @dart=2.9

import 'package:fl_app/models/CurrentArrival.dart';

import 'MarshrutVariant.dart';
import 'RaceCard.dart';
import 'Routes.dart';
import 'Stops.dart';

class RouteandStopsSearch{
  Routes route;
  StopList stop;
  List <RaceCard> cards;
  ScheduleVariants variant;
  List<CurrentArrivalTime> arrivals;
}