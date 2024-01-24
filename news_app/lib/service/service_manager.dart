import 'package:dio/dio.dart';
import 'package:news_app/models/news.dart'; 

class ServiceManager {
  Future<List<Articles>?> fetchNews(String category) async {
    final response = await Dio().get(
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=13f8c8aa09c74818bc1b69d729295648");
    if (response.statusCode == 200) {
      final news = News.fromJson(response.data);

      return news.articles;
    } else {
      return null;
    }
  }
}
