part of 'main_bloc.dart';


abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object?> get props => [];
}

class GetDataOnMainPageEvent extends MainPageEvent {
  final int page;

  const GetDataOnMainPageEvent(this.page);

  @override
  List<Object?> get props => [page];
}

class LoadingDataOnMainPageEvent extends MainPageEvent {
  const LoadingDataOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class DataLoadedOnMainPageEvent extends MainPageEvent {
  final List<Character>? characters;
  final int page;

  const DataLoadedOnMainPageEvent(this.characters, this.page);

  @override
  List<Object?> get props => [characters, page];
}