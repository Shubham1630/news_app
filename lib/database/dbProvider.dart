
import 'dart:io';
import 'package:news_app/model/library.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'news_list.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE News(author TEXT)',
          );
        });
  }


  createNewsTable(News news) async {
    await deleteAllNews();
    final db = await database;

    try {
      final res = await db.insert('News', news.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
      print(res);
      return res;
    } catch (e) {
      print(e);
    } finally {

    }


  }


  Future<int> deleteAllNews() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM News');

    return res;
  }

  Future<List<News>> getAllNews() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM News");

    List<News> list =
    res.isNotEmpty ? res.map((c) => News.fromJson(c)).toList() : [];

    return list;
  }
}