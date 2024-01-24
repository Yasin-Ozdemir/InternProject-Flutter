import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/create_page.dart';
import 'package:news_app/views/home_page.dart';

import '../firebase/firebase_service.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  @override
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "News App",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'welcome title'.tr(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.blueGrey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 42),
              child: SizedBox(
                  child: TextField(
                controller: mailController,
                maxLength: 30,
                decoration: InputDecoration(hintText: "E-mail", prefixIcon: Icon(Icons.mail)),
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                  child: TextField(
                controller: passwordController,
                maxLength: 30,
                decoration: InputDecoration(hintText: 'password'.tr(), prefixIcon: Icon(Icons.password)),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseService().logIn(email: mailController.text, password: passwordController.text);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
                  },
                  child: Text('login'.tr())),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 300, top: 20),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreatePage(),
                    ));
                  },
                  child: Text('create user'.tr())),
            ),
          ],
        ));
  }
}
