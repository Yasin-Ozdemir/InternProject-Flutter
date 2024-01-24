// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'news_cubit.dart';

@immutable
abstract class NewsState {
  const NewsState();
}

class NewsInitialState extends NewsState {
  const NewsInitialState();
}

class NewsLoadedState extends NewsState {
  late List<Articles>? newsList;

  NewsLoadedState({this.newsList});

  List<Articles>? get newListGetter => newsList;
}

class SelectedCategoryState extends NewsState {
  List<Articles> newsList2;
  SelectedCategoryState({required this.newsList2});

  List<Articles> get newListGetter2 => newsList2;
}
