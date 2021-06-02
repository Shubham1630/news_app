

import 'dart:convert';

import 'package:news_app/database/dbProvider.dart';

class Library {
  //  List<News> news;
  //
  // Library({this.news});
  //
  // Library.fromJson(Map<String, dynamic> json){
  //   if (json['articles'] != null) {
  //     news = [];
  //     json['articles'].forEach((v) {
  //       DBProvider.db.createNewsTable(News.fromJson(v));
  //       print("hello");
  //       news.add(new News.fromJson(v));
  //     });
  //
  //   }
  //
  // }

}

class Dog {
  final String name;
  final int age;

  Dog({
    this.name,
    this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{ name: $name, age: $age}';
  }
}
