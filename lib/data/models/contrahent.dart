import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rfid77workflow/data/models/contract.dart';

part 'contrahent.freezed.dart';
part 'contrahent.g.dart';

@freezed
class Contrahent with _$Contrahent {
  factory Contrahent({
    required int id,
    required String name,
    @JsonKey(name: 'company_name') String? companyName,
    @Default([]) List<Contract> contracts,
  }) = _Contrahent;

  // factory Contrahent.fromJson(Map<String, dynamic> json) =>
  //     _$ContrahentFromJson(json);

  factory Contrahent.fromJson(Map<String, dynamic> json) {
    try {
      return _$ContrahentFromJson(json);
    } catch (e) {
      return Contrahent(id: -1, name: 'Unknown', contracts: []);
    }
  }
}
