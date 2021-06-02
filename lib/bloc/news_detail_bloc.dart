

import 'dart:async';

import 'package:news_app/database/dbProvider.dart';
import 'package:news_app/model/library.dart';
import 'package:news_app/model/news_repository.dart';

import '../api_response.dart';



class NewsBloc {
  
 NewsRepository newsRepository;
  StreamController _newsListController;
  StreamSink<ApiResponse<List<News>>> get _newsListSink =>
      _newsListController.sink;
  
  Stream<ApiResponse<List<News>>> get newsListStream =>
      _newsListController.stream;

  NewsBloc() {
    _newsListController = StreamController<ApiResponse<List<News>>>();
    newsRepository = NewsRepository();
    fetchNewsList();
  }
  
  
  fetchNewsList() async {
    _newsListSink.add(ApiResponse.loading('Fetching News'));
    try {
       await newsRepository.fetchMovieList();
      List<News> news = await DBProvider.db.newsList();
      _newsListSink.add(ApiResponse.completed(news));
    } catch (e) {
      _newsListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
  dispose() {
    _newsListController?.close();
  }
}