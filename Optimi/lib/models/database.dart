import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class OptimiDatabase {
  late Database database;
  bool userStatus = false;
  var db;

  Future initSQLite() async {
    try {
      db = await openDatabase('optimiDatabase.db', version: 1);

      await db.execute(
          'CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY, username TEXT UNIQUE,'
          ' password TEXT, firstname TEXT, surname TEXT, user_id INTEGER )');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<dynamic> getUserRecord(String username) async {
    try {
      await initSQLite();
      List<Map> list = await db
          .rawQuery('SELECT * FROM User WHERE username = ?', [username]);
      if (list.isNotEmpty) {
        return list;
      } else {
        return list;
      }
    } catch (e) {
      return;
    }
  }

  Future<void> createUserRecord(
      username, password, firstName, lastName, userId) async {
    try {
      await initSQLite();
      try {
        await db.transaction((txn) async {
          int id2 = await txn.rawInsert(
              'INSERT INTO User(username, password, firstname,'
              ' surname, user_id) VALUES(?, ?, ?, ?, ?)',
              [username, password, firstName, lastName, userId]);
        });
      } catch (e) {
        if (kDebugMode) {
          print("insertError $e");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("insertHERE");
      }
    }
  }

  getAllRecords() async {
    try {
      await initSQLite();
      List<Map> list = await db.rawQuery('SELECT * FROM User ORDER BY id DESC');
      if (list.isNotEmpty) {
        return list;
      } else {
        return list;
      }
    } catch (e) {
      return;
    }
  }
}
