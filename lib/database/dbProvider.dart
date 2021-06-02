
import 'dart:io';
import 'package:news_app/model/library.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  //   Future<Database> get database async {
  //   // If database exists, return database
  //   if (_database != null) return _database;
  //
  //   // If database don't exists, create one
  //   _database = await initDB();
  //
  //   return _database;
  // }


  // initDB() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   final path = join(documentsDirectory.path, 'news_list.db');
  //
  //   return await openDatabase(path, version: 1, onOpen: (db) {},
  //       onCreate: (Database db, int version) async {
  //         await db.execute(
  //           'CREATE TABLE News(author TEXT)',
  //         );
  //       });
  // }


  createNewsTable(News news) async {
    final database = openDatabase(

      join(await getDatabasesPath(), 'news_database.db'),

      onCreate: (db, version) {

        return db.execute(
          'CREATE TABLE news(author TEXT, title TEXT, description TEXT, url TEXT, urlToImage TEXT, publishedAt TEXT )',
        );
      },
      version: 1,
    );

    final db = await database;

    await db.insert(
      'news',
      news.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final List<Map<String, dynamic>> maps = await db.query('news');
    print(maps.toString());

  }

  // Future<void> insertDog(News dog) async {
  //
  //   final db = await database;
  //
  //
  //   await db.insert(
  //     'dogs',
  //     dog.toJson(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
  //
  // // A method that retrieves all the dogs from the dogs table.
  // Future<List<News>> dogs() async {
  //   // Get a reference to the database.
  //   final db = await database;
  //
  //   // Query the table for all The Dogs.
  //   final List<Map<String, dynamic>> maps = await db.query('dogs');
  //
  //   // Convert the List<Map<String, dynamic> into a List<Dog>.
  //   return List.generate(maps.length, (i) {
  //     return News(
  //       author: maps[i]['author'],
  //     );
  //   });
  // }
  //
  //
  // Future<void> deleteDog(int id) async {
  //   // Get a reference to the database.
  //   final db = await database;
  //
  //   // Remove the Dog from the database.
  //   await db.delete(
  //     'dogs',
  //     // Use a `where` clause to delete a specific dog.
  //     where: 'id = ?',
  //     // Pass the Dog's id as a whereArg to prevent SQL injection.
  //     whereArgs: [id],
  //   );
  // }


}