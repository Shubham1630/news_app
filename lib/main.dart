

import 'package:flutter/material.dart';
import 'package:news_app/database/dbProvider.dart';

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

    // Create a Dog and add it to the dogs table


    printDogs();


  }
}

void printDogs() async {
  for(int i = 0; i< 10;i++){
    var fido = Dog(
      name: 'Fido',
      age: 35,
    );
    await DBProvider.db.createNewsTable(fido);
  }


}

