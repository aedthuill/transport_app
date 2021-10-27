// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'MarshrutVariant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleVariantsAdapter extends TypeAdapter<ScheduleVariants> {
  @override
  final int typeId = 2;

  @override
  ScheduleVariants read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleVariants(
      mvId: fields[0] as int,
      mrId: fields[1] as int,
      mvDesc: fields[2] as String,
      mvStartdate: fields[3] as DateTime,
      mvEnddate: fields[4] as DateTime,
      mvEnddateexists: fields[5] as bool,
      mvChecksum: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleVariants obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.mvId)
      ..writeByte(1)
      ..write(obj.mrId)
      ..writeByte(2)
      ..write(obj.mvDesc)
      ..writeByte(3)
      ..write(obj.mvStartdate)
      ..writeByte(4)
      ..write(obj.mvEnddate)
      ..writeByte(5)
      ..write(obj.mvEnddateexists)
      ..writeByte(6)
      ..write(obj.mvChecksum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleVariantsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
