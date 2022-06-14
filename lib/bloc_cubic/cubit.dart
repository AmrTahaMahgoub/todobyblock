import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todobyblock/bloc_cubic/states.dart';

import '../archievelayout.dart';
import '../donelayouts.dart';
import '../tasklayouts.dart';

//
class Todocubit extends Cubit<Todostates> {
  Todocubit() : super(Todoinitialstate());
  int Currentindex = 0;
  List<Widget> layouts = [TaskLayouts(), DoneLayouts(), ArchivedLayouts()];
  List<String> titles = ['NEW TASK', ' DONE TASKS', ' ARCHIEVED TASKS'];
  void changecurrentstate(int index) {
    Currentindex = index;
    emit(ChangeButtonNav());
  }

  Database? database;

  List<Map> newtasks = [];
  List<Map> donetask = [];
  List<Map> archivedtask = [];

  static Todocubit get(context) {
    return BlocProvider.of(context);
  }

  void createdatabase() {
    openDatabase('todo.db', version: 1,
        onCreate: (Database database, int version) async {
      print('database created');
      await database.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)');
    }, onOpen: (database) {
      print('data opened');
      getdatafromdatabase(database);
    }).then((value) {
      database = value;
      emit(Createtododatabase());
    });
  }

  void insertDataBase({String? task, String? time, String? date}) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, time, date, status) VALUES("$task", "$time", "$date","new")')
          .then((value) {
        print('$value inserted in success');
        emit(Inserttododatabase());
        getdatafromdatabase(database);
      });

      return null;
    });
  }

  void getdatafromdatabase(database) {
    newtasks = [];
    donetask = [];
    archivedtask = [];

    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((e) {
        if (e['status'] == 'new') {
          newtasks.add(e);
        } else if (e['status'] == 'done') {
          donetask.add(e);
        } else {
          archivedtask.add(e);
        }
      });

      emit(Gettododatabase());
    });
  }

  void updatetasks({required String status, required int id}) async {
    database?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getdatafromdatabase(database);
      emit(Updatetododatabase());
    });
  }

  void deletetasks({required int id}) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getdatafromdatabase(database);
      emit(Deletetododatabase());
    });
  }

  bool isPressed = false;
  void toggleIspressed(bool IsShown) {
    isPressed = !isPressed;
    emit(Toggleboolian());
  }
}
