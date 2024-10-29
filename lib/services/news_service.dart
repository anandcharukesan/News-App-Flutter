import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/constants/themes.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:http/http.dart' as http;

class NewsDb extends GetxController {
  Future<List<NewsController>> newsFetch(String query) async {
    if (query.isEmpty) {
      print("test if");
      SnackBar(
        content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: black,
            ),
            child: Text("yrdyr")),
        duration: Duration(seconds: 5),
      );
      return List.empty();
    }
    http.Response news = await http.get(Uri.tryParse(
        'https://newsapi.org/v2/everything?q=$query&apiKey=9e1eb7a3c8ff4795b37c724f2775dac5')!);

    Map<String, dynamic> newsJson = jsonDecode(news.body);
    List<dynamic> newsList = newsJson['articles'];
    List<NewsController> newsOutput =
        newsList.map((dynamic e) => NewsController.fromJson(e)).toList();

    print(newsList);

    return newsOutput;
  }
}
