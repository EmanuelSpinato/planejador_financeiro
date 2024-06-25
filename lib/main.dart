import 'package:flutter/material.dart';

import 'views/home_view.dart';

void main() {
  runApp(MyApp());
}

// Classe principal do aplicativo Flutter
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planejador Financeiro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}
