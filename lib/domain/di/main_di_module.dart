import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../../infrastructure/api/service_api.dart';
import '../repositories/characters_repository.dart';
import '../../data/repository/characters_repository_impl.dart';
import '../usecases/get_characters.dart';

class MainDIModule {
  void configure(GetIt getIt) {
    final httpClient = Client();

    if (!getIt.isRegistered<CharacterRemoteDatasource>()) {
      getIt.registerLazySingleton<CharacterRemoteDatasource>(
        () => CharacterRemoteDatasourceImpl(httpClient),
      );
    }

    if (!getIt.isRegistered<CharactersRepository>()) {
      getIt.registerLazySingleton<CharactersRepository>(
        () => CharactersRepositoryImpl(getIt<CharacterRemoteDatasource>()),
      );
    }
    if (!getIt.isRegistered<GetCharacters>()) {
      getIt.registerLazySingleton<GetCharacters>(
        () => GetCharacters(getIt<CharactersRepository>()),
      );
    }
  }
}
