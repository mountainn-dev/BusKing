import 'dart:convert';
import 'package:busking/APIKey.dart';
import 'package:busking/APIUrl.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:busking/JsonDecode.dart';

class BusRoute{
  final String? routeID;

  BusRoute({
    required this.routeID
});

  factory BusRoute.fromJson(Map<String, dynamic> routeData) {
    return BusRoute(routeID: JsonDecode.findStringByKeyInMap('routeId', routeData));
  }

  static Future<List<String>> callBusList(String keyword) async {
    // api url 이용하여 버스 json 데이터 호출
    Uri url;
    Map<String, dynamic> jsonBusData;
    List<dynamic> busData;
    final List<String> busList = [];

    url = Uri.parse(APIUrl.getBusListUrl(keyword));
    var response = await http.get(url);
    jsonBusData = jsonDecode((Xml2Json()..parse(response.body)).toParker());
    busData = JsonDecode.findListByKeyInMap("busRouteList", jsonBusData) ?? [];
    for(var bus in busData){
      busList.add(bus["routeName"]);
    }

    return busList;
  }
}