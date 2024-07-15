import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(P2PChatApp());
}

class P2PChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P2P Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
