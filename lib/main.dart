import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobyblock/task_screen.dart';
import 'bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
  MyBlocObserver();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskScreen(),
    );
  }
}
