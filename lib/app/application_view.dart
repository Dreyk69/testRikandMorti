import 'package:flutter/material.dart';

import '../presentation/character_screen/character_screen.dart';

class ApplicationView extends StatelessWidget {
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Test app',
        home: CharactersScreen());
  }
}