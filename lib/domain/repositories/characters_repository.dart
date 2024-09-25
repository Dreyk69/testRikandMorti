import '../../data/models/character.dart';

abstract class CharactersRepository {
  Future<List<Character>?> getCharacters(int page);
}