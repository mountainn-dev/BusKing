import 'package:flutter/material.dart';
import 'package:busking/Screen/SelectionBusPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BusKing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelectionBusPage(),
    );
  }
}