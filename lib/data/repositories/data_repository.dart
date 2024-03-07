import 'dart:developer';

import 'package:rfid77workflow/data/api/api_provider.dart';
import 'package:rfid77workflow/data/models/contrahent.dart';
import 'package:rfid77workflow/data/models/user.dart';

abstract class DataRepositoryAbstract {
  Future<List<User>> getUsers();
  Future<List<Contrahent>> getContrahents();
}

class DataRepository extends DataRepositoryAbstract {
  DataRepository._(this._apiProvider);

  static Future<DataRepository> instance() async {
    final api = await ApiProvider.instance();
    return DataRepository._(api);
  }

  final ApiProvider _apiProvider;

  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await _apiProvider.fetchUsers();
      final data = response.data as Map<String, dynamic>;
      final usersJsonList = data['data'] as List<dynamic>;
      final users = usersJsonList
          .map((userJson) => User.fromJson(userJson as Map<String, dynamic>))
          .toList();
      return users;
    } catch (e) {
      log('Error fetching users: $e');
      rethrow;
    }
  }

  @override
  Future<List<Contrahent>> getContrahents() async {
    try {
      final response = await _apiProvider.fetchContrahents();
      final data = response.data as Map<String, dynamic>;
      final contrahentsJsonList = data['data'] as List<dynamic>;

      final contrahents = contrahentsJsonList
          .map((contrahentJson) {
            // Filter out contracts with id == -1 as they are not valid
            final contrahent = Contrahent.fromJson(
              contrahentJson as Map<String, dynamic>,
            );

            final filteredContracts = contrahent.contracts
                .where((contract) => contract.id != -1)
                .toList();

            return contrahent.copyWith(contracts: filteredContracts);
          })
          .where(
            // Filter out contrahents with no contracts or with id == -1 as they are not valid
            (contrahent) =>
                contrahent.contracts.isNotEmpty && contrahent.id != -1,
          )
          .toList();

      return contrahents;
    } catch (e) {
      log('Error fetching contrahents: $e');
      rethrow;
    }
  }
}
