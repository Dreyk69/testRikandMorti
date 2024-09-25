import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/character.dart';

abstract class CharacterRemoteDatasource {
  Future<List<Character>> getCharacters(int page, {bool simulateError = false});
}

class CharacterRemoteDatasourceImpl implements CharacterRemoteDatasource {
  final http.Client client;

  CharacterRemoteDatasourceImpl(this.client);

  @override
  Future<List<Character>> getCharacters(int page, {bool simulateError = false}) async {
    if (simulateError) {
      return Future.delayed(
        const Duration(seconds: 1),
        () => throw Exception('Simulated error'),
      );
    }

    final response = await client.get(
      Uri.parse("https://rickandmortyapi.com/api/character/?page=$page"),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load characters, status code: ${response.statusCode}');
    }

    final jsonMap = json.decode(response.body) as Map<String, dynamic>;
    return List.of(
      (jsonMap["results"] as List<dynamic>).map(
        (value) => Character.fromJson(value),
      ),
    );
  }
}