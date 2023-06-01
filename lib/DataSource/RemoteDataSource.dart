import 'dart:convert';
import 'package:busking/DataSource/APIUrl.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'package:busking/DataSource/JsonDecode.dart';
import 'package:busking/model/BusRoute.dart';

class RemoteDataSource {
  // 최종 API 매핑 데이터(버스 목록, 노선id 목록)를 가진 BusRoute 모델 반환
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
    // API 에서 버스 번호와 노선 id 가 동시에 제공되기 때문에, 버스 목록 구성 시 노선 id 목록 구성도
    // 동시에 진행해준다.
    List<dynamic> busData = await _callBusData(keyword);
    final List<String> routeIdList = [];

    for(var bus in busData){
      routeIdList.add(bus["routeId"]);
    }

    return routeIdList;
  }

  Future<List<dynamic>> _callBusData(String keyword) async {
    // keyword 를 이용하여 버스 번호(routeName)와 노선 id(routeId) 를 가진 busData 반환
    Uri url;
    Map<String, dynamic> jsonBusData;
    List<dynamic> busData;

    url = Uri.parse(APIUrl.getBusListUrl(keyword));
    var response = await http.get(url);
    jsonBusData = jsonDecode((Xml2Json()..parse(response.body)).toParker());

    switch (JsonDecode.findStringByKeyInMap("resultCode", jsonBusData)) {
    // resultCode 0 - 데이터 호출 정상
    // 그 외 - 호출 실패
      case "0": {
        // 키워드 검색으로 반환된 버스가 하나일 경우 Json value 가 List 타입이 아닌 Map 타입으로
        // 반환되기 때문에, 아래와 같이 분기문을 작성했다.
        busData = JsonDecode.findListByKeyInMap("busRouteList", jsonBusData)
            ?? [JsonDecode.findMapByKeyInMap("busRouteList", jsonBusData)
                ?? {"routeName" : "버스 정보가 존재하지 않습니다.", "routeId" : "-"}];
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
    switch(JsonDecode.findStringByKeyInMap("resultCode", jsonRouteData)) {
      case "0": {
        routeData = JsonDecode.findListByKeyInMap("busRouteStationList", jsonRouteData) ?? [];
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
