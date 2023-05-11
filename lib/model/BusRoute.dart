import 'dart:convert';

import 'package:busking/APIKey.dart';
import 'package:http/http.dart' as http;

class BusRoute{
  final String routeID;

  BusRoute({
    required this.routeID
});

  factory BusRoute.fromJson(Map<String, dynamic> routeId) {
    return BusRoute(
      routeID: routeId['routeId']
    );
  }

  void getRoute() async {
    var url = Uri.parse(
        "http://apis.data.go.kr/6410000/busrouteservice/getBusRouteStationList?serviceKey=${APIKey.getRouteKey()}&routeId=$routeID"
    );

    var response = await http.get(url);
    var routeData = jsonDecode(response.body);
    print(routeData['stationName']);

  }
}