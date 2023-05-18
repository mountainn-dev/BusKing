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

  String? findValueByKeyInMap(String k, Map<String, dynamic> m) {
    String? result;
    final type = (jsonDecode('{"A" : "B"}')).runtimeType;   // _Map<String, dynamic>

    for (var key in m.keys) {
      if (m[key].runtimeType == type) result = findValueByKeyInMap(k, m[key]);   // Map 형태의 value 일 경우 순환함수
      else if (m[key].runtimeType == String && key == k) result = m[key];   // String value 이고 targetKey 와 일치할 경우
      if (result != null) break;
    }

    return result;
  }
}