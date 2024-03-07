// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contrahent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Contrahent _$ContrahentFromJson(Map<String, dynamic> json) {
  return _Contrahent.fromJson(json);
}

/// @nodoc
mixin _$Contrahent {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_name')
  String? get companyName => throw _privateConstructorUsedError;
  List<Contract> get contracts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContrahentCopyWith<Contrahent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContrahentCopyWith<$Res> {
  factory $ContrahentCopyWith(
          Contrahent value, $Res Function(Contrahent) then) =
      _$ContrahentCopyWithImpl<$Res, Contrahent>;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'company_name') String? companyName,
      List<Contract> contracts});
}

/// @nodoc
class _$ContrahentCopyWithImpl<$Res, $Val extends Contrahent>
    implements $ContrahentCopyWith<$Res> {
  _$ContrahentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? companyName = freezed,
    Object? contracts = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      contracts: null == contracts
          ? _value.contracts
          : contracts // ignore: cast_nullable_to_non_nullable
              as List<Contract>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContrahentImplCopyWith<$Res>
    implements $ContrahentCopyWith<$Res> {
  factory _$$ContrahentImplCopyWith(
          _$ContrahentImpl value, $Res Function(_$ContrahentImpl) then) =
      __$$ContrahentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'company_name') String? companyName,
      List<Contract> contracts});
}

/// @nodoc
class __$$ContrahentImplCopyWithImpl<$Res>
    extends _$ContrahentCopyWithImpl<$Res, _$ContrahentImpl>
    implements _$$ContrahentImplCopyWith<$Res> {
  __$$ContrahentImplCopyWithImpl(
      _$ContrahentImpl _value, $Res Function(_$ContrahentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? companyName = freezed,
    Object? contracts = null,
  }) {
    return _then(_$ContrahentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      contracts: null == contracts
          ? _value._contracts
          : contracts // ignore: cast_nullable_to_non_nullable
              as List<Contract>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContrahentImpl implements _Contrahent {
  _$ContrahentImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'company_name') this.companyName,
      final List<Contract> contracts = const []})
      : _contracts = contracts;

  factory _$ContrahentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContrahentImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'company_name')
  final String? companyName;
  final List<Contract> _contracts;
  @override
  @JsonKey()
  List<Contract> get contracts {
    if (_contracts is EqualUnmodifiableListView) return _contracts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contracts);
  }

  @override
  String toString() {
    return 'Contrahent(id: $id, name: $name, companyName: $companyName, contracts: $contracts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContrahentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            const DeepCollectionEquality()
                .equals(other._contracts, _contracts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, companyName,
      const DeepCollectionEquality().hash(_contracts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContrahentImplCopyWith<_$ContrahentImpl> get copyWith =>
      __$$ContrahentImplCopyWithImpl<_$ContrahentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContrahentImplToJson(
      this,
    );
  }
}

abstract class _Contrahent implements Contrahent {
  factory _Contrahent(
      {required final int id,
      required final String name,
      @JsonKey(name: 'company_name') final String? companyName,
      final List<Contract> contracts}) = _$ContrahentImpl;

  factory _Contrahent.fromJson(Map<String, dynamic> json) =
      _$ContrahentImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'company_name')
  String? get companyName;
  @override
  List<Contract> get contracts;
  @override
  @JsonKey(ignore: true)
  _$$ContrahentImplCopyWith<_$ContrahentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
