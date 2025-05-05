import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:PV/home.dart';

const BoxDecoration globalBackgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xff4e3a7d),
      Color(0xff6f4aa5),
      Color(0xff9c6dc2),
      Color(0xffcda4de),
      Color(0xffe9d8f7),
    ],
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const VerbsioApp());
}

class VerbsioApp extends StatelessWidget {
  const VerbsioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phrasal Verbs',
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Roboto'),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
