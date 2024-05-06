// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HivePage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FootballTeamAdapter extends TypeAdapter<FootballTeam> {
  @override
  final int typeId = 0;

  @override
  FootballTeam read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FootballTeam(
      id: fields[0] as int?,
      teamSize: fields[2] as int?,
      teamName: fields[1] as String?,
      region: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FootballTeam obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.teamName)
      ..writeByte(2)
      ..write(obj.teamSize)
      ..writeByte(3)
      ..write(obj.region);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FootballTeamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
