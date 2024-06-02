import 'package:flutter/material.dart';
import 'dictionary.dart';
import 'quiz.dart';

void main() {
  runApp(const MyApp());
}

const BoxDecoration globalBackgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xffbbd2c5),
      Color(0xff536976),
      Color(0xff535876),
      Color(0xff605376),
      Color(0xff725376),
    ],
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phrasal Verbs',
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Roboto',
            ),
      ),
      routes: {
        '/dictionary': (context) => const DictionaryPage(),
        '/quiz': (context) => const QuizPage(),
      },
      home: const DictionaryPage(),
    );
  }
}
