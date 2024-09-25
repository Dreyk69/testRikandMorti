import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app/application.dart';
import 'domain/di/main_di_module.dart';

void main() {
  MainDIModule().configure(GetIt.I);
  runApp(const Application());
}
