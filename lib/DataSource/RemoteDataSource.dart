import 'dart:convert';
import 'package:busking/DataSource/APIUrl.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:busking/DataSource/JsonDecode.dart';
import 'package:busking/model/BusRoute.dart';

class RemoteDataSource {
  // BusRoute 모델 리스트를 가진 busList 반환
  Future<List<BusRoute>> getBus(String keyword) async {
    List<dynamic> busData = await _callBusData(keyword);
    List<BusRoute> busList = [];
    for (int i = 0; i < busData.length; i++) {
      busList.add(BusRoute.fromJson(busData[i]));
    }

    return busList;
  }

  Future<List<dynamic>> _callBusData(String keyword) async {
    // keyword 를 이용하여 버스 번호(routeName)와 노선 id(routeId) 목록을 가진 busData 반환
    Uri url;
    Map<String, dynamic> jsonBusData;
    List<dynamic> busData;

    url = Uri.parse(APIUrl.getBusListUrl(keyword));
    var response = await http.get(url);
    jsonBusData = jsonDecode((Xml2Json()..parse(response.body)).toParker());

    switch (JsonDecode.findStringByKey("resultCode", jsonBusData)) {
    // resultCode 0 - 데이터 호출 정상
    // 그 외 - 호출 실패
      case "0": {
        // 키워드 검색으로 반환된 버스가 하나만 존재할 경우 Json value 가 List 타입이 아닌
        // Map 타입으로 반환되기 때문에, 아래와 같이 분기문을 진행한다.
        busData = JsonDecode.findListByKey("busRouteList", jsonBusData);
        if (busData.length == 0)
          busData = [JsonDecode.findMapByKey("busRouteList", jsonBusData)];
        break;
      }
      default: {
        busData = [{"routeName" : "버스 정보가 존재하지 않습니다.", "routeId" : "-"}];
      }
    }

    return busData;
  }

  Future<List<String>> _callStationList(String routeId) async {
    // 노선 id를 이용하여 해당 버스의 노선 목록 호출
    Uri url;
    Map<String, dynamic> jsonRouteData;
    List<dynamic> routeData;
    final List<String> stationList = [];

    url = Uri.parse(APIUrl.getStationListUrl(routeId));
    var response = await http.get(url);
    jsonRouteData = jsonDecode((Xml2Json()..parse(response.body)).toParker());
    switch(JsonDecode.findStringByKey("resultCode", jsonRouteData)) {
      case "0": {
        routeData = JsonDecode.findListByKey("busRouteStationList", jsonRouteData) ?? [];
        break;
      }
      default: {
        routeData = [{"stationName" : "노선 정보가 존재하지 않습니다.", "routeId" : "-"}];
      }
    }

    for (var station in routeData) {
      stationList.add(station["stationName"]);
    }

    return stationList;
  }
}
