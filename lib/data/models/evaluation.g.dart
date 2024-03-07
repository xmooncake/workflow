// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EvaluationAdapter extends TypeAdapter<Evaluation> {
  @override
  final int typeId = 0;

  @override
  Evaluation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Evaluation(
      id: fields[0] as int,
      startedAt: fields[1] as DateTime,
      finishedAt: fields[2] as DateTime,
      seconds: fields[3] as int,
      hasFailedToSend: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Evaluation obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startedAt)
      ..writeByte(2)
      ..write(obj.finishedAt)
      ..writeByte(3)
      ..write(obj.seconds)
      ..writeByte(4)
      ..write(obj.hasFailedToSend);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EvaluationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ActivityEvaluationAdapter extends TypeAdapter<ActivityEvaluation> {
  @override
  final int typeId = 1;

  @override
  ActivityEvaluation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityEvaluation(
      id: fields[0] as int,
      startedAt: fields[1] as DateTime,
      finishedAt: fields[2] as DateTime,
      seconds: fields[3] as int,
      contrahentId: fields[5] as int,
      contractId: fields[6] as int,
      assortmentType: fields[7] as String,
      userId: fields[8] as int,
      weight: fields[9] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityEvaluation obj) {
    writer
      ..writeByte(10)
      ..writeByte(5)
      ..write(obj.contrahentId)
      ..writeByte(6)
      ..write(obj.contractId)
      ..writeByte(7)
      ..write(obj.assortmentType)
      ..writeByte(8)
      ..write(obj.userId)
      ..writeByte(9)
      ..write(obj.weight)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startedAt)
      ..writeByte(2)
      ..write(obj.finishedAt)
      ..writeByte(3)
      ..write(obj.seconds)
      ..writeByte(4)
      ..write(obj.hasFailedToSend);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityEvaluationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InactivityEvaluationAdapter extends TypeAdapter<InactivityEvaluation> {
  @override
  final int typeId = 2;

  @override
  InactivityEvaluation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InactivityEvaluation(
      id: fields[0] as int,
      startedAt: fields[1] as DateTime,
      finishedAt: fields[2] as DateTime,
      seconds: fields[3] as int,
      breakType: fields[10] as BreakType,
    );
  }

  @override
  void write(BinaryWriter writer, InactivityEvaluation obj) {
    writer
      ..writeByte(6)
      ..writeByte(10)
      ..write(obj.breakType)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startedAt)
      ..writeByte(2)
      ..write(obj.finishedAt)
      ..writeByte(3)
      ..write(obj.seconds)
      ..writeByte(4)
      ..write(obj.hasFailedToSend);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InactivityEvaluationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
