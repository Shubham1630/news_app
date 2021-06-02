

import 'dart:convert';

import 'package:news_app/database/dbProvider.dart';

class Library {
   List<News> news;

  Library({this.news});

  Library.fromJson(Map<String, dynamic> json){
    if (json['articles'] != null) {
      news = [];
      json['articles'].forEach((v) {
        DBProvider.db.createNewsTable(News.fromJson(v));
        news.add(new News.fromJson(v));
      });

    }

  }

}

class News {
   String author;
   String title;
   String description;
   String url;
   String urlToImage;
   String publishedAt;
   String content;



  factory News.fromJson(Map<String, dynamic> json) =>
      News(author:json["author"], title:json["title"], description:json["description"],
          url:json["url"],urlToImage:json["urlToImage"],publishedAt:json["publishedAt"],content:json["content"]);

   Map<String, dynamic> toJson() =>
      {"author": author, "title": title, "description": description, "urlToImage": urlToImage, "publishedAt":publishedAt, "content":content};

  News({this.author, this.title, this.description, this.url,this.urlToImage,this.publishedAt,this.content});
}
