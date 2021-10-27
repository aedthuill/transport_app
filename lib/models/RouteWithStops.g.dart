// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'RouteWithStops.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RouteWithStopsAdapter extends TypeAdapter<RouteWithStops> {
  @override
  final int typeId = 0;

  @override
  RouteWithStops read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RouteWithStops()
      ..route = fields[0] as Routes
      ..stop = (fields[1] as List)?.cast<StopList>()
      ..cards = (fields[2] as List)?.cast<RaceCard>()
      ..variant = fields[3] as ScheduleVariants
      ..transport = fields[4] as Transport
      ..arrivals = (fields[5] as List)?.cast<CurrentArrivalTime>();
  }

  @override
  void write(BinaryWriter writer, RouteWithStops obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.route)
      ..writeByte(1)
      ..write(obj.stop)
      ..writeByte(2)
      ..write(obj.cards)
      ..writeByte(3)
      ..write(obj.variant)
      ..writeByte(4)
      ..write(obj.transport)
      ..writeByte(5)
      ..write(obj.arrivals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteWithStopsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
