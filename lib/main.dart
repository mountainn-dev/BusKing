import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:busking/APIKey.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  final APIKey key = APIKey();
  var keyWord;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _callAPI() async {
    var url = Uri.parse(
        "http://apis.data.go.kr/6410000/busrouteservice/getBusRouteList?serviceKey=${key.getKey()}&keyword=$keyWord");

    var response = await http.get(url);
    print("status: ${response.statusCode}");
    print("body: ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: (){
                  keyWord = "720-2";
                },
                child: Text(
                  "720-2",
                  style: TextStyle(
                    fontSize: 20
                  ))),
            TextButton(
                onPressed: (){
              _callAPI();
            },
                child: Text("확인"))
          ],
        ),
      ),
    );
  }
}
