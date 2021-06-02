

import 'package:flutter/material.dart';
import 'package:news_app/database/dbProvider.dart';
import 'package:news_app/model/news_repository.dart';

import 'api_response.dart';
import 'bloc/news_detail_bloc.dart';
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
      home: MyHomePage(title: 'News',),
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

  NewsBloc _newsBloc;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () => _newsBloc.fetchNewsList(),

        child: StreamBuilder<ApiResponse<List<News>>>(
          stream: _newsBloc.newsListStream,
          builder: (context,snapshot){
            if(snapshot.hasData){
              switch (snapshot.data.status){
                case Status.COMPLETED:
                  List<News> newsList = snapshot.data.data;
                  return ListView.builder(
                    itemCount: newsList.length,

                      itemBuilder: (BuildContext context,int index){

                        return
                          ListTile(
                            leading: Expanded(
                              child: newsList[index].urlToImage != null ? Image.network(newsList[index].urlToImage,fit: BoxFit.fitHeight,

                              ):Text("data"),
                            ),
                            // newsList[index].author
                          title:
                          Expanded(child: newsList[index].author != null?
                          Text( newsList[index].author,overflow: TextOverflow.ellipsis ,):Text("data")),
                            subtitle: newsList[index].title != null ?
                            Expanded(
                              child:
                              Text(newsList[index].title +"\n" + newsList[index].content +"\n"+ newsList[index].description + "\n"+
                                  newsList[index].publishedAt,maxLines: 10,overflow: TextOverflow.ellipsis,),
                            ):Text("data"),
                        );


                  });


                case Status.LOADING:
                  // TODO: Handle this case.
                  break;
                case Status.ERROR:
                  // TODO: Handle this case.
                  break;
              }

            }
            return Container();
          } ,

        ),

      )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState()  {

    _newsBloc = NewsBloc();


  }



}



