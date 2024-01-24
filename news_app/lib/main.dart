import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/thema_cubit.dart';
import 'package:news_app/views/home_page.dart';
import 'package:news_app/views/setting_page.dart';
import 'cubit/news_cubit.dart';
import 'firebase_options.dart';
import 'views/create_page.dart';
import 'views/sign_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(EasyLocalization(
    supportedLocales: [Locale('en', 'US'), Locale('tr', 'TR')],
    path: 'assets/translations',
    fallbackLocale: Locale('en', 'US'),
    child: MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ThemeCubit(),
      )
    ], child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: BlocProvider.of<ThemeCubit>(context, listen: true).isLight
          ? ThemeData.light(useMaterial3: true)
          : ThemeData.dark(useMaterial3: true),
      home: SignPage(),
    );
    /*child: MaterialApp(
          title: 'Flutter Demo',
          
          theme: ThemeData.light(
            //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SignPage(),
        ),*/
  }
}
