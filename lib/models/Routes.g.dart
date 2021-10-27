// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'Routes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutesAdapter extends TypeAdapter<Routes> {
  @override
  final int typeId = 1;

  @override
  Routes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Routes(
      mrId: fields[0] as int,
      mrNum: fields[1] as String,
      mrTitle: fields[2] as String,
      mrNote: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Routes obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.mrId)
      ..writeByte(1)
      ..write(obj.mrNum)
      ..writeByte(2)
      ..write(obj.mrTitle)
      ..writeByte(3)
      ..write(obj.mrNote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
