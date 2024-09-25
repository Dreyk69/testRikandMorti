import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kdigital_test_task/app/blocs/main_bloc/main_bloc.dart';

import '../domain/usecases/get_characters.dart';
import 'application_view.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainPageBloc>(
      create: (context) {
        final getCharacters = GetIt.I.get<GetCharacters>();
        final bloc = MainPageBloc(InitialMainPageState(), getCharacters);
        bloc.add(const GetDataOnMainPageEvent(1));
        return bloc;
      },
      child: const ApplicationView(),
    );
  }
}