// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contrahent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContrahentImpl _$$ContrahentImplFromJson(Map<String, dynamic> json) =>
    _$ContrahentImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      companyName: json['company_name'] as String?,
      contracts: (json['contracts'] as List<dynamic>?)
              ?.map((e) => Contract.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ContrahentImplToJson(_$ContrahentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company_name': instance.companyName,
      'contracts': instance.contracts,
    };
