import 'dart:convert';

import 'package:busking/APIKey.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class BusRoute{
  final String? routeID;

  BusRoute({
    required this.routeID
});

  factory BusRoute.fromJson(Map<String, dynamic> routeData) {
    return BusRoute(routeID: routeData['response']['msgBody']['busRouteList']['routeId']);
  }

  Future<List<dynamic>> getList() async {
    var url = Uri.parse(
        "http://apis.data.go.kr/6410000/busrouteservice/getBusRouteStationList?serviceKey=${APIKey.getRouteKey()}&routeId=$routeID"
    );

    var response = await http.get(url);
    final routeStationData = jsonDecode((Xml2Json()..parse(response.body)).toParker());

    return routeStationData['response']['msgBody']['busRouteStationList'];
  }
}