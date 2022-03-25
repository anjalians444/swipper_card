import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'models/data.dart';

import './main.dart';

class DataBaseHelper {
  static final _dbName = "Database.db";
  static final _dbVersion = 1;
  static final _tableName = "dataTable";

  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    return db.execute('''
    CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, url TEXT ,option TEXT,lat REAL,lon REAL,area INTEGER,density REAL,category TEXT)
    ''');
  }

  Future<int> insert(Data data) async {
    Database db = await instance.database;
    return await db.insert(_tableName, data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Data>> queryAll() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (index) {
      return Data(
        id: maps[index]["id"],
        title: maps[index]["title"],
        url: maps[index]["url"],
        option: maps[index]["option"],
        lat: maps[index]["lat"],
        lon: maps[index]["lon"],
        area: maps[index]["area"],
        density: maps[index]["density"],
          category: maps[index]["category"]
      );
    });
  }

  Future<void> delete(int id) async {
    Database db = await instance.database;
    await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> updateOption(Data newData) async {
    Database db = await instance.database;
    var result = await db.update(
      _tableName,
      newData.toMap(),
      where: "id = ?",
      whereArgs: [newData.id],
    );
    return result;
  }
}
