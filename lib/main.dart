

import 'package:flutter/material.dart';
import 'package:news_app/database/dbProvider.dart';
import 'package:news_app/model/news_repository.dart';

import 'model/library.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List news = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Text("data")
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState()  {

    getDataFromApiDataBase();

  }

  Future<void> getNewsListFromDataBase() async {
    news =  await DBProvider.db.newsList();
    print("from database"+ news.toString());
    setState(() {

    });
  }

  void getDataFromApiDataBase() async {

    var newsRepo = new NewsRepository();

    await newsRepo.fetchMovieList();
    getNewsListFromDataBase();

  }
}



