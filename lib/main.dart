import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:PV/home.dart';

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
        cardTheme: CardTheme(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.black.withAlpha(100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
            side: BorderSide(color: Colors.blueGrey.withAlpha(100)),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
