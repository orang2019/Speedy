// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarGoalAdapter extends TypeAdapter<CalendarGoal> {
  @override
  final int typeId = 0;

  @override
  CalendarGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarGoal(
      name: fields[0] as String,
      begin: fields[1] as DateTime,
      end: fields[2] as DateTime,
      eventColor: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CalendarGoal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.begin)
      ..writeByte(2)
      ..write(obj.end)
      ..writeByte(4)
      ..write(obj.eventColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
