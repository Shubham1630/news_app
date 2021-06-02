
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
          await  db.execute(
            'CREATE TABLE news(author TEXT, title TEXT, description TEXT, url TEXT, urlToImage TEXT, publishedAt TEXT, content TEXT )',
          );
        });
  }


  createNewsTable(News news) async {
    final db = await database;

    await db.insert(
      'news',
      news.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final List<Map<String, dynamic>> maps = await db.query('news');
    print(maps.toString());

  }

  Future<List<News>> newsList() async {

    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('news');

    return List.generate(maps.length, (i) {
      return News(
        author: maps[i]['author'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        url: maps[i]['url'],
        urlToImage: maps[i]['urlToImage'],
        publishedAt: maps[i]['publishedAt'],
        content: maps[i]['content'],

      );
    });
  }



}