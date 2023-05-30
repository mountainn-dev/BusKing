import 'dart:convert';
import 'package:busking/DataSource/APIUrl.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:busking/DataSource/JsonDecode.dart';
import 'package:busking/model/BusRoute.dart';

class RemoteDataSource {
  Future<BusRoute> getBusData(String keyword) async {
    List<String> busList = await _callBusList(keyword);
    List<String> routeIdList = await _callRouteIdList(keyword);

    return BusRoute(busList: busList, routeIdList: routeIdList);
  }

  Future<List<String>> _callBusList(String keyword) async {
    // user keyword 이용하여 버스 목록 json 데이터 호출 및 리스트 추출
    List<dynamic> busData = await _callBusData(keyword);
    final List<String> busList = [];

    for(var bus in busData){
      busList.add(bus["routeName"]);
    }

    return busList;
  }

  Future<List<String>> _callRouteIdList(String keyword) async {
    // user keyword 이용하여 노선ID 목록 json 데이터 호출 및 리스트 추출
    List<dynamic> busData = await _callBusData(keyword);
    final List<String> routeIdList = [];

    for(var bus in busData){
      routeIdList.add(bus["routeId"]);
    }

    return routeIdList;
  }

  Future<List<dynamic>> _callBusData(String keyword) async {
    Uri url;
    Map<String, dynamic> jsonBusData;
    List<dynamic> busData;


    url = Uri.parse(APIUrl.getBusListUrl(keyword));
    var response = await http.get(url);
    jsonBusData = jsonDecode((Xml2Json()..parse(response.body)).toParker());

    switch (JsonDecode.findStringByKeyInMap("resultCode", jsonBusData)) {
      case "0": {
        // 버스 목록이 하나일 경우 Json value 가 List 타입이 아닌 Map 타입으로 반환된다.
        busData = JsonDecode.findListByKeyInMap("busRouteList", jsonBusData)
            ?? [JsonDecode.findMapByKeyInMap("busRouteList", jsonBusData)
                ?? {"routeName" : "버스가 존재하지 않습니다.", "routeId" : "-"}];
        break;
      }
      default : {
        busData = [{"routeName" : "버스가 존재하지 않습니다.", "routeId" : "-"}];
      }
    }

    return busData;
  }

  Future<List<String>> _callStationList(String routeId) async {
    // routeId 이용하여 버스 정류장 데이터 호출 및 리스트 추출
    Uri url;
    Map<String, dynamic> jsonRouteData;
    List<dynamic> routeData;
    final List<String> stationList = [];

    url = Uri.parse(APIUrl.getStationListUrl(routeId));
    var response = await http.get(url);
    jsonRouteData = jsonDecode((Xml2Json()..parse(response.body)).toParker());
    routeData = JsonDecode.findListByKeyInMap("busRouteStationList", jsonRouteData) ?? [];

    for (var station in routeData) {
      stationList.add(station["stationName"]);
    }

    return stationList;
  }
}
