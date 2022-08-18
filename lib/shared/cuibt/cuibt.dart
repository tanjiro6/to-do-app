import 'package:application/shared/cuibt/state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/Done/done.dart';
import '../../modules/Tasks/Tasks.dart';
import '../../modules/archived/archived.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late Database database;

  bool isBottomSheetShone = false;
  IconData febIcon = Icons.edit;

  List<Widget> screen = [
    Taskss(),
    Done(),
    Archived(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<dynamic> tasks = [];

  void CreateDatabase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
      print("database create");
      database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        print("table Created");
      }).catchError((error) {
        print('Error when create database ${error.toString()}');
      });
    }, onOpen: (database) {
      print("database on Open");
      emit(AppCreateDatabaseState());
    });
  }

  InsertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks(title,date,time,status)VALUES("$title","$time","$date","new")',
      )
          .then((value) {
        print("$value inserted Successfuly");
        emit(AppInsertDatabaseState());

        GetDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDatabaseState());
        });
      }).catchError((erorr) {
        print("Error when Inserting New Record${erorr.toString()}");
      });
    });
  }

  Future<List<Map>> GetDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShone = isShow;
    febIcon = icon;
    emit(AppChangeBottomSheteBarState());
  }
}
