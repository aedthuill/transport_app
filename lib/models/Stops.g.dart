// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'Stops.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StopListAdapter extends TypeAdapter<StopList> {
  @override
  final int typeId = 4;

  @override
  StopList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StopList(
      stId: fields[0] as int,
      okId: fields[1] as dynamic,
      srId: fields[2] as int,
      stTitle: fields[3] as String,
      stDesc: fields[4] as String,
      stLat: fields[5] as double,
      stLong: fields[6] as double,
      stNote: fields[7] as String,
      stRegnum: fields[8] as String,
    )..timeArrival = fields[9] as dynamic;
  }

  @override
  void write(BinaryWriter writer, StopList obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.stId)
      ..writeByte(1)
      ..write(obj.okId)
      ..writeByte(2)
      ..write(obj.srId)
      ..writeByte(3)
      ..write(obj.stTitle)
      ..writeByte(4)
      ..write(obj.stDesc)
      ..writeByte(5)
      ..write(obj.stLat)
      ..writeByte(6)
      ..write(obj.stLong)
      ..writeByte(7)
      ..write(obj.stNote)
      ..writeByte(8)
      ..write(obj.stRegnum)
      ..writeByte(9)
      ..write(obj.timeArrival);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StopListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
