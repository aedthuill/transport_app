// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'StopsForMap.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StopAdapter extends TypeAdapter<Stop> {
  @override
  final int typeId = 3;

  @override
  Stop read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stop(
      stId: fields[0] as int,
      okId: fields[1] as String,
      srId: fields[2] as int,
      stTitle: fields[3] as String,
      stDesc: fields[4] as String,
      stLat: fields[5] as double,
      stLong: fields[6] as double,
      stNote: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Stop obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.stNote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StopAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
