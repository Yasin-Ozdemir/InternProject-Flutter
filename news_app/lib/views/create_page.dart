import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_service.dart';
import 'sign_page.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final firebaseManager = FirebaseService();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "News App",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                  child: TextField(
                controller: nameController,
                maxLength: 30,
                decoration: InputDecoration(hintText: 'name'.tr(), prefixIcon: Icon(Icons.supervised_user_circle)),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 11.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await firebaseManager.createUser(
                        name: nameController.text, email: mailController.text, password: passwordController.text);
                    if (firebaseManager.flag == true) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SignPage(),
                      ));
                    }
                  },
                  child: Text('create user'.tr())),
            )
          ],
        ));
  }
}
