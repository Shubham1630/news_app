

import 'package:flutter/material.dart';
import 'package:news_app/database/dbProvider.dart';
import 'package:news_app/model/library.dart';
import 'package:news_app/model/news_repository.dart';

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

  List<News> news = [];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: ListView.builder(
            itemCount : news.length,
            itemBuilder: (_,index){
              return ListTile(
                title: Text(news[index].title),
              );
            } )
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    var newsRepository = NewsRepository();

    for(int i = 0; i<10; i++){
      News newsw = new News();
      newsw.author = "hi";
      DBProvider.db.createNewsTable(newsw);
    }

print(DBProvider.db.getAllNews().toString());
    newsRepository.fetchMovieList().then((value) {
      news = value;
      setState(() {

      });
    }

    );
    setState(() {
      print(news.toString());
      List newsFromDb = [];

    });

  }
}
