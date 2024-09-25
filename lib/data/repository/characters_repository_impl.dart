import 'package:kdigital_test_task/domain/repositories/characters_repository.dart';

import '../../infrastructure/api/service_api.dart';
import '../models/character.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharacterRemoteDatasource remoteDatasource;

  CharactersRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Character>?> getCharacters(int page, {bool simulateError = false}) async {
    try {
      final characters = await remoteDatasource.getCharacters(page, simulateError: simulateError);
      return characters;
    } catch (e) {
      print('Error loading characters: $e');
      return null;
    }
  }
}
