// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractImpl _$$ContractImplFromJson(Map<String, dynamic> json) =>
    _$ContractImpl(
      id: json['id'] as int,
      contrahentId: json['contrahent_id'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
    );

Map<String, dynamic> _$$ContractImplToJson(_$ContractImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contrahent_id': instance.contrahentId,
      'name': instance.name,
      'number': instance.number,
    };
