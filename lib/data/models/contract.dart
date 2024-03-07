import 'package:freezed_annotation/freezed_annotation.dart';

part 'contract.freezed.dart';
part 'contract.g.dart';

@freezed
class Contract with _$Contract {
  factory Contract({
    required int id,
    @JsonKey(name: 'contrahent_id') required String contrahentId,
    required String name,
    required String number,
  }) = _Contract;

  // factory Contract.fromJson(Map<String, dynamic> json) =>
  //     _$ContractFromJson(json);

  factory Contract.fromJson(Map<String, dynamic> json) {
    try {
      return _$ContractFromJson(json);
    } catch (e) {
      return Contract(id: -1, contrahentId: '', name: 'Unknown', number: '');
    }
  }
}
