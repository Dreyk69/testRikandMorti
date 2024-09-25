import '../../data/models/character.dart';
import '../repositories/characters_repository.dart';

class GetCharacters {
  final CharactersRepository _charactersRepository;

  GetCharacters(this._charactersRepository);

  Future<List<Character>?> execute(int page) async {
    return await _charactersRepository.getCharacters(page);
  }
}