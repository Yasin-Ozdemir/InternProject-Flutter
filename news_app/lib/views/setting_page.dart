import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/thema_cubit.dart';
import 'package:news_app/firebase/firebase_service.dart';
import 'package:news_app/localization_checker.dart';
import 'package:news_app/views/sign_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final suggestionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /* leading: TextButton(
              onPressed: () {
                LocalizationChecker.turkishLanguage(context);
              },
              child: Text("TR")),*/
          actions: [
            //TextButton(onPressed: (LocalizationChecker.changeLanguage(context)), child: Text("TR")),
            TextButton(
                onPressed: () {
                  LocalizationChecker.turkishLanguage(context);
                },
                child: Text(
                  "TR",
                  style: TextStyle(fontWeight: FontWeight.w700),
                )),
            TextButton(
                onPressed: () {
                  LocalizationChecker.englishLanguage(context);
                },
                child: Text(
                  "ENG",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ))
            /*  DropdownButton(
                items: [DropdownMenuItem(child: Text("TR")), DropdownMenuItem(child: Text("ENG"))],
                onChanged: //LocalizationChecker.changeLanguage(context)
                )*/
          ],
          title: Text(
            "News App",
            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: TextField(
                controller: suggestionController,
                maxLines: 5,
                decoration: InputDecoration(hintText: 'suggestion'.tr()),
              ),
            ),
            TextButton(
                onPressed: () {
                  FirebaseService().registerSuggestion(suggestion: suggestionController.text);
                },
                child: Text('send'.tr())),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseService().logOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => SignPage(),
                      ),
                      (route) => false);
                },
                child: Text(
                  'logout'.tr(),
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              ),
            ),
          ],
        ),
        bottomNavigationBar: FloatingActionButton.large(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            BlocProvider.of<ThemeCubit>(context, listen: false).changeTheme();
          },
          child: Column(
            children: [
              Icon(
                Icons.change_circle,
                color: Colors.white,
              ),
              Text(
                'change theme'.tr(),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ));
  }
}
