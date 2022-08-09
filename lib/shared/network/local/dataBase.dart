import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../layout/home_layout.dart';

void CreateDatabase() async {
  database =
      await openDatabase('todo.db', version: 1, onCreate: (database, version) {
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
    GetDataFromDatabase(database);
  });
}

Future InsertToDatabase({
  required String title,
  required String time,
  required String date,
}) async {
  return await database!.transaction((txn) async {
    txn
        .rawInsert(
      'INSERT INTO tasks(title,date,time,status)VALUES("$title","$time","$date","new")',
    )
        .then((value) {
      print("$value inserted Successfuly");
    }).catchError((erorr) {
      print("Error when Inserting New Record${erorr.toString()}");
    });
  });
}

GetDataFromDatabase(database) async {
  List<Map> tasks = await database!.rawQuery('SELECT * FROM tasks');
  print(tasks);
}
