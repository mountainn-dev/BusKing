import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:busking/APIKey.dart';
import 'package:busking/model/BusRoute.dart';
import 'package:xml2json/xml2json.dart';

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
  var keyWord;

  void _callAPI() async {
    var routeIdUrl = Uri.parse(
        "http://apis.data.go.kr/6410000/busrouteservice/getBusRouteList?serviceKey=${APIKey.getRouteKey()}&keyword=$keyWord");

    var response = await http.get(routeIdUrl);
    final Map<String, dynamic> routeData = jsonDecode((Xml2Json()..parse(response.body)).toParker());
    var busRoute = BusRoute.fromJson(routeData);

    final routeList = await busRoute.getList();
    for (var s in routeList) {
      print(s['stationName']);
    }
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
