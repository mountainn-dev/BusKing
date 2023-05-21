import 'package:flutter/material.dart';
import 'package:busking/model/BusRoute.dart';
import 'package:busking/RoutePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BusKing',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'BusKing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _editController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "BusNumber"
                ),
              ),
              TextButton(
                  onPressed: () async {
                    final busList = await BusRoute.callBusList(_editController.text);   // TODO: 리스트랑 같이 화면 넘기는 기능 필요
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RoutePage(busList: busList)
                    ));
              },
                  child: Text("확인"))
            ],
          ),
        ),
      ),
    );
  }
}
