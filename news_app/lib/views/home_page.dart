import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/views/setting_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/category.dart';
import '../models/news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Categories> categoryList = [
    Categories("business", 'business'.tr()),
    Categories("general", 'general'.tr()),
    Categories("health", 'health'.tr()),
    Categories("science", 'science'.tr()),
    Categories("sports", 'sport'.tr())
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ));
                },
                icon: Icon(Icons.settings))
          ],
          title: Text(
            "News App",
            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w900),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: BlocConsumer<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsInitialState) {
              context.read<NewsCubit>().getNews();
              return CircularProgressIndicator();
            } else if (state is NewsLoadedState) {
              return Column(
                children: [
                  CategoryBox(categoryList: categoryList),
                  NewsList(
                    newList: state.newListGetter ?? [],
                  )
                ],
              );
            } else if (state is SelectedCategoryState) {
              return Column(
                children: [
                  CategoryBox(categoryList: categoryList),
                  NewsList(
                    newList: state.newListGetter2,
                  ),
                ],
              );
            } else {
              return Text("ERROR");
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({
    super.key,
    required this.newList,
  });
  final List<Articles> newList;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: newList.length,
        itemBuilder: (context, index) {
          return Card(
            //color: Colors.white60,
            elevation: 3,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: ClipRRect(
                    child: Image.network(
                      "${newList[index].urlToImage}",
                      fit: BoxFit.fill,
                      width: 400,
                      height: 250,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "${newList[index].title}",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "${newList[index].description}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 248.0),
                  child: TextButton(
                      onPressed: () async {
                        await launchUrl(Uri.parse(newList[index].url ?? ''));
                      },
                      child: Text(
                        'go to news'.tr(),
                        style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w900),
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  const CategoryBox({
    super.key,
    required this.categoryList,
  });

  final List<Categories> categoryList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<NewsCubit>().getCategoryNews(categoryList[index].key);
                  },
                  child: Text(
                    "${categoryList[index].title}",
                    style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w800),
                  ))
            ],
          );
        },
      ),
    );
  }
}
/*else if (state is SelectedCategoryState) {
              return Column(
                children: [
                  CategoryBox(categoryList: categoryList),
                  NewsList(
                    newList: state.newListGetter2,
                  ),
                ],
              );
            }*/

            //CategoryBox(categoryList: categoryList),