import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:country_codes/country_codes.dart';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=0180b5a9c3b240fc994414c7f09536f5";

    var response = await http.get(
      Uri.parse(url),
    );
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async {
    await CountryCodes.init();
    final Locale? deviceLocale = CountryCodes.getDeviceLocale();
    var country = deviceLocale?.countryCode;
    String url =
        "https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=0180b5a9c3b240fc994414c7f09536f5";

    var response = await http.get(
      Uri.parse(url),
    );
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
