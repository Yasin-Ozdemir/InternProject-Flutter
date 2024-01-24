import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/models/news.dart';

import '../service/service_manager.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());
  final serviceManager = ServiceManager();

  Future<void> getNews() async {
    try {
      List<Articles>? newsList = await serviceManager.fetchNews("");
      if (newsList != null) {
        emit(NewsLoadedState(newsList: newsList));
      } else {
        print("Get News Error");
      }
    } catch (e) {
      print("error");
    }
  }

  Future<void> getCategoryNews(String category) async {
    try {
      emit(NewsLoadedState());
      List<Articles>? categoryList = await serviceManager.fetchNews(category);
      if (categoryList != null) {
        emit(SelectedCategoryState(newsList2: categoryList));
      } else {
        print("Get Category Error");
      }
    } catch (e) {
      print("error");
    }
  }
}
