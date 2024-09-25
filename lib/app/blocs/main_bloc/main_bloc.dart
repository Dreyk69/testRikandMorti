import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/character.dart';
import '../../../domain/usecases/get_characters.dart';
part 'main_event.dart';
part 'main_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final GetCharacters _getCharacters;
  int currentPage = 1;

  MainPageBloc(super.initialState, this._getCharacters) {
    on<GetDataOnMainPageEvent>(_getDataOnMainPage);
    on<LoadingDataOnMainPageEvent>(
      (event, emitter) => emitter(LoadingMainPageState()),
    );
  }

  Future<void> _getDataOnMainPage(
    GetDataOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    emit(LoadingMainPageState());

    try {
      final characters = await _getCharacters.execute(event.page);

      if (characters == null || characters.isEmpty) {
        emit(UnSuccessfulMainPageState());
      } else {
        currentPage = event.page;
        emit(SuccessfulMainPageState(characters, currentPage));
      }
    } catch (error) {
      emit(UnSuccessfulMainPageState());
    }
  }
}
